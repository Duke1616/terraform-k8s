#!/bin/bash
# 过滤可用节点磁盘
grep -vE  '${exclude_command}' ${path}/scripts/pre-disk.txt | ${include_command} |awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/scripts/init-disk.txt

# 生成初始化文件
${path}/bin/direct --init-disk-path ${path}/scripts/init-disk.txt --direct-path ${path}/scripts/drives.yaml --new-file-path ${path}/scripts/init-drives.yaml

# 磁盘格式化
kubectl directpv init ${path}/scripts/init-drives.yaml
