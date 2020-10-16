# output for EKS module
output "eks_iam_role_mapping" {
  value = [
    for r in var.roles : {
      arn    = aws_iam_role.access_assumerole[r.name].arn
      name   = aws_iam_role.access_assumerole[r.name].name
      groups = r.k8s_groups
    }
  ]
  description = "List of mappings of AWS role to Kubernetes user/groups"
}
