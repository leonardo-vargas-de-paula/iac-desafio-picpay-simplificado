resource "aws_ecr_repository" "ecr_df_picpay" {
  name                 = "ecr-df-picpay"
  image_tag_mutability = "MUTABLE"
  force_delete         = true
}