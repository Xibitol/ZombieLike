----- Verify Addons -----
include("necessary_addons.lua")
for k, v in ipairs(engine.GetAddons()) do
    for k2, v2 in pairs(GM.NecessaryAddons) do
        if v.wsid == k2 and v.mounted == true then
            GM.NecessaryAddons[k2].installed = true
        end
    end
end
for k, v in pairs(GM.NecessaryAddons) do
    if v.installed == false then
        error("You must have or this must be mounted :"..v.name, 1)
    end
end
----- Verify Map -----
if game.GetMap() != "zl_construct" then
    error("You must play in map : Map for ZombieLike", 1)
end
--[[----------------------------------------------

    /\ DO NOT CHANGE ANYTHING /\

--]]----------------------------------------------
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua") 
include("shared.lua")

----- Include Module -----
local moduleFolder = GM.FolderName.."/gamemode/modules/"
local files, folders = file.Find(moduleFolder.."*", "LUA")

for k,v in ipairs(folders) do
    for kF,vF in ipairs(file.Find(moduleFolder..v.."/sh_*.lua", "LUA")) do
        AddCSLuaFile(moduleFolder..v.."/"..vF)
        include(moduleFolder..v.."/"..vF)
    end

    for kF,vF in ipairs(file.Find(moduleFolder..v.."/sv_*.lua", "LUA")) do
        include(moduleFolder..v.."/"..vF)
    end

    for kF,vF in ipairs(file.Find(moduleFolder..v.."/cl_*.lua", "LUA")) do
        AddCSLuaFile(moduleFolder..v.."/"..vF)
    end
end

AddCSLuaFile(GM.FolderName.."/gamemode/modules/".."zldraw/zl_draw.lua")
--------------------------
util.AddNetworkString("PlayerSpawn")
util.AddNetworkString("InitPostPlayer")
util.AddNetworkString("PlayerDisconnect")

ZL.GoInMenu()

function GM:PlayerConnect(name, ip)
	PrintMessage(HUD_PRINTTALK, name.." connected to the game.")
    print(name.."/"..ip.." connected")
end
function GM:PlayerSpawn(ply)
    PrintMessage(HUD_PRINTTALK, ply:GetName().." has spawned.")

    ply:SetModel(ZL.MODEL.models[ZL.MODEL.currentIndex])

    net.Start("PlayerSpawn")
    net.WriteEntity(ply)
    net.Broadcast()
end
net.Receive("InitPostPlayer", function()
    local ply = net.ReadEntity()
    ZL.UpdateGSOneClient(ZL.GameStatus, ply)
    ZL.UpdateZMOneClient(ZL.wave, ZL.remainingZombie, ply)
end)
function GM:PlayerDisconnected(ply)
    PrintMessage(HUD_PRINTTALK, ply:GetName().." left the game.")

    net.Start("PlayerDisconnect")
    net.WriteEntity(ply)
    net.Broadcast()
end