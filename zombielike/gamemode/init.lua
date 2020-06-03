AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

function GM:PlayerConnect(name, ip)
	PrintMessage(HUD_PRINTTALK, name.." connected to the game.")
    print(name.."/"..ip.." connected")
end

function GM:PlayerSpawn( ply )
    PrintMessage(HUD_PRINTTALK, ply:Nick().." has spawned.")
end