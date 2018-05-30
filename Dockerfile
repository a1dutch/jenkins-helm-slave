FROM jenkins/jnlp-slave:3.19-1

ARG KUBE_VERSION=1.9.7
ARG HELM_VERSION=2.9.1
ARG HELM_S3_VERSION=0.6.1

USER root

RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBE_VERSION}/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && \
  mv ./kubectl /usr/local/bin/kubectl

RUN curl -LO https://storage.googleapis.com/kubernetes-helm/helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
  tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz && \
  chmod +x linux-amd64/helm && \
  mv linux-amd64/helm /usr/local/bin/helm && \
  rm -rf linux-amd64

RUN apt-get update && apt-get install make -qqy && \
  rm -rf /var/lib/apt/lists/*

ADD jenkins-slave-startup.sh /usr/local/bin/jenkins-slave-startup.sh
RUN chmod +x /usr/local/bin/jenkins-slave-startup.sh

USER jenkins

RUN helm init --client-only

RUN helm plugin install https://github.com/hypnoglow/helm-s3.git --version ${HELM_S3_VERSION}

ENTRYPOINT ["jenkins-slave-startup.sh"]
