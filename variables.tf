# Be aware of about variables with default values
variable "force_tls" {
  description = "redirect all non-HTTPS requests to HTTPS"
  default     = "true"
}

variable "index_file" {
  description = "Index document"
  default     = "index.html"
}

variable "error_file" {
  description = "Error document"
  default     = "error.html"
}

variable "versioning" {
  description = "Is versioning needed true/false"
  default     = "true"
}

variable "transition_days" {
  description = "how many days you need files as hot"
  default     = 30
}

variable "gzip_extensions" {
  description = "file extensions for gzip"
  type        = "list"
  default     = ["css", "js", "html", "eot", "ico", "otf", "ttf", "json"]
}

variable "gzip_content_types" {
  description = "content headers for gzip"
  type        = "list"

  default = [
    "text/html application/x-javascript",
    "text/css",
    "application/javascript",
    "text/javascript",
    "application/json",
    "application/vnd.ms-fontobject",
    "application/x-font-opentype",
    "application/x-font-truetype",
    "application/x-font-ttf",
    "application/xml",
    "font/eot",
    "font/opentype",
    "font/otf",
    "image/svg+xml",
    "image/vnd.microsoft.icon",
    "text/plain",
    "text/xml",
  ]
}

# /variables with default values

variable "bucket_name" {
  description = "S3 bucket name for hosted files"
}

variable "fastly_dns_name" {
  description = "DNS Name of static hosting website"
}

variable "office_cidrs" {
  description = "List of IP CIDRs to whitelist"
  type        = "list"
}

variable "custom_vcl" {
  description = "rendered output of custom vcl template. Set to false if you don't want to use"
}

variable "tag_product" {}
variable "tag_env" {}
variable "tag_role" {}
variable "tag_purpose" {}
