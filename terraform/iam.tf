# QuickSightのVPC設定用のロール
## https://docs.aws.amazon.com/ja_jp/quicksight/latest/user/vpc-creating-a-connection-in-quicksight-console.html
resource "aws_iam_role" "private_connect" {
  name = "private-connect"
  assume_role_policy = data.aws_iam_policy_document.private_connect_assume.json
}

data "aws_iam_policy_document" "private_connect_assume" {
  statement {
    actions = [ "sts:AssumeRole" ]
    
    principals {
      type = "Service"
      identifiers = [ "quicksight.amazonaws.com" ]
    }
  }
}

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
  name = "private_connect"
  roles = [ aws_iam_role.private_connect.name ]
  policy_arn = aws_iam_policy.private_connect.arn
}
