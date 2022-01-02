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

# install git & PHP & extensions
RUN dnf install -y https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf module enable php:remi-8.0 -y
RUN dnf -y install git php php-swoole php-bcmath php-redis
# update theswoole configuration
RUN echo "swoole.use_shortname = Off" >> /etc/php.d/*-swoole.ini

# install GOLANG
RUN dnf -y install golang

COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

CMD ["./usr/local/bin/start.sh"]

EXPOSE 5201