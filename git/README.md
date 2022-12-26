dex
![](https://gitlab.com/haath/dex/badges/master/pipeline.svg)
![](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)
---

Extension of the [hxdefold](https://github.com/hxdefold/hxdefold) library which allows writing scripts for the [Defold](https://defold.com/) game engine in Haxe.
This *pack* contains externs to various popular Defold libraries, as well as wrapper classes to some of the main Defold objects.
Haxe's [dead code elimination](https://haxe.org/manual/cr-dce.html) made it preferable to bundle a collection of library externs together, rather than create a separate repository for each one.


## Installation

```sh
haxelib git dex https://gitlab.com/haath/dex
```

And in the `hxml`:

```hxml
-lib hxdefold:git:https://github.com/hxdefold/hxdefold
-lib dex:git:https://gitlab.com/haath/dex
```


## Library Externs

- [A*](https://github.com/selimanac/defold-astar) `defold.lib.astar.Astar`
- [DefOS](https://github.com/subsoap/defos) `defold.lib.defos.DefOS`
- [DirtyLarry](https://github.com/andsve/dirtylarry) `defold.lib.dirtylarry.DirtyLarry`
- [DiscordRich](https://github.com/subsoap/discordrich) `defold.lib.discordrich.DiscordRich`
- [Monarch](https://github.com/britzl/monarch) `defold.lib.monarch.Monarch`
- [Orthographic Camera](https://github.com/britzl/defold-orthographic) `defold.lib.orthographic.Camera`
- [Rendercam](https://github.com/rgrams/rendercam) `defold.lib.rendercam.Rendercam`
