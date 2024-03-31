#!/bin/bash
# 判断是否执行磁盘格式化操作
if [ ${run_init_disk} != true ]; then
    rm -f ${path}/temp/*txt
    rm -f ${path}/temp/*yaml
    exit 0
fi

# 如果没有设置过滤项，判断逻辑
date=$(date +%F-%H-%M-%S)
if [ '${exclude_command}' = 'null' ]; then
    if [ '${include_command}' = 'null' ]; then
        echo "\033[31m执行命令: grep 'YES' ${path}/temp/pre-disk.txt | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt \033[0m"
        grep 'YES' ${path}/temp/pre-disk.txt | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt

    else
        echo "\033[31m执行命令: grep 'YES' ${path}/temp/pre-disk.txt | ${include_command} | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt \033[0m"
        grep 'YES' ${path}/temp/pre-disk.txt | ${include_command} | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt
    fi
else
    if [ '${include_command}' = 'null' ]; then
        echo "\033[31m执行命令: grep 'YES' ${path}/temp/pre-disk.txt | grep -vE  '${exclude_command}' | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt \033[0m"
        grep 'YES' ${path}/temp/pre-disk.txt | grep -vE  '${exclude_command}' | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt
    else
        echo "\033[31m执行命令: grep -vE  '${exclude_command}' ${path}/temp/pre-disk.txt | ${include_command} | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt \033[0m"
        grep -vE  '${exclude_command}' ${path}/temp/pre-disk.txt | ${include_command} | awk -F '│' '{print $2, $3, $4, $5, $6, $7, $8, $9}' > ${path}/temp/init-disk.txt
    fi
fi


# 打印需要初始化的磁盘
cat ${path}/temp/init-disk.txt

# 生成初始化文件
# 如果沒有可格式化磁盘，不会生成文件
if [ -f ${path}/temp/drives.yaml ]; then
    ${path}/bin/direct --init-disk-path ${path}/temp/init-disk.txt --direct-path ${path}/temp/drives.yaml --new-file-path ${path}/temp/init-drives.yaml
fi

# 磁盘格式化
if [ -f ${path}/temp/init-drives.yaml ]; then
    len_num=$(wc -l ${path}/temp/init-drives.yaml)
    kubectl directpv init ${path}/temp/init-drives.yaml --dangerous
fi

# 清理环境
mkdir -p  ${path}/temp/$date
cp -r ${path}/temp/*.txt ${path}/temp/$date/
cp -r ${path}/temp/*.yaml ${path}/temp/$date/
rm -f ${path}/temp/*txt
rm -f ${path}/temp/*yaml
