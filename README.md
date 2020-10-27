![ZombieLike logo with text](https://github.com/Xibitol/ZombieLike/blob/master/Logo/logo.png?raw=true)

# ZombieLike
It's a game mode from Garry's Mod. The objective is to kill zombies by infinite waves and with the points you earn you can buy weapons, give yourself care, add armor...

Link to gamemode steam page : [ZombieLike]()

**Important :** You must have all "FA:S 2.0 Alpha SWEPs" addons and "Map for ZombieLike" addon. A collection to make your life easier : [ZombieLike Collection](https://steamcommunity.com/sharedfiles/filedetails/?id=2119249878)

## Modules
### Init files
- In progress
- [ ] Include all modules
- [x] Create ZL module
- [x] Check if all "FA:S 2.0 Alpha SWEPs" addons and "Map for ZombieLike" addon is installed (on serveur or on client make game), otherwise it not start all script
- [x] Send a message when the player connects and spawn
- [x] Set player model

### ZLDraw (_MainDrawModule_)
- **Finished**
- [x] Create ZLDraw module
- [x] Function for draw a box and rounded box
- [x] Function for draw a box with border and rounded box with border
- [x] Function for draw a outline box
- [x] Function for draw image
- [x] Function for draw a text (Can choose police : "ZL200", "ZL100", "ZL50", "ZL28", "ZL10")
- [x] Function for draw multiple text with different color and font in one line
- [x] Function for get text size by selecting font

### GameStatus (_MainModule_)
- In progress
- [x] Change the status and send call hook ("Menu","Play","WaveTransition","Build")
- [ ] On Playing, give initial weapon ("fas2_machete", "fas2_p226") (OnStart and OnStartMunition in weapons F4 menu in config file)
- [ ] On Build, give physgun
- [x] Call think hook ("MenuThink","PlayingThink","WaveTransitionThink","BuildThink")
- [x] Update Client and Server

### GameData (_MainDataModule_)
- In progress
- [ ] Save wave count, remaining zombies
- [ ] Set player network variable ("ZombieKilled","Experiance","HighestExperiance")

### MenuSystem
- In progress
- [x] Select the host player (Change the host if he disconnect)
- [x] List of player with a tag for host
- [x] Can choose player's model (list in config file) and model color
- [x] Display the game description
- [x] The host can start game
- [ ] The host can go in build mode (For add props in world)

### ZombieManager
- _In waiting_
- [ ] Config file for zombies types and experiance get by zombie
- [ ] Choose the number of zombies in relation to the player number
- [ ] Spawn zombie randomly on maps (Defined place)
- [ ] Creating infinite waves
- [ ] Give point to player on kill zombie

### Hud
- _In waiting_
- [ ] Draw a hud (Health, Battery)
- [ ] Draw the player's health and name on the top of his head.
- [ ] Draw wave number and number of zombie alive

### F4Menu
- _In waiting_
- [ ] Draw a F4Menu
- [ ] Can open if the game status is "WaveTransition"
- [ ] Easy creating tab in menu
#### Dashboard
- [ ] Draw a hud (Name, Model, Health, Battery, ZombieKilled and Experiance)
- [ ] The host can stop the game
#### Weapons
- [ ] Config file for element (Name, Price, Entity)
- [ ] Buy weapon (onBuyMunition)
- [ ] Buy Munititon on every weapon (Number)
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
