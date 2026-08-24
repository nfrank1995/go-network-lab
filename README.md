Next-Steps:
- run network-probe container as a sidecar of the server to receive packages via tcpdump
- instead of using a go alpine image to run the client and server create a dockerfile for them and create their own image to be used in docker compose
- harden the docker images
- create a script to setup the network-probe containre
    - see if ansible can be used for this just to play around
- upgrade the docker server and client to use tls with certificates
- run another container acting as a dns server 
- try different networking tools to inspect the whole thing
- DOCUMENT the findings somewhere in this project, maybe in a notes file
