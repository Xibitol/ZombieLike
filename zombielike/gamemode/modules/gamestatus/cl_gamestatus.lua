ZL.GameStatus = nil
--[[
    0 = Menu
    1 = Playing
    2 = WaveTransition
    3 = Build
]]

function ZL.GoInMenu()
    ZL.GameStatus = 0

    ZL.UpdateGSServer(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus.." -- Client has changed mode")
end
function ZL.GoInPlay()
    ZL.GameStatus = 1

    ZL.UpdateGSServer(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus.." -- Client has changed mode")
end
function ZL.GoInWaveTransition()
    ZL.GameStatus = 2

    ZL.UpdateGSServer(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus.." -- Client has changed mode")
end
function ZL.GoInBuild()
    ZL.GameStatus = 3
    
    ZL.UpdateGSServer(ZL.GameStatus)

    print("Game status changed in "..ZL.GameStatus.." -- Client has changed mode")
end

function ZL.UpdateGSServer(status)
    net.Start("UpdateGSServer")
    net.WriteInt(status, 3)
    net.SendToServer()
end
net.Receive("UpdateGSClient", function()
    ZL.GameStatus = net.ReadInt(3)
    print("Game status changed in "..ZL.GameStatus.." -- Server has changed game status in this client")

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