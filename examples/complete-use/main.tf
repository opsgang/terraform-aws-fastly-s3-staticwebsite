module "static" {
  source = "../../"

  bucket_name     = "levent-s3-hosting-test"
  office_cidrs    = ["192.168.22.236/32"]
  fastly_dns_name = "s3.leventyalcin.com"
  versioning      = "false"
  custom_vcl      = "false"

  tags {
    tag1 = "value1"
    tag2 = "value2"
  }
}
