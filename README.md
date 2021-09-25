# Home Assistant Community Add-on: Projector Server

[![GitHub Release][releases-shield]][releases]
![Project Stage][project-stage-shield]
[![License][license-shield]](LICENSE.md)

![Supports aarch64 Architecture][aarch64-shield]
![Supports amd64 Architecture][amd64-shield]

JetBrains IDE's accessible through the browser (similar to vscode addon)

## About

This add-on is very similar to the [Visual Studio Code add-on](https://github.com/hassio-addons/addon-vscode), except it server the JetBrains IDE's using [Projector Server](https://github.com/JetBrains/projector-server).

The features are also very similar to the vscode addon as it was used as a base. Credits to the authors.

## Note

This add-on and Projector is in development stages and not as stable as the vscode add-on. Use at own risk. Help greatly appreciated.

## References

* https://github.com/JetBrains/projector-installer
* https://github.com/JetBrains/projector-server
* https://github.com/hassio-addons/addon-vscode

# (Potential) To Do's

* [websocket communication](https://developers.home-assistant.io/docs/add-ons/communication#home-assistant-core)
* install SSL certs in projector
* allow projector usage outside HA (remote client / expose port)
* ensure security
* improve docs
* allow IDE settings (memory, settings sync)
* fix terminal bug
