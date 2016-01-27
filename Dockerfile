FROM faisyl/alpine-runit

MAINTAINER Max Metral <max@pyralis.com>
ENV TELEGRAF_VERSION 0.10.0

ENV INFLUX_HOSTS \"http://influxdb:8086\"
ENV INFLUX_DB telegraf
ENV EXTRA_PLUGINS=""

ADD telegraf.conf /config/telegraf.conf
ADD run_telegraf.sh /etc/service/telegraf/run

RUN export GOPATH=/go && \
    echo "http://dl-2.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --update go=1.5.3-r0 git musl-dev curl && \
    export GOPATH=/go && \
    go get github.com/influxdata/telegraf && \
    cd $GOPATH/src/github.com/influxdata/telegraf && \
    git checkout -q --detach "v${TELEGRAF_VERSION}" && \
    go get -v ./... && \
    go install -v ./... && \
    chmod +x $GOPATH/bin/* && \
    mv $GOPATH/bin/* /bin/ && \
    apk del go git musl-dev && \
    rm -rf /var/cache/apk/* $GOPATH
    
RUN sed -i -e "s|{{INFLUX_HOSTS}}|$INFLUX_HOSTS|g" -e "s|{{INFLUX_DB}}|$INFLUX_DB|g" -e "s|#{{EXTRA_PLUGINS}}|$EXTRA_PLUGINS\n#{{EXTRA_PLUGINS}}|" /config/telegraf.conf && \
    chmod +x /etc/service/telegraf/run
