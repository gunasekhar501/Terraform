#########################################
# IAM assumable role with custom trust policy
#########################################
module "ebscsi-driver-role" {
  source                          = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  create_role                     = true
  role_name                       = "${var.cluster_name}-ebscsi-driver-role"
  create_custom_role_trust_policy = true
  custom_role_trust_policy        = data.aws_iam_policy_document.ebscsi_trust_policy.json
  custom_role_policy_arns         = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
}

data "aws_iam_policy_document" "ebscsi_trust_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringEquals"
      variable = "${module.eks.oidc_provider}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }

    condition {
      test     = "StringEquals"
      variable = "${module.eks.oidc_provider}:aud"
      values   = ["sts.amazonaws.com"]
    }
    
    principals {
      type        = "Federated"
      identifiers = ["${module.eks.oidc_provider_arn}"]
    }
  }
}