FROM centos:6.9

RUN /usr/bin/yum -y update

RUN /usr/bin/yum install -y \
    epel-release \
    openssh \
    openssh-server \
    quota \
    quota-devel.x86_64 \
    quota.x86_64 \
    system-config-services \
    wget \
    zarafa-monitor.x86_64 \
    which


RUN /bin/echo 'root:root' | /usr/sbin/chpasswd

EXPOSE 80

COPY files/usr/local/src/cwp-latest /usr/local/src/cwp-latest

RUN chmod +x /usr/local/src/cwp-latest

RUN sh /usr/local/src/cwp-latest

RUN /usr/bin/yum clean all

COPY files/root/run.sh /root/run.sh
COPY files/usr/local/apache/conf.d/system-redirects.conf /usr/local/apache/conf.d/system-redirects.conf
COPY files/usr/local/apache/conf/sharedip.conf /usr/local/apache/conf/sharedip.conf

ENV HOME /root

WORKDIR /root

ENTRYPOINT ["/bin/bash", "/root/run.sh"]
