module "dev" {
  source = "./dev"

  environment = "${var.environment}"
}

variable "environment" {
  default = "dev"
}
