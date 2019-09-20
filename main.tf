module "dev" {
  source = "./dev"

  artifacts_bucket = "${var.artifacts_bucket}"

  artifacts_bucket_full_name = "${module.dev.artifacts_bucket_full_name}"
}

variable "artifacts_bucket" {
  default = "406030180379-artifacts-bucket"
}
