FROM --platform=amd64 debian:bookworm@sha256:731dd1380d6a8d170a695dbeb17fe0eade0e1c29f654cf0a3a07f372191c3f4b

RUN apt-get update \
    && apt-get install -y wget \
    && wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bookworm.gpg \
    && echo "deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription" > /etc/apt/sources.list

# renovate: repoUrl=http://download.proxmox.com/debian/pve depName=proxmox-auto-install-assistant suite=bookworm components=pve-no-subscription
ENV PROXMOX_AUTO_INSTALL_ASSISTANT_VERSION=8.4.6

RUN apt-get update \
   && apt-get install -y proxmox-auto-install-assistant="${PROXMOX_AUTO_INSTALL_ASSISTANT_VERSION}" \
   && rm -rf /var/lib/apt/lists/* \
   && apt-get clean

ENTRYPOINT [ "proxmox-auto-install-assistant" ]
CMD [ "--help" ]
