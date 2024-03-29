locals {
  grep_excludes = join("|", [
    for node, disks in var.exclude_disk : join("|", [
      for disk in disks : format("%s │ %s", node, disk)
    ])
  ])

  grep_commands = [
    for key, value in var.include_disk : format("grep %s", value)
  ]
  grep_includes = join(" | ", local.grep_commands)
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

resource "null_resource" "setup_plugin" {
  depends_on = [kubectl_manifest.directpv_deploy]
  count      = var.enabled ? 1 : 0
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = "kubectl directpv discover --output-file=${path.module}/scripts/drives.yaml > '${path.module}/scripts/pre-disk.txt'"
  }
}

resource "null_resource" "init_disk" {
  depends_on = [null_resource.setup_plugin]
  count      = var.enabled ? 1 : 0
  triggers = {
    always_run = timestamp()
  }

  provisioner "local-exec" {
    command = templatefile("${path.module}/scripts/disk-init.sh.tpl", {
      exclude_command = local.grep_excludes
      include_command = local.grep_includes
      path            = path.module
    })
  }
}
