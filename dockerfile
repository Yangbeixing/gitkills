FROM alpine:latest

RUN echo "https://mirror.tuna.tsinghua.edu.cn/alpine/v3.4/main/" > /etc/apk/repositories
RUN apk update \
        && apk upgrade \
        && apk add --no-cache bash \
        bash-doc \
        bash-completion \
        && rm -rf /var/cache/apk/* 
ADD etcd /usr/local/bin/
ADD etcdctl /usr/local/bin/
RUN mkdir -p /var/etcd/
RUN mkdir -p /var/lib/etcd/
VOLUME /usr/share/etcd_data/ /export/etcd_data
EXPOSE 2379 2380
COPY ./docker-entrypoint.sh /usr/local/bin/
RUN ["chmod","+x","/usr/local/bin/docker-entrypoint.sh"]
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
