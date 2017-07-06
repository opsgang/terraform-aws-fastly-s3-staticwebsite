output "bucket_policy" {
  value = "${data.template_file.bucket_policy.rendered}"
}

output "bucket_name" {
  value = "${aws_s3_bucket.fastly.id}"
}

output "bucket_domain_name" {
  value = "${aws_s3_bucket.fastly.bucket_domain_name}"
}

output "bucket_region" {
  value = "${aws_s3_bucket.fastly.region}"
}

output "bucket_website_endpoint" {
  value = "${aws_s3_bucket.fastly.website_endpoint}"
}

output "fastly_service_id" {
  value = "${fastly_service_v1.s3_bucket.id}"
}

output "fastly_service_name" {
  value = "${fastly_service_v1.s3_bucket.name}"
}

output "fastly_config_active_version" {
  value = "${fastly_service_v1.s3_bucket.active_version}"
}

output "fastly_config_vcl" {
  value = "${fastly_service_v1.s3_bucket.vcl}"
}

output "fastly_domain" {
  value = "${fastly_service_v1.s3_bucket.domain}"
}
