FROM google/cloud-sdk:217.0.0-alpine

ENV HELM_VERSION v2.11.0
ENV HELM_FILENAME helm-${HELM_VERSION}-linux-amd64.tar.gz
ENV HELM_URL https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME}
ENV G_SERVICE_ACCOUNT ${G_SERVICE_ACCOUNT:-/tmp/secrets/service-account.json}

WORKDIR /
VOLUME /secrets

RUN gcloud components install kubectl \
  && curl -s -o /tmp/${HELM_FILENAME} ${HELM_URL} \
  && tar -zxvf /tmp/${HELM_FILENAME} -C /tmp \
  && mv /tmp/linux-amd64/helm /bin/helm \
  && rm -rf /tmp \
  && helm init --client-only

ADD authenticate.sh /usr/bin/authenticate
ADD deploy.sh /usr/bin/deploy

ENTRYPOINT ["authenticate"]

CMD ["bash"]
