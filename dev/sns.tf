resource "aws_sns_topic" "topic" {
  name = "${var.environment}-topic"
}

resource "aws_sns_topic_subscription" "subscription" {
  topic_arn = "${aws_sns_topic.topic.id}"
  protocol  = "lambda"
  endpoint  = "${aws_lambda_function.slack_lambda.arn}"
}

resource "aws_lambda_permission" "with_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = "${aws_lambda_function.slack_lambda.arn}"
  principal     = "sns.amazonaws.com"
  source_arn    = "${aws_sns_topic.topic.arn}"
}
