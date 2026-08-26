FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
	tcpdump \
	iputils-ping \
	curl \
	iproute2 \
	iptables \
	dnsutils \
	net-tools \
	iperf3 \
	tshark \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
CMD ["/bin/bash"]
