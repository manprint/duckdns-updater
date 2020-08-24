FROM jrei/systemd-ubuntu:18.04

RUN set -xev; \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nano sudo wget apt-utils tzdata locales curl && \
    apt-get clean && \
    rm -rf /usr/share/doc/* /usr/share/man/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV TZ=Europe/Rome

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime \
     && echo $TZ > /etc/timezone

RUN set -xe &&\
    dpkg-reconfigure --frontend=noninteractive tzdata && \
    sed -i -e 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/' /etc/locale.gen && \
    echo 'LANG="it_IT.UTF-8"'>/etc/default/locale && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=it_IT.UTF-8

ENV LANG it_IT.UTF-8
ENV LANGUAGE it_IT.UTF-8
ENV LC_ALL it_IT.UTF-8

RUN set -xev; \
    echo "export LC_ALL=it_IT.UTF-8" >> /root/.bashrc; \
    echo "export LANG=it_IT.UTF-8" >> /root/.bashrc; \
    echo "export LANGUAGE=it_IT.UTF-8" >> /root/.bashrc

# install duckdns service and timer
COPY ./updater.sh /bin/updater.sh
COPY ./duckdns-updater.service /lib/systemd/system/duckdns-updater.service
COPY ./duckdns-updater.timer /lib/systemd/system/duckdns-updater.timer

# container expect env file at path below
# env file is not copied inside a container for security reason!
# /lib/systemd/system/environment

# fix getty 100% cpu usage (remove service)
RUN rm -rvf /lib/systemd/system/getty.target.wants

# enable services
RUN systemctl enable duckdns-updater.service
RUN systemctl enable duckdns-updater.timer
