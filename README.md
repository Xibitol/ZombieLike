![alt text](https://github.com/Xibitol/ZombieLike/blob/master/logo.png?raw=true)

# ZombieLike
It's a game mode from Garry's Mod. The objective is to kill zombies by infinite waves and with the points you earn you can change weapons, give yourself care, add ammunition...

**Important :** You must have all the "FA:S 2.0 Alpha SWEPs" addons. 

## Modules
### Init files
- In progress
- [ ] Include all modules
- [ ] Check if the addon "FA:S2 weapons" is installed, otherwise it stops the game
- [x] Send a message when the player connects and spawn
- [ ] Select the host player (Change the host if them disconnect)
- [ ] Get number of player

### GameStatus (_MainModule_)
- _In waiting_
- [ ] Change the status and send call hook ("Menu","Playing","WavesTransition","Build")
- [ ] Call think hook ("MenuThink","PlayingThink","WavesTransitionThink","BuildThink")

### MenuSystem
- _In waiting_
- [ ] List of player with a tag for host (It show player stats if game is just stopped)
- [ ] Display the game description
- [ ] Display the highest score
- [ ] The host can start game
- [ ] The host can go in build mode (For add props in world)

### FinishSystem
- _In waiting_
- [ ] Show this if all players death or host stop game
- [ ] Display highest player stats (Three maximum)
- [ ] Go, with a wait, in the menu
- [ ] If this is a new highest score save it

### ZombieManager
- _In waiting_
- [ ] Spawn zombie randomly on maps (Defined place)
- [ ] Choose the number of zombies in relation to the player number
- [ ] Choose type of zombie
- [ ] Creating infinite waves
- [ ] Give point to player on kill zombie

### HudDraw
- _In waiting_
- [ ] Draw a hud
- [ ] Draw the player's health on the top of his head.
- [ ] Draw wave number and number of zombie alive

### F4Menu
- _In waiting_
- [ ] Draw a F4Menu
- [ ] Can open if the game status is "waveTransition"
- [ ] Buy some weapons and munitions
- [ ] Buy a medic kit for 1 usages
- [ ] The host can stop the game (By keeping the stats)

### ScoreBoardDraw
- _In waiting_
- [ ] Draw a Scoreboard
- [ ] Look players stats
- [ ] For host : kick player, remove all weapons except the starting, clear points

## Developpers
> Xibitol
