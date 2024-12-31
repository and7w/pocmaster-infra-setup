# Terraform Block
terraform {
  required_version = "~> 1.8"
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "4.5.0"
    }

    null = {
      source = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

provider "vault" {
  address = var.vault_address

  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id   = var.vault_role_id
      secret_id = var.vault_secret_id
    }
  }
}



