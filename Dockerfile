FROM --platform=amd64 debian:bookworm@sha256:bd73076dc2cd9c88f48b5b358328f24f2a4289811bd73787c031e20db9f97123

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
