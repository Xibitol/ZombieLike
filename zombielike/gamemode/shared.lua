module("ZL", package.seeall)

include("config/playerConfig.lua")
include("config/weaponsConfig.lua")
include("config/zombiesConfig.lua")
include("modules/gamedata/sh_gamedata.lua")
if SERVER then
    AddCSLuaFile("config/playerConfig.lua")
    AddCSLuaFile("config/weaponsConfig.lua")
    AddCSLuaFile("config/zombiesConfig.lua")
    AddCSLuaFile("modules/gamedata/sh_gamedata.lua")
end

GM.Name = "ZombieLike"
GM.Author = "Xibitol"
GM.Email = "xibitol-contact@pimous.fr"
GM.Website = "N/A"
ZL.Description = "It's a game mode from Garry's Mod. The objective is to kill zombies by infinite waves and with the points you earn you can buy weapons, give yourself care, add armor..."

function GM:Initialize()
    self.BaseClass.Initialize(self)
end