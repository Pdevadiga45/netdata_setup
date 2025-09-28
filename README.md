## Netdata Docker Setup

This repository provides a minimal Docker-based setup to run Netdata locally with a few demo health alarms and handy tools to simulate load.

### What’s inside
- **Docker image**: Built from `netdata/netdata:latest` with `stress`, `wget`, and `ping` added for demos (see `Dockerfile`).
- **Compose service**: Exposes the Netdata dashboard on port `19999`, mounts custom alarms from `health.d`, and disables Cloud by default (see `docker-compose.yml`).
- **Demo health alarms**: Example rules in `health.d/*.conf` for CPU, memory, disk, and network. Thresholds are intentionally low for demonstration.

### Prerequisites
- Docker
- Docker Compose v2 (`docker compose`)

### Quick start
```bash
docker compose up -d
# Open the dashboard
# http://localhost:19999
```

### Health alarms
Custom alarm configs live under `health.d/` and are mounted to the container at `/etc/netdata/health.d`.
- `cpu_usage.conf`: warns/criticals on average CPU usage
- `memory_usage.conf`: warns/criticals on RAM used
- `disk_usage.conf`: warns/criticals on disk space used
- `network_usage.conf`: warns/criticals on inbound traffic

These thresholds are set very low on purpose so it’s easy to trigger alerts during demos. Adjust values as needed and then restart the service:
```bash
docker compose restart
```

### Simulate load (optional)
Use the built-in tools inside the running container:
```bash
# CPU load for 60s
docker exec -it netdata stress --cpu 2 --timeout 60s

# Ping a host
docker exec -it netdata ping -c 5 1.1.1.1

# Fetch a file to exercise network
docker exec -it netdata wget -O /tmp/index.html https://example.org
```

### Configuration notes
- The service runs with `SYS_PTRACE` and `apparmor:unconfined` to allow Netdata features that require additional capabilities.
- Cloud is disabled by default via `NETDATA_CLOUD_DISABLE=yes`. To explore Netdata Cloud, remove or set this variable to `no` and follow Netdata’s onboarding in the UI.

### Stop and cleanup
```bash
docker compose down
# To also remove any named volumes (none are defined here) add: -v
```

### Rebuild the image
```bash
docker compose build --no-cache
```

### Repository
`https://github.com/Pdevadiga45/netdata_setup`


