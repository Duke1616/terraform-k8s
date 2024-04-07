resource "null_resource" "install_crd" {
  count = var.enabled ? 1 : 0
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command = templatefile("${path.module}/scripts/install-crd.sh.tpl", {
      crd_path = "${path.module}/helm/manifests/kubeblocks_crds.yaml"
    })
  }
}

resource "helm_release" "kubeblocks_deploy" {
  count            = var.enabled ? 1 : 0
  name             = "kubeblocks"
  timeout          = 60
  chart            = "${path.module}/helm/charts/kubeblocks-${var.chart_version}.tgz"
  namespace        = var.namespace
  create_namespace = true
  values = [
    file("${path.module}/helm/values/values-kubeblocks-${var.chart_version}.yaml")
  ]
}
