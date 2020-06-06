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
AddCSLuaFile("modules/gamestatus/game_status.lua") -- Main Module
include("modules/gamestatus/game_status.lua")

AddCSLuaFile("modules/zldraw/zl_draw.lua") -- Main draw module

AddCSLuaFile("modules/menusystem/menu_system.lua")
--------------------------
ZL.PlayerHost = nil
ZL.NumberPlayer = 0

function GM:PlayerConnect(name, ip)
	PrintMessage(HUD_PRINTTALK, name.." connected to the game.")
    print(name.."/"..ip.." connected")
end
function GM:PlayerSpawn(ply)
    PrintMessage(HUD_PRINTTALK, ply:Nick().." has spawned.")
    ZL.NumberPlayer = ZL.NumberPlayer + 1

    if ply == player.GetAll()[1] then
        ZL.PlayerHost = ply
    end

    local meta = FindMetaTable("Player")
    ply:SetNWInt("ZombieKilled", 0)
    ply:SetNWInt("Experiance", 0)
    ply:SetNWInt("HighestExperiance", 0)

    function meta:GetZombieKilled()
        return self:GetNWInt("ZombieKilled")
    end
    function meta:GetExperiance()
        return self:GetNWInt("Experiance")
    end
    function meta:GetHighestExperiance()
        return self:GetNWInt("HighestExperiance")
    end

    function meta:AddZombieKilled(number)
        return self:SetNWInt("ZombieKilled", self:GetNWInt("ZombieKilled") + number)
    end
    function meta:AddExperiance(number)
        return self:SetNWInt("Experiance", self:GetNWInt("Experiance") + number)
    end
    function meta:SetHighestExperiance(number)
        return self:SetNWInt("HighestExperiance", number)
    end
end
function GM:PlayerDisconnected(ply)
    PrintMessage(HUD_PRINTTALK, name.." left the game.")
    ZL.NumberPlayer = ZL.NumberPlayer - 1

    if ply == ZL.PlayerHost and player.GetAll()[1] != nil then
        ZL.PlayerHost = player.GetAll()[1]
    elseif ply == ZL.PlayerHost then
        ZL.PlayerHost = nil
    end
end