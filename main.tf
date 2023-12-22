terraform {
  backend "http" {
    address        = "https://api.abbey.io/terraform-http-backend"
    lock_address   = "https://api.abbey.io/terraform-http-backend/lock"
    unlock_address = "https://api.abbey.io/terraform-http-backend/unlock"
    lock_method    = "POST"
    unlock_method  = "POST"
  }
}

locals {
  account_name = ""
  repo_name = ""

  project_path = "github://${local.account_name}/${local.repo_name}"
  policies_path = "${local.project_path}/policies"

  # Replace if your abbey email doesn't match your Google User email
  # Example: gcp_member = "your-username@gmail.com"
  google_group_member_email = "{{ .user.email }}"
  google_customer_id = "C1111111" # CHANGEME
}

resource "googleworkspace_group" "google_workspace_demo" {
  email       = "replace-me@example.com" # CHANGEME
}

resource "abbey_grant_kit" "googleworkspace" {
  name = "GoogleWorkspace"
  description = <<-EOT
    Grants access to Abbey's GoogleWorkspace Group for the Quickstart.
  EOT

  workflow = {
    steps = [
      {
        reviewers = {
          one_of = ["replace-me@example.com"] # CHANGEME
        }
      }
    ]
  }

  policies = [
    { bundle = local.policies_path }
  ]

  output = {
    # Replace with your own path pointing to where you want your access changes to manifest.
    # Path is an RFC 3986 URI, such as `github://{organization}/{repo}/path/to/file.tf`.
    location = "${local.project_path}/access.tf"
    append = <<-EOT
      resource "googleworkspace_group_member" "member" {
        group_id = googleworkspace_group.google_workspace_demo.id
        email = "${local.google_group_member_email}"
        role = "MEMBER"
      }
    EOT
  }
}