# Project 18 — Network Monitoring with Nagios

A reproducible Nagios Core lab for monitoring a local web endpoint and demonstrating NRPE-style remote checks.

## What this project demonstrates

- Nagios Core host/service object definitions
- ICMP host reachability checks
- HTTP service checks
- Custom Nagios plugin return codes (`OK`, `WARNING`, `CRITICAL`, `UNKNOWN`)
- Example NRPE configuration for Linux hosts
- Docker Compose-based local lab
- Deterministic configuration validation in CI

## Repository layout

```text
nagios/
├── nagios.cfg
└── objects/
    ├── commands.cfg
    └── hosts.cfg
nrpe/
└── nrpe.cfg
plugins/
└── check_dummy.sh
scripts/
├── add_host.sh
└── send_notify.sh
docs/
└── USAGE.md
.github/workflows/
└── validate.yml
```

## Local lab

The Compose file runs Nagios Core for local experimentation. Docker is required.

```bash
docker compose config
docker compose up -d
docker compose ps
```

Open the Nagios UI at `http://localhost:8080` using credentials supplied by the selected image documentation. The repository does not commit credentials.

Stop the lab with:

```bash
docker compose down
```

## Monitoring model

The default host is `localhost` (`127.0.0.1`) with:

- `check-host-alive` — ICMP reachability
- `check_http` — HTTP availability on port 80

The sample NRPE configuration shows how a monitored Linux host could expose disk, load, and user-count checks to Nagios. NRPE should be restricted to the Nagios server in real deployments.

## Adding a host

```bash
./scripts/add_host.sh app01 192.0.2.10
```

Review the generated configuration before reloading Nagios. The helper validates the required arguments and rejects whitespace/control characters in host names and malformed IPv4 addresses.

## Testing

Static configuration tests are available under `tests/` and run in GitHub Actions. The local runner used for repository review does not provide Nagios Core or Docker, so this review does not claim a live Nagios startup. The CI workflow validates the configuration syntax and Compose definition in a clean environment.

## Important production note

This repository is an educational lab. Before production use, pin and vet container images, use HTTPS for the web interface, protect credentials/secrets, restrict NRPE/5666 to the monitoring server, configure TLS or other secure transport as appropriate, and build real notification/escalation policies.
