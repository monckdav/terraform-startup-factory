
resource "aws_cloudwatch_event_rule" "zonky_call_scheduler" {
  name                = "${var.environment}-zonky-call-scheduler"
  description         = "Calls Zonky lambda on a schedule."
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "zonky_call_scheduler" {
  rule     = "${aws_cloudwatch_event_rule.zonky_call_scheduler.name}"
  arn      = "${aws_lambda_function.zonky_call.arn}"
}
