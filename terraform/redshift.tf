# Redshiftクラスターの作成
## https://dev.classmethod.jp/articles/redshift-private-cluster-with-terraform/ 

resource "aws_redshift_cluster" "redshift_handson" {
  cluster_identifier = "redshift-handson"
  database_name = var.database_name
  master_username = var.master_username
  master_password = var.master_password
  node_type = "dc2.large"
  number_of_nodes = 1
  publicly_accessible = true
  cluster_type = "single-node"
  vpc_security_group_ids = [aws_security_group.redshift_sg_private.id]
  skip_final_snapshot = true
}

# IAMロールの設定
## https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_cluster_iam_roles
resource "aws_redshift_cluster_iam_roles" "redshift_handson" {
  cluster_identifier = aws_redshift_cluster.redshift_handson.cluster_identifier
  iam_role_arns = [ aws_iam_role.handson_redshift_role.arn ]
}
