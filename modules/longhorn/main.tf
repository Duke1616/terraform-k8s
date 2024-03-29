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
  timeout          = 60
  chart            = "${path.module}/helm/charts/longhorn-${var.longhorn_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-${var.longhorn_version}.yaml")
  ]

  set {
    name  = "persistence.defaultFsType"
    value = var.defaultFsType
  }

  set {
    name  = "defaultSettings.backupTarget"
    value = var.backupTarget
  }

  set {
    name  = "defaultSettings.backupTargetCredentialSecret"
    value = var.backupTargetCredentialSecret
  }

  set {
    name  = "defaultSettings.createDefaultDiskLabeledNodes"
    value = var.createDefaultDiskLabeledNodes
  }

  set {
    name  = "defaultSettings.defaultDataPath"
    value = var.defaultDataPath
  }

  set {
    name  = "defaultSettings.defaultReplicaCount"
    value = var.defaultReplicaCount
  }

  set {
    name  = "defaultSettings.upgradeChecker"
    value = var.upgradeChecker
  }

  set {
    name  = "defaultSettings.replicaSoftAntiAffinity"
    value = var.replicaSoftAntiAffinity
  }

  set {
    name  = "defaultSettings.allowVolumeCreationWithDegradedAvailability"
    value = var.allowVolumeCreationWithDegradedAvailability
  }

  set {
    name  = "defaultSettings.storageOverProvisioningPercentage"
    value = var.storageOverProvisioningPercentage
  }

  set {
    name  = "defaultSettings.storageMinimalAvailablePercentage"
    value = var.storageMinimalAvailablePercentage
  }

  set {
    name  = "defaultSettings.storageReservedPercentageForDefaultDisk"
    value = var.storageReservedPercentageForDefaultDisk
  }

  set {
    name  = "defaultSettings.deletingConfirmationFlag"
    value = var.deletingConfirmationFlag
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
  count     = var.enabled ? length(data.kubectl_path_documents.docs.documents) : 0
  yaml_body = data.kubectl_path_documents.docs.documents[count.index]
}
