![ZombieLike logo with text](https://github.com/Xibitol/ZombieLike/blob/master/Logo/logo.png?raw=true)

# ZombieLike
It's a game mode from Garry's Mod. The objective is to kill zombies by infinite waves and with the points you earn you can buy weapons, give yourself care, add armor...

Link to gamemode steam page : [ZombieLike]()

**Important :** You must have all "FA:S 2.0 Alpha SWEPs" addons and "Map for ZombieLike" addon. A collection to make your life easier : [ZombieLike Collection](https://steamcommunity.com/sharedfiles/filedetails/?id=2119249878)

## Modules
[See all tasks](https://github.com/Xibitol/ZombieLike/blob/master/TASKS.md)

### Init files
- **Finished**

### ZLDraw (_MainDrawModule_)
- **Finished**

### GameStatus (_MainModule_)
- _In waiting_
- [ ] On Build, give physgun and zl_hand

### GameData (_MainDataModule_)
- **Finished**

### MenuSystem
- _In waiting_
- [ ] The host can go in build mode (For add props in world)

### ZombieManager
- **Finished**

### Hud
- In progress
- [ ] Draw the player's health and name on the top of his head.

### F4Menu
- _In waiting_
- [ ] Draw a F4Menu
- [ ] Can open if the game status is "WaveTransition"
- [ ] Easy creating tab in menu
#### Dashboard
- [ ] Can see player's stats (Name, Model, Health, Battery, ZombieKilled and Experiance)
- [ ] The host can stop the game
#### Weapons
- [ ] Buy weapon (Entity, OnBuyCharger)
- [ ] Buy Charger on every weapon (Ammo)
#### Other
- [ ] Config file for element (Name, Price, Entity or Value)
- [ ] Buy armor (Value to give : 35)
- [ ] Buy a medic kit ("fas2_ifak")

### F1Menu
- _In waiting_
- [ ] Draw a F1Menu
- [ ] Can open if the game status is "Build"
- [ ] Spawn, in config file, preselected prop
- [ ] The host can return in menu

### ScoreBoard
- _In waiting_
- [ ] Draw a Scoreboard
- [ ] Look players stats (Health, Battery, ZombieKilled, Experiance and HighestExperiance)
- [ ] For host : kick player, remove all weapons except the starting, clear experiance

### FinishSystem
- _In waiting_
- [ ] Show this if all players death or host stop game
- [ ] Display the best player stats (three maximum), for the player who has the most ammo, who has killed the most zombies and who has sympathized with the enemy (who has killed the least zombies).
- [ ] Go, with a wait, in the menu
- [ ] If this is a new highest score save it

## Developpers
> Xibitol
