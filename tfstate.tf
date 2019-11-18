terraform {
  backend "gcs" {
    bucket      = "terraform-state-4636fc874bce0d67326eb8adf6755ab8"
    prefix      = "dev"
    credentials = "gce-account.json"
  }
}

