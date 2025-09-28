FROM netdata/netdata:latest

# Install stress + wget + ping for demos
RUN apt-get update && apt-get install -y stress wget iputils-ping && rm -rf /var/lib/apt/lists/*
