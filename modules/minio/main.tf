# 创建桶
resource "minio_s3_bucket" "bucket" {
  for_each      = var.enabled ? { for bucket in var.minio_bucket : bucket => {} } : {}
  bucket        = each.key
  force_destroy = false
  acl           = "private"

  lifecycle {
    prevent_destroy = false
  }
}

# 生成 Policy 文件
data "minio_iam_policy_document" "pocliy" {
  statement {
    actions = [
      "s3:*"
    ]
    resources = [
      for bucket in var.minio_bucket : "arn:aws:s3:::${bucket}/*"
    ]
  }
}

# 创建 Policy
resource "minio_iam_policy" "policy" {
  count  = var.enabled ? 1 : 0
  name   = var.minio_policy_name
  policy = data.minio_iam_policy_document.pocliy.json
}


# 创建用户
resource "minio_iam_user" "user" {
  count         = var.enabled ? 1 : 0
  name          = var.minio_access_key
  secret        = var.minio_secret_key
  force_destroy = false
}

# 用户授权 Policy
resource "minio_iam_user_policy_attachment" "iam" {
  count       = var.enabled ? 1 : 0
  user_name   = minio_iam_user.user[count.index].id
  policy_name = minio_iam_policy.policy[count.index].id
}
