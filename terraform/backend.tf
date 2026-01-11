terraform {
  backend "s3" {
    bucket       = "terraform-state-df_picpay"
    key          = "df-picpay-simplificado/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}