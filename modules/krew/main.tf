resource "local_file" "setup_file" {
  count = var.enabled ? 1 : 0
  content = templatefile("${path.module}/scripts/setup.sh.tpl", {
    path = path.module
  })
  filename        = "/server/tools/krew/setup.sh"
  file_permission = 0644
}

resource "null_resource" "setup_plugin" {
  count = var.enabled ? 1 : 0
  triggers = {
    always_run = var.run_trigger == "always" ? timestamp() : filemd5("${path.module}/scripts/setup.sh.tpl")
  }

  provisioner "local-exec" {
    command = templatefile("${path.module}/scripts/setup.sh.tpl", {
      path = path.module
    })
  }
}

resource "local_file" "krew_path" {
  count           = var.enabled ? 1 : 0
  content         = "PATH=$HOME/.krew/bin:$PATH"
  filename        = "/etc/profile.d/krew.sh"
  file_permission = 0644
}
