----- Verify Addons -----
GM.NecessaryAddons = {
    ["fas20"] = false,
    ["FA:S 2.0 Alpha SWEPs - U. Rifles"] = false,
    ["FA:S 2.0 Alpha SWEPs - SMGs"] = false,
    ["FA:S 2.0 Alpha SWEPs - Shotguns"] = false,
    ["FA:S 2.0 Alpha SWEPS - Pistols"] = false,
    ["FA:S 2.0 Alpha SWEPs - Rifles"] = false,
    ["fas20misc"] = false
}
for k, v in ipairs(engine.GetAddons()) do
    for k2, v2 in pairs(GM.NecessaryAddons) do
        if v.title == k2 and v.mounted == true then
            GM.NecessaryAddons[k2] = true
        end
    end
end
for k, v in pairs(GM.NecessaryAddons) do
    if v == false then
        error("You must have or this must be mounted :"..k, 1)
    end
end
--------------------------------------------------

--------------------------------------------------
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" ) 
include( "shared.lua" )

----- Include Module -----



----- Function and variable -----
GM.PlayerHost = nil
GM.NumberPlayer = 0

function GM:PlayerConnect(name, ip)
	PrintMessage(HUD_PRINTTALK, name.." connected to the game.")
    print(name.."/"..ip.." connected")
end

function GM:PlayerSpawn(ply)
    PrintMessage(HUD_PRINTTALK, ply:Nick().." has spawned.")
    GAMEMODE.NumberPlayer = GAMEMODE.NumberPlayer + 1

    if ply == player.GetAll()[1] then
        GAMEMODE.PlayerHost = ply
    end
end

function GM:PlayerDisconnected(ply)
    PrintMessage(HUD_PRINTTALK, name.." left the game.")
    GAMEMODE.NumberPlayer = GAMEMODE.NumberPlayer - 1
end