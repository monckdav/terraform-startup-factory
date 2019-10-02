resource "aws_lambda_function" "slack_lambda" {
  function_name = "${var.environment}-slack-lambda"

  filename    = "lambdas/slack-lambda.zip"

  handler = "slack-lambda.handler"
  runtime = "nodejs10.x"

  role = "${aws_iam_role.slack_lambda.arn}"
}

resource "aws_iam_role" "slack_lambda" {
  name = "slack-lambda-iam-role"

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

resource "aws_iam_role_policy" "slack_lambda" {
  name   = "slack-lambda-iam-role-policy"
  role   = "${aws_iam_role.slack_lambda.name}"
  policy = "${data.aws_iam_policy_document.slack_lambda.json}"
}

data "aws_iam_policy_document" "slack_lambda" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}
