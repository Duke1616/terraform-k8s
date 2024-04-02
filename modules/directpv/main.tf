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

# 需要调度节点添加labels
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

# 部署节点，切勿不可以使用manifest方式部署，会造成不可逆的破坏
resource "null_resource" "directpv_deploy" {
  depends_on = [kubernetes_labels.dircetpv_lables]
  count      = var.enabled ? 1 : 0
  triggers = {
    always_run = fileexists("${path.module}/temp/lock-install.pid") == true ? timestamp() : null
  }

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "${path.module}/scripts/install-directpv.sh"
  }
}

# 输出可初始化磁盘
resource "null_resource" "discover_disk" {
  depends_on = [null_resource.directpv_deploy]
  count      = var.enabled ? 1 : 0
  triggers = {
    always_run = var.run_init_disk == true ? timestamp() : null
  }

  provisioner "local-exec" {
    command = "$HOME/.krew/bin/kubectl-directpv discover --output-file=${path.module}/temp/drives.yaml > '${path.module}/temp/pre-disk.txt'"
  }
}

# 通过过滤条件，形成最后需要初始化的磁盘，进行格式化
# run_init_disk 为 false时，脚本内部也有判断逻辑，不会运行初始化操作
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
