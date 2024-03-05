ZL.GameStatus = nil
--[[
    0 = Menu
    1 = Playing
    2 = WaveTransition
    3 = Build
]]

util.AddNetworkString("UpdateGSServer")
util.AddNetworkString("UpdateGSClient")

function ZL.GoInMenu()
    ZL.GameStatus = 0
    hook.Run("Menu")

    ZL.UpdateGSAllClient(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus)
end
function ZL.GoInPlay()
    ZL.GameStatus = 1
    hook.Run("Play")

    ZL.UpdateGSAllClient(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus)
end
function ZL.GoInWaveTransition()
    ZL.GameStatus = 2
    hook.Run("WaveTransition")

    ZL.UpdateGSAllClient(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus)
end
function ZL.GoInBuild()
    ZL.GameStatus = 3
    hook.Run("Build")

    ZL.UpdateGSAllClient(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus)
end

function ZL.UpdateGSAllClient(status)
    net.Start("UpdateGSClient")
    net.WriteInt(status, 3)
    net.Broadcast()
end
function ZL.UpdateGSOneClient(status, ply)
    net.Start("UpdateGSClient")
    net.WriteInt(status, 3)
    net.Send(ply)
end
net.Receive("UpdateGSServer", function()
    ZL.GameStatus = net.ReadInt(3)
    ZL.UpdateGSAllClient(ZL.GameStatus)

    if ZL.GameStatus == 0 then
        hook.Run("Menu")
    elseif ZL.GameStatus == 1 then
        hook.Run("Play")
    elseif ZL.GameStatus == 2 then
        hook.Run("WaveTransition")
    elseif ZL.GameStatus == 3 then
        hook.Run("Build")
    end
end)

function GM:Think()
    if ZL.GameStatus == 0 then
        hook.Run("MenuThink")
    elseif ZL.GameStatus == 1 then
        hook.Run("PlayThink")
    elseif ZL.GameStatus == 2 then
        hook.Run("WaveTransitionThink")
    elseif ZL.GameStatus == 3 then
        hook.Run("BuildThink")
    end
end

hook.Add("Play", "GameStatus_HookPlay_SV", function()
    for kP,vP in ipairs(player.GetAll()) do
        if ZL.wave >= 1 then continue end
        vP:SetZombieKilled(0)
        vP:SetExperience(0)
        vP:SetHighestExperience(0)

        for kW,vW in ipairs(ZL.WEAPON) do
            if vW.onStart then
                vP:Give(vW.entity, true)
                if vW.charger then
                    vP:GiveAmmo(vW.onStartCharger * vW.charger.ammo, vW.charger.name)
                end
            end
        end
    end

    for k,v in ipairs(ents.GetAll()) do
        v:RemoveAllDecals()
    end

    RunConsoleCommand("g_ragdoll_maxcount", 0)
    timer.Simple(1, function() RunConsoleCommand("g_ragdoll_maxcount", 32) end)
end)
hook.Add("WaveTransition", "GameStatus_HookPlay_SV", function()
    timer.Simple(ZL.WAVE_TRANSITION_TIME, function()
        if ZL.GameStatus == 2 then
            ZL.GoInPlay()
        end
    end)
end)