data "tls_certificate" "pub-cluster" {
  url = data.aws_eks_cluster.public_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "oidc_provider_pub" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = concat([data.tls_certificate.pub-cluster.certificates.0.sha1_fingerprint])
  url             = flatten(concat(data.aws_eks_cluster.public_cluster.identity[*].oidc.0.issuer, [""]))[0]
}