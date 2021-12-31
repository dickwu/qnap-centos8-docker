FROM centos:8

LABEL maintainer="LIFEFARMER QNAP CENTOS 8 DEVELOPER ENVIRONMENT"
LABEL description="Docker Container for the PHP-SWOOLE, GIT , GOLANG"

RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm

# install lastest version of kernel
RUN dnf -y install https://www.elrepo.org/elrepo-release-8.el8.elrepo.noarch.rpm
RUN rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
RUN dnf makecache
RUN dnf --disablerepo="*" --enablerepo="elrepo-kernel" list available | grep kernel-ml
RUN dnf --enablerepo=elrepo-kernel install -y kernel-ml

# install iperf3 to make as default server

RUN dnf -y install iperf3

CMD ["iperf3 -s"]