data "aws_iam_policy_document" "role1_doc" {
    statement {
      actions = ["sts:AssumeRole"]
      principals {
        type = "Service"
        identifiers = ["ecs"]
      }
    }
}