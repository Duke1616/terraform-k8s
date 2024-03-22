provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
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
