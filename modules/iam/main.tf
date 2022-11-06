# iam policy document (this command allows ansible server to perform on AWS account)
data "aws_iam_policy_document" "ansible-nody" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:Describe*",
      "autoscaling:Describe*",
      "ec2:DescribeTags*"
    ]
    resources = ["*"]
  }
}
resource "aws_iam_policy" "ansible_nody" {
  name        = "ansible-nody-aws-cli-policy-usteam1"
  path        = "/"
  description = "Access policy for Ansible_node to connect to aws account"
  policy      = data.aws_iam_policy_document.ansible-nody.json
}

# this policy document allows ansible to assume a role to be able to describe instances on AWS account
data "aws_iam_policy_document" "ansible_nody_policy_document" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}
resource "aws_iam_role" "ansible_nody_role" {
  name               = "ansible-nody-aws-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.ansible_nody_policy_document.json
}
resource "aws_iam_role_policy_attachment" "ansible_nody_policy_attachment" {
  role       = aws_iam_role.ansible_nody_role.name
  policy_arn = aws_iam_policy.ansible_nody.arn
}
resource "aws_iam_instance_profile" "ansible_nody_instance_profile" {
  name = "ansible_nody_instance_profile"
  role = aws_iam_role.ansible_nody_role.name
}