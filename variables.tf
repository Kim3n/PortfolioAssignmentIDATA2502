variable "project" {
  description = "Google Cloud project ID"
}

variable "region" {
  description = "Google Cloud region"
  default     = "us-east1"
}

variable "zone" {
  description = "Google Cloud zone"
  default     = "us-east1-b"
}

variable "google_credentials" {
  description = "Path to the Google Cloud credentials file"
}

variable "html_content" {
  description = "HTML content to display on the webserver"
  default     = "<h1>Hello, Terraform!</h1>"
}
