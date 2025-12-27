# Home Assistant Add-on: Dozzle Agent

<div align="center">
  <img src="https://raw.githubusercontent.com/Erreur32/homeassistant-dozzle-agent/refs/heads/main/dozzle-agent/dozzle.svg" alt="Dozzle Agent" width="128" height="128">
  <h2>Dozzle Agent</h2>
</div>

[![Release][release-shield]][release]
![Project Stage][project-stage-shield]
![Project Maintenance][maintenance-shield]
[![License][license-shield]][license]
[![Issues][issues-shield]][issue]
[![Stargazers][stars-shield]][stars]

## About

[Dozzle Agent](https://github.com/amir20/dozzle) is a backend agent for Dozzle that allows monitoring Docker containers remotely from a main Dozzle instance.

This add-on runs **only** the Dozzle agent (backend, no UI) on port 7007. It is designed to be used with a main Dozzle instance that connects to this agent.

>⚠️ **This is not an official add-on from Dozzle!**  
>⚠️ **This add-on has NO web interface - it's a backend agent only!**  
>⚠️ **This repository is specifically for Dozzle Agent addon only**

---

## Quick Start

![Dozzle Screenshot](https://github.com/user-attachments/assets/b184931c-03d4-4e8a-b716-a9b17055892d)

[![Open your Home Assistant instance and show the add add-on repository dialog with a specific repository URL pre-filled.](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2FErreur32%2Fhomeassistant-dozzle-agent)

1. Click on button above
2. Click **ADD** and **RESTART** Home Assistant
3. Go to [Add-on Store](https://my.home-assistant.io/redirect/supervisor_store/)
4. Search for **"Dozzle Agent"**
5. Click **Install** and wait for the process to complete
6. Start the add-on

---

## 🚀 **Features**  

✔️ Backend agent for Dozzle  
✔️ Remote Docker container monitoring  
✔️ Lightweight and efficient  
✔️ No web interface (backend only)  
 

---

## 🛠 **Installation**  

1. **Open the Home Assistant Add-on Store**:  
   📌 [Access the Store](https://my.home-assistant.io/redirect/supervisor_store/)  

2. **Add this repository**:
   ```
   https://github.com/Erreur32/homeassistant-dozzle-agent
   ```

3. **Search for "Dozzle Agent"** in the Add-on Store  

4. **Install the add-on** and wait for the process to complete  

5. **Start the agent**

---

## Configuration

### Basic Options

```yaml
# Log level (debug, info, error)
log_level: info

# Agent hostname (optional, appears in Dozzle UI)
hostname: ""
```

---

## Usage

### Connecting from Main Dozzle Instance

1. The agent listens on port **7007**
2. From your main Dozzle instance, connect to this agent using:
   - Host: `[HA-IP]` or `[HA-Hostname]`
   - Port: `7007`

### Docker Compose Example

```yaml
services:
  dozzle:
    image: amir20/dozzle:latest
    environment:
      - DOZZLE_REMOTE_AGENT=192.168.1.200:7007
    ports:
      - 8080:8080
```

### Multiple Agents

You can connect to multiple agents:

```yaml
environment:
  - DOZZLE_REMOTE_AGENT=192.168.1.200:7007,192.168.1.201:7007,192.168.1.202:7007
```

**Note**: The agent does NOT have a web interface. It's a backend service that responds to connections from Dozzle instances.

---

## Support

Got questions?

You can open an issue here: [issue tracker][issue]

## Contributing

This is an active open-source project. We are always open to people who want to use
the code or contribute back to it.

## Authors & contributors

The original setup of this repository is by [Erreur32][erreur32].

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License - see the [LICENSE.md][license] file for details

[contributors]: https://github.com/Erreur32/homeassistant-dozzle-agent/graphs/contributors
[erreur32]: https://github.com/Erreur32
[issue]: https://github.com/Erreur32/homeassistant-dozzle-agent/issues
[license]: https://github.com/Erreur32/homeassistant-dozzle-agent/blob/main/LICENSE.md
[maintenance-shield]: https://img.shields.io/maintenance/yes/2024.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-stable-green.svg
[release-shield]: https://img.shields.io/badge/version-v0.2.5-blue.svg
[release]: https://github.com/Erreur32/homeassistant-dozzle-agent/releases/tag/v0.2.5
[license-shield]: https://img.shields.io/badge/license-MIT-blue.svg
[issues-shield]: https://img.shields.io/github/issues/Erreur32/homeassistant-dozzle-agent.svg
[stars-shield]: https://img.shields.io/github/stars/Erreur32/homeassistant-dozzle-agent.svg
[stars]: https://github.com/Erreur32/homeassistant-dozzle-agent/stargazers
