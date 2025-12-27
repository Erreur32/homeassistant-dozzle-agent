# Changelog

## 0.2.6

### Added
- Update in advance 2026 [maintenance-shield]

## 0.2.5

### Added
- Fix URL img readme

## 0.2.4

### Added
- Add .gitignore files

## 0.2.3

### Added
- Clean Readme.md

## 0.2.2

### Added
- Added Dozzle SVG logo to README files
- Added "Dozzle Agent" title text next to logo in READMEs
- Added Quick Start section with Home Assistant badge in main README

### Changed
- Updated README presentation with centered logo and title
- Improved visual branding with SVG logo instead of PNG

## 0.2.1

### Changed
- Reorganized repository structure for Home Assistant compatibility
  - Created `repository.json` at root for Home Assistant repository recognition
  - Moved all add-on files to `dozzle-agent/` directory
  - Repository now follows Home Assistant add-on repository structure
- Cleaned up development documentation files
  - Consolidated all dev documentation into DEV.md
  - Removed redundant documentation files

## 0.2.0

### Changed
- Updated all repository URLs to `homeassistant-dozzle-agent`
- Updated documentation links in config.yaml
- Updated README.md with correct repository references
- Reorganized repository structure for Home Assistant compatibility
  - Created `repository.json` at root
  - Moved all add-on files to `dozzle-agent/` directory
  - Repository now follows Home Assistant add-on repository structure

### Added
- Comprehensive wiki documentation (WIKI.md)
- Complete installation and usage guide
- Troubleshooting section
- FAQ section
- Advanced configuration documentation
- `repository.json` for Home Assistant repository recognition

## 0.1.0

### Added
- Initial release of Dozzle Agent add-on
- Backend-only agent mode (no UI)
- Port 7007 for agent connections
- Simple configuration (log_level only)
- Host network mode for direct access

### Features
- Dozzle Agent backend service
- Docker socket access via docker_socket:rw
- Lightweight and efficient

