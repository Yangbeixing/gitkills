#!/bin/bash
#Filename:docker-entrypoint.sh
#Author_by:Andy_xu 
#Contact:[mail:371990778@qq.com,QQ:371990778]
#Date:2017-07-25 16:42
#Description:
if [ -z $NAME ];then
    NAME=my-etcd-1
fi
if [ -z $DATADIR ];then
    DATADIR=/export/etcd_data
fi
if [ -z $MYHOST ];then
    MYHOST=http://localhost
fi
if [ -z $PORT ];then
        PORT=2379
fi
if [ -z $CLUSTER_PORT ];then
        CLUSTER_PORT=2380
fi
if [ -z $CLUSTER ];then 
    CLUSTER=my-etcd-1=http://localhost:2380
fi
if [ -z $CLUSTER_TOKEN ];then 
    CLUSTER_TOKEN=my-etcd-token
fi
if [ -z $CLUSTER_STATE ];then
    CLUSTER_STATE=new
fi
workdir=$(cd $(dirname $0); pwd)
echo $workdir
    
ETCD_CMD="/usr/local/bin/etcd --name ${NAME} --data-dir ${DATADIR}  \
    --listen-client-urls http://0.0.0.0:${PORT}  \
    --advertise-client-urls ${MYHOST}:${PORT} \
    --listen-peer-urls ${MYHOST}:${CLUSTER_PORT} \
    --initial-advertise-peer-urls ${MYHOST}:${CLUSTER_PORT} \
    --initial-cluster $CLUSTER  \
     --initial-cluster-token $CLUSTER_TOKEN \
    --initial-cluster-state ${CLUSTER_STATE} \
    $*"
echo -e "Running '$ETCD_CMD'\nBEGIN ETCD OUTPUT\n"
exec $ETCD_CMD
