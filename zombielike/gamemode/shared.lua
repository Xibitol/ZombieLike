module("ZL", package.seeall)

----- Include Config File -----
local moduleFolder = GM.FolderName.."/gamemode/config/"
local files, folders = file.Find(moduleFolder.."config_*.lua", "LUA")

for k,v in ipairs(files) do
    if SERVER then
        AddCSLuaFile(moduleFolder..v)
    end
    include(moduleFolder..v)
end
-------------------------------

GM.Name = "ZombieLike"
GM.Author = "Xibitol"
GM.Email = "xibitol-contact@pimous.fr"
GM.Website = "N/A"
ZL.Description = "It's a game mode from Garry's Mod. The objective is to kill zombies by infinite waves and with the points you earn you can buy weapons, give yourself care, add armor..."

function GM:Initialize()
    self.BaseClass.Initialize(self)
end