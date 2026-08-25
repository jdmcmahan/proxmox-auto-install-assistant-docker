FROM --platform=amd64 debian:trixie@sha256:f324c7ff54321e8d9c588493a20244965938ce0aa50bbd1022d38010e9ffc4b1

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
