# Redshiftクラスターの作成
## https://dev.classmethod.jp/articles/redshift-private-cluster-with-terraform/ 

resource "aws_redshift_cluster" "redshift_handson" {
  cluster_identifier = "redshift-handson"
  database_name = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  default_iam_role_arn = aws_iam_role.handson_redshift_role.arn
  node_type = "dc2.large"
  number_of_nodes = 1
  publicly_accessible = true
  cluster_type = "single-node"
  skip_final_snapshot = true
}
