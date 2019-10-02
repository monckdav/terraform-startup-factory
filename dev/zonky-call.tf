resource "aws_lambda_function" "zonky_call" {
  function_name = "${var.environment}-zonky-call"

  filename    = "lambdas/zonky-call-0.0.1.zip"

  handler = "zonky-call.handler"
  runtime = "nodejs10.x"

  role = "${aws_iam_role.zonky_call.arn}"
}

resource "aws_iam_role" "zonky_call" {
  name = "zonky-call-iam-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "zonky_call" {
  name   = "zonky-call-iam-role-policy"
  role   = "${aws_iam_role.zonky_call.name}"
  policy = "${data.aws_iam_policy_document.zonky_call.json}"
}

data "aws_iam_policy_document" "zonky_call" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "sns:Publish",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
      "arn:aws:sns:*:*:*",
    ]
  }
}
