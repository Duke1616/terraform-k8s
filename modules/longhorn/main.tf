resource "kubernetes_labels" "longhorn_lables" {
  for_each    = var.enabled ? var.dynamic_nodes : {}
  api_version = "v1"
  kind        = "Node"
  metadata {
    name = each.key
  }
  field_manager = "TerraformLabels"
  labels        = each.value["labels"]
}

resource "kubernetes_annotations" "longhorn_annotation" {
  for_each    = var.enabled ? var.dynamic_nodes : {}
  api_version = "v1"
  kind        = "Node"
  metadata {
    name = each.key
  }
  field_manager = "TerraformAnnotations"
  annotations   = each.value["annotations"]
}

resource "helm_release" "longhorn_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "longhorn"
  timeout          = 300
  chart            = "${path.module}/helm/charts/longhorn-${var.longhorn_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-${var.longhorn_version}.yaml")
  ]

  dynamic "set" {
    for_each = {
      "persistence.defaultFsType"                                   = var.defaultFsType
      "defaultSettings.backupTarget"                                = var.backupTarget
      "defaultSettings.backupTargetCredentialSecret"                = var.backupTargetCredentialSecret
      "defaultSettings.createDefaultDiskLabeledNodes"               = var.createDefaultDiskLabeledNodes
      "defaultSettings.defaultDataPath"                             = var.defaultDataPath
      "defaultSettings.defaultReplicaCount"                         = var.defaultReplicaCount
      "defaultSettings.upgradeChecker"                              = var.upgradeChecker
      "defaultSettings.replicaSoftAntiAffinity"                     = var.replicaSoftAntiAffinity
      "defaultSettings.allowVolumeCreationWithDegradedAvailability" = var.allowVolumeCreationWithDegradedAvailability
      "defaultSettings.storageOverProvisioningPercentage"           = var.storageOverProvisioningPercentage
      "defaultSettings.storageMinimalAvailablePercentage"           = var.storageMinimalAvailablePercentage
      "defaultSettings.storageReservedPercentageForDefaultDisk"     = var.storageReservedPercentageForDefaultDisk
      "defaultSettings.deletingConfirmationFlag"                    = var.deletingConfirmationFlag
    }
    content {
      name  = set.key
      value = set.value
    }
  }
}

data "kubectl_path_documents" "docs" {
  pattern = "${path.module}/manifests/*.yaml"
  vars = {
    namespace                    = var.namespace
    access_url                   = var.access_url
    backupTargetCredentialSecret = var.backupTargetCredentialSecret
  }
}

resource "kubectl_manifest" "longhorn_dashboard" {
  depends_on = [helm_release.longhorn_deploy]
  count      = var.ingress_enabled && var.enabled ? length(data.kubectl_path_documents.docs.documents) : 0
  yaml_body  = data.kubectl_path_documents.docs.documents[count.index]
}
