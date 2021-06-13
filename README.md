**[Notes](#notes)** |
**[Contributing](#contributing)** |
**[Disclaimer](#disclaimer)** |
**[License](#license)**

---

<p align="center">
  <img
    width="144"
    src="thumbnail.png"
    alt="Example mod"
  />
</p>

<p align="center">
  <a href="https://github.com/ZwerOxotnik/example-mod/tags">
    <img src="https://img.shields.io/github/tag/ZwerOxotnik/factorio-example-mod.svg?label=Release&color=FF5500" alt="Release">
  </a>
  <a href="https://github.com/ZwerOxotnik/example-mod/stargazers">
    <img src="https://img.shields.io/github/stars/ZwerOxotnik/factorio-example-mod.svg?label=Stars&color=F08125" alt="Star">
  </a>
  <a href="https://discordapp.com/invite/YyJVUCa">
    <img src="https://discordapp.com/api/guilds/480103519769067542/widget.png?style=shield" alt="Discord">
  <br/>
  <a href="https://www.patreon.com/ZwerOxotnik">
    <img src="https://ionicabizau.github.io/badges/patreon.svg" alt="Patreon">
  <a href="https://ko-fi.com/zweroxotnik">
    <img src="https://www.buymeacoffee.com/assets/img/guidelines/download-assets-sm-2.svg" height="20" alt="Buy me a coffee">
  <a href="http://github.com/ZwerOxotnik/example-mod/fork">
    <img src="https://img.shields.io/github/forks/ZwerOxotnik/factorio-example-mod.svg?label=Forks&color=7889DD" alt="Fork">
  </a>
</p>

<p align="center">
  <a href="changelog.txt">Changelog</a>
  ·
  <a href="https://crowdin.com/project/factorio-mods-localization">Translations</a>
</p>

<h1></h1>

<!-- Put your "fancy" image/video here -->
<!-- <img
  src=""
  align="right"
/> -->

Example mod
-----------------------

Lightweight modular example mod with various features and compatibilities

<p align="center">
  <a href="https://mods.factorio.com/mod/example-mod/downloads"><strong>Download the mod&nbsp;&nbsp;▶</strong></a>
</p>

What it can do
--------------

* Filter parameters of commands
* Add switchable commands via map settings
* Use built-in error handling of commands
* Use modular structure
* Remotely and safely disable your mod

What it enables you to do
-------------------------

* Make switchable, simpler and safer [coommands](models/command-wrapper/README.md)
* Make "isolated" modules
* Expand your modules
* More possibilities to control logic

Useful stuff
------------

* Factorio modding: https://wiki.factorio.com/Modding
* GitHub service for localization via crowdin: https://github.com/dima74/factorio-mods-localization
* Optimisation tips: https://stigmax.gitbook.io/lua-guide/auxiliary/optimizations & http://lua-users.org/wiki/OptimisationTips

Stuff used
----------

* [A GitHub Action](https://github.com/shanemadden/factorio-mod-portal-publish) to automatically publish to the Factorio mod portal
* [EditorConfig](https://editorconfig.org/) - helps maintain consistent coding styles for multiple developers working on the same project across various editors and IDEs
* Factorio's event handler (See Factorio's folder `..\data\core\lualib\event_handler.lua`)
* [git](https://git-scm.com/downloads) - version control system
* [Visual Studio Code](https://code.visualstudio.com/) - code editor
* Some ZwerOxotnik's code

How to start?
------------

* Replace my nickname, this project in links with your stuff almost everywhere
* **Change** settings in [models/command-wrapper/control.lua](models/command-wrapper/control.lua)
* Remove unnecessary code, files in /models and create a file there with similar structure in the folder
* Handle files in [control.lua](control.lua)
* **Change or delete** .github/ISSUE_TEMPLATE/*

Notes
-----

* There are mods that might help you (e.g.: [Brush tools](https://mods.factorio.com/mod/brush-tools), [Mod generator](https://github.com/ZwerOxotnik/Mod-generator) etc)
* Don't restart your game if you've changed files for control stage
* If you want to develop complex/big project then you'll probably try [Factorio-luacheckrc](https://github.com/Nexela/Factorio-luacheckrc) with a [GitHub action](https://github.com/Roang-zero1/factorio-mod-luacheck) but you have to mantain .luacheckrc file
* I recommend to use [notepad++](https://notepad-plus-plus.org) when you work with data and [notepad2](https://github.com/zufuliu/notepad2) for hot fixes. For all other cases use any IDE or code editor (e.g.: [Visual Studio Code](https://code.visualstudio.com/))

Next updates
------------

* More info about data stage
* More simplification, integrations, examples
* More examples of particular cases on all stages
* Support of [SimpleAPI](https://mods.factorio.com/mod/diplomacy/discussion/60c1eb9177457f7dd7943e14) (diplomacy, money, chat, etc)
* Etc

Optional Dependencies
---------------------

* <a href="github.com/ZwerOxotnik/zk-lib" target="_blank"><code>zk-lib</code></a> - for localization, currently

‼️ Important Links (Translations, Discord Support)
---------------------------------------------------------------

| Installation Guide | Translations | Discord |
| ------------------ | ------------ | ------- |
| 📖 [Installation Guide](https://wiki.factorio.com/index.php?title=Installing_Mods) | 📚 [Help with translations](https://crowdin.com/project/factorio-mods-localization) | 🦜 [Discord](https://discord.gg/zYTM3rZM4T) |

If you want to download from this source, then use commands below (requires [git](https://git-scm.com/downloads)).

```bash
git clone --recurse-submodules -j8 https://github.com/ZwerOxotnik/factorio-example-mod
cd example-mod
```

[Contributing](/CONTRIBUTING.md)
--------------------------------

Don't be afraid to contribute! We have many, many things you can do to help out. If you're trying to contribute but stuck, tag @ZwerOxotnik

Alternatively, join the [Discord group](https://discordapp.com/invite/YyJVUCa) and send a message there.

~~Please read the [contributing file](/CONTRIBUTING.md) for other details on how to contribute.~~

License
-------

I'm interested in distributing code as freely as possible.

Copyright (c) 2021 ZwerOxotnik <zweroxotnik@gmail.com>

Licensed under the [MIT licence](https://tldrlegal.com/license/mit-license).

```
The MIT License (MIT)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
