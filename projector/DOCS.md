# Home Assistant Community Add-on: Projector server

This add-on allows JetBrains IDE's to be installed within home assistant and accessed in the UI using the browser. It is very similar to the [Visual Studio Code add-on](https://github.com/hassio-addons/addon-vscode) which was used as a starting point in the setup.

Using the configuration, a wide variety of IDE's can be installed, for example:

* IDEA Ultimate
* PyCharm
* GoLand
* WebStorm
* PhpStorm
* more [compatible IDE's](https://github.com/JetBrains/projector-installer/blob/master/projector_installer/compatible_ide.json)

__Warning:__ Both this add-on and projector are fairly new. The add-on could have issues on stability / security. Help is appreciated, use at own risk.

## Installation

The installation of this add-on is pretty straightforward and not very different in comparison to installing the vscode add-on, or other add-ons.

1. Search for the "Projector Server" add-on in the Supervisor add-on store
   and install it. (Install the add-on git url as repository first)
2. (optional) set an IDE/app in the config.
3. Start the "Projector Server" add-on.
4. Check the logs of the "Projector Server" add-on to see if everything went
   well.
5. Click the "OPEN WEB UI" button to open Projector Server.

Some IDE's require a license. A 30 day trial is available and your own license can be used.

## Configuration

**Note**: _Remember to restart the add-on when the configuration is changed._

Example add-on configuration:

```yaml
packages:
  - mariadb-client
init_commands:
  - ls -la
app: "IntelliJ IDEA Ultimate 2020.3.4"
config_name: "idea"
log_level: info
config_path: /share/projector
host: 0.0.0.0
```

**Note**: _This is just an example, don't copy and paste it! Create your own!_

### Option: `app`

Select an app from the [compatible ide list](https://github.com/JetBrains/projector-installer/blob/master/projector_installer/compatible_ide.json) and use the whole __name__ string.

This app will be installed and ran on start.

### Option: `config_name`

This field defines the identifier for the current app/IDE configuration. Would you change this field and restart, the IDE from the app field is installed under a different config. This would allow to switch or modify.

### Option: `config_path`

This is the patch where projector stores configurations, cache and apps. You want this persistent as there's a lot of data. It seemed best to have this currently in shared to allow easy configurations and persistence.

@todo install in data by default, have other home config folders linked

### Option: `host`

The IP where projector will be served, defaults to availables. Should be more strict for security.

### Option: `packages`

Allows you to specify additional [Ubuntu packages][ubuntu-packages] to be
installed in your shell environment (e.g., Python, PHP, Go).

**Note**: _Adding many packages will result in a longer start-up
time for the add-on._

### Option: `init_commands`

Customize your VSCode environment even more with the `init_commands` option.
Add one or more shell commands to the list, and they will be executed every
single time this add-on starts.

### Option: `log_level`

The `log_level` option controls the level of log output by the addon and can
be changed to be more or less verbose, which might be useful when you are
dealing with an unknown issue. Possible values are:

- `trace`: Show every detail, like all called internal functions.
- `debug`: Shows detailed debug information.
- `info`: Normal (usually) interesting events.
- `warning`: Exceptional occurrences that are not errors.
- `error`: Runtime errors that do not require immediate action.
- `fatal`: Something went terribly wrong. Add-on becomes unusable.

Please note that each level automatically includes log messages from a
more severe level, e.g., `debug` also shows `info` messages. By default,
the `log_level` is set to `info`, which is the recommended setting unless
you are troubleshooting.


## switching app/IDE

The projector server installer has commands to help you find a proper IDE/version. Since we cannot do this the IDE must be specified under `app` in the addon config.

Any IDE could be used but there's a list of [compatible IDE's](https://github.com/JetBrains/projector-installer/blob/master/projector_installer/compatible_ide.json) in the projector installer repository. Copy the __full name__ into the app config field. For example:

* IntelliJ IDEA Ultimate 2020.3.4
* PyCharm Community Edition 2020.3.5
* WebStorm 2020.3.3
* PhpStorm 2020.3.3
* GoLand 2020.3.5

If you want to switch between IDE's that's possible by specifying a different name under the `config_name` field. The config name field is used as an identifier while installing and running an app/IDE. You could switch IDE's by changing the `config_name`.

## Connecting outside home assistant / projector client

It is possible to open the IDE in the browser on a different tab if the add-on port is exposed (more UI space). Also the projector client can be used. This might require some security / SSL / network changes but it's possible (not out of the box). 

## Resetting & disk space

Projector caches the IDE's it downloads under the config directory. You should watch your disk space as this can go up fast. I prefer to install everything in the share folder so it's easier to work with.

Some IDE specific settings are stored in other places, similar to a linux installation. Having more cont



## Changelog & Releases

This repository keeps a change log using [GitHub's releases][releases]
functionality.

Releases are based on [Semantic Versioning][semver], and use the format
of `MAJOR.MINOR.PATCH`. In a nutshell, the version will be incremented
based on the following:

- `MAJOR`: Incompatible or major changes.
- `MINOR`: Backwards-compatible new features and enhancements.
- `PATCH`: Backwards-compatible bugfixes and package updates.

## Support

Got questions?

You have several options to get them answered:

- Find me on twitter [@fros_it](https://twitter.com/fros_it)
- [open an issue here][issue] on GitHub.

## Authors & contributors

This addon uses the [Visual Studio Code addon](https://github.com/hassio-addons/addon-vscode) as a starting point which was created by [Franck Nijhof][https://github.com/frenck].

The projector implementation is done by [Fabio Ros][https://github.com/frosit]

For a full list of all authors and contributors,
check [the contributor's page][contributors].

## License

MIT License

Copyright (c) 2019-2021 Fabio Ros

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[contributors]: https://github.com/frosit/addon-projector-server/graphs/contributors
[issue]: https://github.com/frosit/addon-projector-server/issues
[releases]: https://github.com/frosit/addon-projector-server/releases
[semver]: http://semver.org/spec/v2.0.0
[ubuntu-packages]: https://packages.ubuntu.com




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
