# QuickSightのVPC設定用のロール
## https://docs.aws.amazon.com/ja_jp/quicksight/latest/user/vpc-creating-a-connection-in-quicksight-console.html
## https://dev.classmethod.jp/articles/quicksight-new-vpc-multi-az/
resource "aws_iam_policy" "private_connect" {
  name = "private-connect"
  policy = data.aws_iam_policy_document.private_connect.json
}

data "aws_iam_policy_document" "private_connect" {
  statement {
    effect = "Allow"
    actions = [ 
      "ec2:CreateNetworkInterface",
      "ec2:ModifyNetworkInterfaceAttribute",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups"
    ]
    resources = [ 
      "*",
    ]
  }
}

resource "aws_iam_policy_attachment" "private_connect" {
  name = "private-connect"
  roles = [ "service-role/aws-quicksight-service-role-v0" ]
  policy_arn = aws_iam_policy.private_connect.arn
}


# RedshiftからS3にアクセスするロール
resource "aws_iam_role" "handson_redshift_role" {
  name = "handson-RedshiftRole"
  assume_role_policy = data.aws_iam_policy_document.handson_redshift_assume.json
}

data "aws_iam_policy_document" "handson_redshift_assume" {
  statement {
    actions = [ "sts:AssumeRole" ]
    
    principals {
      type = "Service"
      identifiers = [ "redshift.amazonaws.com" ]
    }
  }
}

resource "aws_iam_policy_attachment" "handson_redshift_role" {
  name = "handson-RedshiftRole"
  roles = [ aws_iam_role.handson_redshift_role.name ]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
