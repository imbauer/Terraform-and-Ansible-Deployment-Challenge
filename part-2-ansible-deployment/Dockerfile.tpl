# Latest Ubuntu LTS
FROM ubuntu:bionic
RUN apt-get update && \
    apt-get install --no-install-recommends -y software-properties-common && \
    apt-add-repository ppa:ansible/ansible && \
    apt-get update && \
    apt-get install -y ansible

RUN echo '[webservers]\nREPLACEME\n' > /etc/ansible/hosts