provider "googleworkspace" {
  customer_id = "${local.google_customer_id}"
}

provider "abbey" {
  bearer_auth = var.abbey_token
}
