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
AddCSLuaFile("modules/gamestatus/cl_gamestatus.lua") -- Main Module
include("modules/gamestatus/sv_gamestatus.lua")

AddCSLuaFile("modules/zldraw/zl_draw.lua") -- Main draw module

AddCSLuaFile("modules/menusystem/cl_menusystem.lua")
--------------------------
function GM:PlayerConnect(name, ip)
	PrintMessage(HUD_PRINTTALK, name.." connected to the game.")
    print(name.."/"..ip.." connected")
end
function GM:PlayerSpawn(ply)
    PrintMessage(HUD_PRINTTALK, ply:GetName().." has spawned.")

    ply:SetModel("models/player/Group01/male_02.mdl")
end
function GM:PlayerDisconnected(ply)
    PrintMessage(HUD_PRINTTALK, ply:GetName().." left the game.")
end