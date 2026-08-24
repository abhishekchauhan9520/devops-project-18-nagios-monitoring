# Usage

## Start

```bash
docker compose up -d
docker compose ps
```

Open `http://localhost:8080`.

## Validate before reload

```bash
docker compose config
```

For a host added with `scripts/add_host.sh`, review the generated definition before applying it to a real Nagios installation.

## NRPE example

The `nrpe/nrpe.cfg` file is an example only. On real hosts, restrict `allowed_hosts` to the Nagios server and protect port 5666 at the network layer.

## Stop

```bash
docker compose down
```
