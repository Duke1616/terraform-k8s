#!/bin/bash
# 如果没有设置过滤项，判断逻辑
if [ '${exclude_command}' = 'null' ]; then
    if [ '${include_command}' = 'null' ]; then
        grep 'YES' ${path}/temp/pre-disk.txt | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt
    else
        grep 'YES' ${path}/temp/pre-disk.txt | ${include_command} | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt
    fi
else
    if [ '${include_command}' = 'null' ]; then
        grep -vE  '${exclude_command}' ${path}/temp/pre-disk.txt | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt
    else
        grep -vE  '${exclude_command}' ${path}/temp/pre-disk.txt | ${include_command} | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt
    fi
fi

# 生成初始化文件
${path}/bin/direct --init-disk-path ${path}/temp/init-disk.txt --direct-path ${path}/temp/drives.yaml --new-file-path ${path}/temp/init-drives.yaml

# 磁盘格式化
# kubectl directpv init ${path}/temp/init-drives.yaml
