locals {
  grep_excludes = length(var.exclude_disk) > 0 ? join("|", [
    for node, disks in var.exclude_disk : join("|", [
      for disk in disks : format("%s │ %s", node, disk)
    ])
  ]) : null

  grep_commands = [
    for key, value in var.include_disk : format("grep %s", value)
  ]
  grep_includes = length(local.grep_commands) > 0 ? join(" | ", local.grep_commands) : null
}

resource "kubernetes_labels" "dircetpv_lables" {
  for_each    = var.enabled ? zipmap(var.dynamic_nodes, var.dynamic_nodes) : {}
  api_version = "v1"
  kind        = "Node"
  metadata {
    name = each.key
  }
  field_manager = "dircetpvLabels"
  labels = {
    "directpv.min.io/enabled" = "true"
  }
}

data "kubectl_path_documents" "docs" {
  pattern = "${path.module}/manifests/*.yaml"
}

resource "kubectl_manifest" "directpv_deploy" {
  count     = var.enabled ? length(data.kubectl_path_documents.docs.documents) : 0
  yaml_body = data.kubectl_path_documents.docs.documents[count.index]
}

resource "null_resource" "discover_disk" {
  depends_on = [kubectl_manifest.directpv_deploy]
  count      = var.enabled ? 1 : 0
  triggers = {
    always_run = var.run_init_disk == true ? timestamp() : null
  }

  provisioner "local-exec" {
    command = "$HOME/.krew/bin/kubectl-directpv discover --output-file=${path.module}/temp/drives.yaml > '${path.module}/temp/pre-disk.txt'"
  }
}

resource "null_resource" "init_disk" {
  depends_on = [null_resource.discover_disk]
  count      = var.enabled ? 1 : 0

  triggers = {
    always_run = var.run_init_disk == true ? timestamp() : null
  }

  provisioner "local-exec" {
    command = templatefile("${path.module}/scripts/disk-init.sh.tpl", {
      exclude_command = local.grep_excludes != null ? local.grep_excludes : "null"
      include_command = local.grep_includes != null ? local.grep_includes : "null"
      path            = path.module
      run_init_disk   = var.run_init_disk
    })
  }
}
