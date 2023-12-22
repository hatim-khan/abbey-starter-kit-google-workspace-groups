terraform {
  required_providers {
    googleworkspace = {
        source = "hashicorp/googleworkspace"
        version = "~> 0.7.0"
    }

    abbey = {
      source = "abbeylabs/abbey"
      version = "~> 0.2.6"
    }
  }
}
