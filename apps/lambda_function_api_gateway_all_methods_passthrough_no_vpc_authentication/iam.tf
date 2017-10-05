resource "aws_iam_user" "app_user" {
  name = "api_gateway_${var.app_name}"
}

resource "aws_iam_access_key" "app_user_v1" {
  user = "${aws_iam_user.app_user.name}"
}