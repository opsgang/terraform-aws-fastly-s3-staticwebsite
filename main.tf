data "fastly_ip_ranges" "fastly" {}

data "aws_region" "current" {
  current = true
}

data "template_file" "bucket_policy" {
  template = "${file("${path.module}/templates/s3_bucket_policy.json.tpl")}"

  vars {
    bucket_name  = "${var.bucket_name}"
    fastly_cidrs = "${join(",", formatlist("\"%s\"", data.fastly_ip_ranges.fastly.cidr_blocks))}"
    office_cidrs = "${join(",", formatlist("\"%s\"", var.office_cidrs))}"
  }
}

data "template_file" "default_vcl" {
  template = "${file("${path.module}/templates/vcl.example")}"

  vars {
    bucket_name     = "${var.bucket_name}"
    fastly_dns_name = "${var.fastly_dns_name}"
  }
}

resource "aws_s3_bucket" "fastly" {
  bucket = "${var.bucket_name}"
  acl    = "public-read"
  policy = "${data.template_file.bucket_policy.rendered}"

  website {
    index_document = "${var.index_file}"
    error_document = "${var.error_file}"
  }

  versioning {
    enabled = "${var.versioning}"
  }

  lifecycle_rule {
    prefix  = "/"
    enabled = true

    transition {
      days          = "${var.transition_days}"
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      days          = "${var.transition_days}"
      storage_class = "STANDARD_IA"
    }

    abort_incomplete_multipart_upload_days = 7
  }

  tags {
    product = "${var.tag_product}"
    env     = "${var.tag_env}"
    purpose = "${var.tag_purpose}"
    role    = "${var.tag_role}"
  }
}

resource "fastly_service_v1" "s3_bucket" {
  depends_on = ["aws_s3_bucket.fastly"]
  name       = "${var.tag_product}-${var.tag_env}-${var.tag_role}"

  domain {
    name = "${var.fastly_dns_name}"
  }

  default_host = "${var.fastly_dns_name}"

  backend {
    address = "${aws_s3_bucket.fastly.id}.s3-website-${data.aws_region.current.name}.amazonaws.com"
    name    = "AWS S3 hosting"
    port    = 80
  }

  vcl {
    name    = "custom"
    content = "${var.custom_vcl != "false" ? var.custom_vcl : data.template_file.default_vcl.rendered}"
    main    = true
  }

  gzip {
    name          = "Compress"
    extensions    = ["${var.gzip_extensions}"]
    content_types = ["${var.gzip_content_types}"]
  }

  request_setting {
    name = "Force-TLS"

    force_ssl = "${var.force_tls == "true" ? true : false }"
  }

  force_destroy = true
}
