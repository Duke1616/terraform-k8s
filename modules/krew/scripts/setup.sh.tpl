#!/bin/bash
# ./krew-linux_amd64 install --manifest=krew.yaml --archive=krew-linux_amd64.tar.gz
mainfestPath=/server/tools/krew/manifests
pluginPath=/server/tools/krew/plugins
binPath=/server/tools/krew/bin

migrate_file() {
    cp -r "${path}/manifests" $mainfestPath
    cp -r "${path}/plugins" $pluginPath
    cp -r "${path}/bin" $binPath
}

setup_krew() {
    ${path}/bin/krew-linux_amd64 install --manifest=${path}/manifests/krew.yaml --archive=${path}/plugins/krew-linux_amd64.tar.gz
}

setup_directpv() {
    ${path}/bin/krew-linux_amd64 install --manifest=${path}/manifests/directpv.yaml --archive=${path}/plugins/kubectl-directpv_linux_amd64_v1.zip
}

setup_minio() {
    ${path}/bin/krew-linux_amd64 install --manifest=${path}/manifests/minio.yaml --archive=${path}/plugins/kubectl-minio_linux_amd64_v1.zip
}

main() {
    migrate_file
    setup_krew
    setup_directpv
    setup_minio
}

main
