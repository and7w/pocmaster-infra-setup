

resource "vault_kv_secret" "secret" {
  path = "kv/secret"
  data_json = jsonencode(
    {
      zip = "zap",
      foo = "bar"
    }
  )
}