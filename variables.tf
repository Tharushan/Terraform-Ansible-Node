variable "name" {
  default = "samplevm"
}

variable "region" {
  default = "europe-west1"
}

variable "region_zone" {
  default = "europe-west1-b"
}

variable "project_name" {
  description = "The ID of the Google Cloud project"
}

variable "credentials_file_path" {
  description = "Path to the JSON file used to describe your account credentials"
  default     = "gce-account.json"
}

variable "public_key_path" {
  description = "Path to file containing public key"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to file containing private key"
  default     = "~/.ssh/id_rsa"
}

variable "ssh_user" {}

