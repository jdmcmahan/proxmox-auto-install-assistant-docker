FROM --platform=amd64 debian:trixie@sha256:2dc419c6d7fe3dad0a2f9fd469c34cc90b0f9ba642d8fde837fe3d7d34a0e7f1

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
