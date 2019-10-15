FROM jenkins/jenkins:centos
USER root
RUN yum makecache && \
    yum update && \
    yum install -y make && \
    yum install -y bzip2 && \
    yum install -y wget && \
    yum install -y python36 && \
    yum install -y python-pip && \
    pip install --upgrade pip && \
    pip install yq && \
    wget -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-19.03.1.tgz && \
    gunzip -c docker.tgz | tar xvf - && \
    mv docker/docker /usr/bin/docker && \
    chmod +x /usr/bin/docker && \
    rm -rf ./docker ./docker.tgz && \
    yum clean all
