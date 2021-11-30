# Bugs Out

This game is developed using the excellent [Godot Engine](https://godotengine.org/) and is my submission for the [Game Off 2021](https://itch.io/jam/game-off-2021) jam.

* [Description](#description)
* [Inspiration](#inspiration)
* [Development](#development)
  * [Project Organization](#project-organization)
  * [Next steps](#next-steps)
* [Credits](#credits)
* [References](#references)
* [3rd party assets](#3rd-party-assets)

## Description

Each players choose a resource between an apple, a cheese, a cookie or a carrot and must try to guide the bug to their resource to win a token. First player with 5 tokens win the game !

Each turn, player rolls a dice to know which obstacle they can rotate to create a path to reach the resources.

## Inspiration

All inspiration is coming from [Bugs in the Kitchen](https://boardgamegeek.com/boardgame/137909/bugs-kitchen) board game by Ravensburger.

## Development

Some resources for the developers around.

### Project Organization

| Path         | Description                                           |
| ------------ | ----------------------------------------------------- |
| `resources/` | Resources such as images, fonts, ... used in the game |
| `tests/`     | Testing scenes game logic                             |

### Next steps

* [ ] Add support for 2 (current) to 4 players in local (current) and remote
* [ ] Mobile support (Android / Web)
* [ ] [Steam with Remote Play Together](https://github.com/Gramps/GodotSteam) (instead of custom server ?)

## Credits

Released under the [MIT license](LICENSE.txt).

This game uses [Godot Engine](https://godotengine.org/).

Sprites have been created using [Aseprite](https://www.aseprite.org/).

## References

Books:

* [The Nature of Code](https://natureofcode.com/)

Community:

* [r/godot](https://www.reddit.com/r/godot/)

## 3rd party assets

Gfx:

* [Cookie](https://opengameart.org/content/pixel-cookie)
* [Cheese and carrot](https://opengameart.org/content/cartoon-food)
* [Apple](https://opengameart.org/content/apple-2)
* [Bug animation](https://opengameart.org/content/earwig-top-down)
* [Coin animation](https://opengameart.org/content/coin-animation)

Fonts:

* [Pixeboy font](https://www.fontspace.com/pixeboy-font-f43730)
