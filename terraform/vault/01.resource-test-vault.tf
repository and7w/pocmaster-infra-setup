resource "vault_mount" "pocmaster" {
  path        = "pocmaster"
  type        = "kv"
  description = "Moteur KV pour POC Master"


  options = {
    version = "2"
  }
}

//exemple de test pour creer une secret
resource "vault_kv_secret_v2" "tf_secret" {
  name = "tf-test-secret"
  data_json = jsonencode({
    new_key = "new_value",
    new_key2 = "new_value2",

  })
  mount = "pocmaster"
}

//lecture

# Lire le secret avec une data source
data "vault_kv_secret_v2" "read_tf_secret" {
  name  = "tf-test-secret"
  mount = "pocmaster"
}

# Afficher les valeurs dans les outputs Terraform
output "secret_values" {
  value = data.vault_kv_secret_v2.read_tf_secret.data
  sensitive = true
}

output "specific_value" {
  value = data.vault_kv_secret_v2.read_tf_secret.data["new_key"]
  sensitive = true
}


