# Changelog

## 0.3.4

### Changed

- **Dozzle updated to 10.0.0** — Docker image now pulls `amir20/dozzle:v10.0.0`.
- Updated `update_version.sh` script: new `--dozzle` option to update Dozzle Docker version across all files.

### Security

- **AppArmor profile** (`apparmor.txt`): Added for HA 2026 best practices; restricts add-on access and improves the security score (1–6).
- **Map permissions:** All mapped folders (`config`, `ssl`, `share`, `backup`, `media`) set to **read-only** (`:ro`); the agent does not write to them.

### Added

- WIKI section "Security score (1–6)" and Codenotary signing note.

## 0.3.3

### Changed

- (Version bump / Security update)

## 0.3.2

### Added

- **HA 2026 compliance:** Added `repository.yaml` at repository root. Kept `repository.json` for backward compatibility.
- Documentation for system permissions (SYS_ADMIN, DAC_READ_SEARCH) in WIKI and add-on README.

### Changed

- **Security:** Set `host_network: false` and use port mapping only. Agent remains accessible on host IP:7007.
- Updated WIKI "Network Configuration" and root README "Repository Structure".

## 0.3.1

### Fixed

- Removed invalid `docker_socket:rw` from `map`. Docker access via `docker_api: true` only.
- Set `udev: false` and kept only selective `devices` list (avoids Supervisor warning).

### Added

- Documentation for watchdog behavior and troubleshooting for Supervisor config warnings (WIKI).

## 0.3.0

### Fixed

- Fixed Dockerfile build failure (missing BUILD_FROM default, fallback to `alpine:latest`).

## 0.2.9

### Added

- DNS resolution troubleshooting in WIKI.

## 0.2.8

### Added

- Updated Dozzle to version 9.0.3.
