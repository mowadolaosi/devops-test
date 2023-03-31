# Create IAM policy with a policy document to allow Ansible Node perform specific actions on AWS account to discover
# instances created by ASG without escalating the Ansible Node priviledges
data "aws_iam_policy_document" "SSKEU1-policydoc" {
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

resource "aws_iam_policy" "SSKEU1-policy" {
  name   = "k8s-policy-aws-cli"
  path   = "/"
  policy = data.aws_iam_policy_document.SSKEU1-policydoc.json
}

# Create IAM role with a policy document to allow Ansible Node assume role
data "aws_iam_policy_document" "SSKEU1-policydoc-role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "SSKEU1-role" {
  name               = "SSKEU1-aws-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.SSKEU1-policydoc-role.json
}

# Attach the IAM policy to the IAM role created
resource "aws_iam_role_policy_attachment" "k8s-policy-role-attach" {
  role       = aws_iam_role.SSKEU1-role.name
  policy_arn = aws_iam_policy.SSKEU1-policy.arn
}

# Create IAM instance profile to be attached to our Ansible Node
resource "aws_iam_instance_profile" "SSKEU1-IAM-profile" {
  name = "SSKEU1ble-Node-profile"
  role = aws_iam_role.SSKEU1-role.name
}