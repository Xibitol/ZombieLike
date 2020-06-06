![ZombieLike logo with text](https://github.com/Xibitol/ZombieLike/blob/master/logo.png?raw=true)

# ZombieLike
It's a game mode from Garry's Mod. The objective is to kill zombies by infinite waves and with the points you earn you can change weapons, give yourself care, add ammunition...

Link to gamemode steam page : [ZombieLike]()

**Important :** You must have all "FA:S 2.0 Alpha SWEPs" addons and "Map for ZombieLike" addon. A collection to make your life easier : [ZombieLike Collection](https://steamcommunity.com/sharedfiles/filedetails/?id=2119249878)

## Modules
### Init files
- In progress
- [ ] Include all modules
- [x] Check if all "FA:S 2.0 Alpha SWEPs" addons and "Map for ZombieLike" addon is installed (on serveur or on client make game), otherwise it not start all script
- [x] Send a message when the player connects and spawn
- [x] Select the host player (Change the host if them disconnect)
- [x] Get number of player
- [x] Set player network variable ("ZombieKilled","Experiance","HighestExperiance")

### GameStatus (_MainModule_)
- In progress
- [ ] Change the status and send call hook ("Menu","Playing","WaveTransition","Build")
- [ ] Call think hook ("MenuThink","PlayingThink","WaveTransitionThink","BuildThink")

### MenuSystem
- _In waiting_
- [ ] List of player with a tag for host
- [ ] Display the game description
- [ ] Display the highest score
- [ ] Can choose player model and name
- [ ] The host can start game
- [ ] The host can go in build mode (For add props in world)

### FinishSystem
- _In waiting_
- [ ] Show this if all players death or host stop game
- [ ] Display the best player stats (three maximum), for the player who has the most ammo, who has killed the most zombies and who has sympathized with the enemy (who has killed the least zombies).
- [ ] Go, with a wait, in the menu
- [ ] If this is a new highest score save it

### ZombieManager
- _In waiting_
- [ ] Config file for zombies types and experiance get by zombie
- [ ] Choose the number of zombies in relation to the player number
- [ ] Spawn zombie randomly on maps (Defined place)
- [ ] Creating infinite waves
- [ ] Give point to player on kill zombie

### HudDraw
- _In waiting_
- [ ] Draw a hud (Name, Model, Health, Battery, ZombieKilled and Experiance)
- [ ] Draw the player's health and name on the top of his head.
- [ ] Draw wave number and number of zombie alive

### F4Menu
- _In waiting_
- [ ] Draw a F4Menu
- [ ] Can open if the game status is "WaveTransition"
- [ ] Config file for diplay, name and price of weapons, munitions, armor and medic kit
- [ ] Buy weapons, munitions and armor
- [ ] Buy a medic kit for 1 usagess
- [ ] The host can stop the game (By keeping the stats)

### ScoreBoardDraw
- _In waiting_
- [ ] Draw a Scoreboard
- [ ] Look players stats (Health, Battery, ZombieKilled, Experiance and HighestExperiance)
- [ ] For host : kick player, remove all weapons except the starting, clear experiance

## Developpers
> Xibitol
