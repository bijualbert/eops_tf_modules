resource "aws_cloudwatch_log_subscription_filter" "sumo_lambdafunction_logfilter" {
  name            = "sumo_lambdafunction_logfilter"
  role_arn        = "${aws_iam_role.iam_for_app.arn}"
  log_group_name  = "/aws/lambda/example_lambda_name"
  filter_pattern  = "logtype test"
  destination_arn = "${aws_kinesis_stream.test_logstream.arn}"
}

resource "aws_cloudwatch_log_destination" "test_destination" {
  name       = "test_destination"
  role_arn   = "${aws_iam_role.iam_for_cloudwatch.arn}"
  target_arn = "${aws_kinesis_stream.kinesis_for_cloudwatch.arn}"
}