resource "aws_security_group" "redshift_sg_private" {
  name = "redshift-sg-private"
  description = "redshift-sg-private"
}

resource "aws_security_group" "quicksight_sg_private" {
  name = "quicksight-sg-private"
  description = "quicksight-sg-private"

  ingress {
    from_port = "0"
    to_port = "65535"
    protocol = "tcp"
    security_groups = [ aws_security_group.redshift_sg_private.id ]
  }
}

resource "aws_security_group_rule" "redshift_to_quicksight" {
  type = "ingress"
  from_port = "5439"
  to_port = "5439"
  protocol = "tcp"
  source_security_group_id = aws_security_group.quicksight_sg_private.id
  security_group_id = aws_security_group.redshift_sg_private.id
}
