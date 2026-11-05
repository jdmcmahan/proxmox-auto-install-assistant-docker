FROM --platform=amd64 debian:trixie@sha256:9c6e381421d0f48d1b8133e573f33c185ee16cbf505eda9c4a8a4791b25ea8a6

RUN apt-get update \
    && apt-get install -y extrepo

RUN extrepo enable proxmox-pve

# renovate: repoUrl=http://download.proxmox.com/debian/pve depName=proxmox-auto-install-assistant suite=trixie components=pve-no-subscription
ENV PROXMOX_AUTO_INSTALL_ASSISTANT_VERSION=9.2.8

RUN apt-get update \
   && apt-get install -y proxmox-auto-install-assistant="${PROXMOX_AUTO_INSTALL_ASSISTANT_VERSION}" \
   && rm -rf /var/lib/apt/lists/* \
   && apt-get clean

ENTRYPOINT [ "proxmox-auto-install-assistant" ]
CMD [ "--help" ]
