resource "aws_iam_role_policy_attachment" "attach_ecr_access_policy" {
  policy_arn = aws_iam_policy.ecr_access_policy.arn
  role = aws_iam_role.ecr_access_role.name
}
