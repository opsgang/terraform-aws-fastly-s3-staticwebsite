# Overview
This module setups an S3 bucket on AWS and configures Fastly to use the S3 as backend.

### Warning;
This modules includes variables with default values. Please make sure you checked [variables.tf](variables.tf) first.

### Features;
* S3 bucket only allows connections from Fastly and given CIDR blocks.
* Removes Amazon response headers if Fastly-Debug is not given.
* You can use a custom vcl configuration by setting custom_vcl variable. If `custom_vcl` is not set, terraform uses default vcl definition [vcl.example](templates/vcl.example)
* You can enable/disable forcing TLS connections. (HTTP to HTTPS redirects). It's enabled by default.
* You can manage bucket versioning
* You can manage gzip file extensions and content types

# Input variables

* **force_tls:** (Bool - [true]/false) Enables/Disables HTTP to HTTPS forcing.
* **index_file:** (String - [index.html]) Name of the index document file
* **error_file:** (String - [error.html]) Name of the error document file
* **versioning:** (Bool - [true]/false) Enables/Disables bucket versioning
* **transition_days:** (Int - [30]) Move files to STANDARD_IA after N days
* **gzip_extensions:** (List - [see variables.tf]) List of files extensions for gzip
* **gzip_content_types:** (List - [see variables.tf]) of content types for gzip
* **bucket_name:** (String) Bucket name
* **fastly_dns_name:** (String) What domain name will be used on Fastly
* **office_cidrs:** (List) List of IP CIDR blocks to reach bucket directly.
* **custom_vcl:** (String) Rendered template file of your custom vcl. Set to false if you want to use default VCL. If you pass "false" as String, it will be ignored.
* **tags:** (Map - [{}]) AWS tags for the resources

# Outputs
* **bucket_policy:** Bucket policy in JSON
* **bucket_name:** Name of the bucket
* **bucket_domain_name:** Domain name of the bucket
* **bucket_region:** Region of the bucket
* **bucket_website_endpoint:** Website end point of the bucket
* **fastly_service_id:** The ID of the Fastly service
* **fastly_service_name:** Name of this service.
* **fastly_config_active_version:** The currently active version number of your Fastly Service.
* **fastly_config_vcl:** Set of custom VCL configurations
* **fastly_domain:** Set of Domains set on Fastly

# Usage

```
provider "aws" {}
provider "fastly" {}

module "static" {
  source = "github.com/opsgang/terraform_s3_hosting_fastly?ref=1.0.0"

  bucket_name     = "levent-s3-hosting-test"
  office_cidrs    = ["192.168.22.236/32"]
  fastly_dns_name = "s3.leventyalcin.com"
  versioning      = "false"
  custom_vcl      = "false"

  tags {
    product = "blog"
    env     = "dev"
    purpose = "content"
    role    = "blog"
  }  
}
```
