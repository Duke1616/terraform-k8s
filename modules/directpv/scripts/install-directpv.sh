#!/bin/bash
IS_DEPLOY=$(kubectl get daemonset -n directpv|wc -l)

# 判断服务是否部署
if [ ${IS_DEPLOY} -le 1 ]; then
    $HOME/.krew/bin/kubectl-directpv install --node-selector directpv.min.io/enabled=true
fi

# 判断服务是否运行成功
while true; do
    DESIRED=$(kubectl get daemonset -n directpv|tail -1|awk '{print $2}')
    READY=$(kubectl get daemonset -n directpv|tail -1|awk '{print $4}')
    if [ ${DESIRED} -eq ${READY} ];then
        break
    else
        sleep 5
    fi
done
