# output for EKS module
output "eks_iam_role_arns" {
  value       = [
    for r in aws_iam_role.access_assumerole: {
      arn  = r.arn
      name = r.name
    }
  ]
  description = "List of role and users"
}
