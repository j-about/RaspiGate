FROM debian:bookworm-slim

RUN apt-get update && \
    apt-get install -y \
    iptables \
    openvpn && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/vpn-client

COPY up.sh down.sh entrypoint.sh ./

RUN chmod +x up.sh down.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
