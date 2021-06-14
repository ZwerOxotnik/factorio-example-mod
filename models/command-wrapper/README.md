This modified module from [Custom commands template](mods.factorio.com/mod/cc-template) to simplify filtering of commands and gives ability to turn on/off commands via map settings.

And this module requires "[zk-lib](https://github.com/ZwerOxotnik/zk-lib)" mod for localization only. You can remove the dependency and put your own locales.

.\
├── [const-commands.lua](../../const-commands.lua) <- contains data for constant commands\
├── [switchable-commands.lua](../../switchable-commands.lua) <- contains data for switchable commands\
└── [settings.lua](../../settings.lua) <- creates new settings to give ability to turn on/off commands via map settings.\

[models/command-wrapper/control.lua](/control) <- contains logic for interaction with other modules on control and data stage. (**change commands there** and adapt scripts if you want)

What it can do
--------------

* Filter parameters of commands
* Add switchable commands via map settings
* Use built-in error handling of commands
* Double check of commands
* Has simple integration (4+ lines)
