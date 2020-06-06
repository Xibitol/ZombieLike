ZL.GameStatus = nil
--[[
    0 = Menu
    1 = Playing
    2 = WaveTransition
    3 = Build
]]

function ZL.GoInMenu()
    ZL.GameStatus = 0
    hook.Run("Menu")

    print("Game status changed in "..ZL.GameStatus)
end
function ZL.GoInPlaying()
    ZL.GameStatus = 1
    hook.Run("Playing")

    print("Game status changed in "..ZL.GameStatus)
end
function ZL.GoInWaveTransition()
    ZL.GameStatus = 2
    hook.Run("WaveTransition")

    print("Game status changed in "..ZL.GameStatus)
end
function ZL.GoInBuild()
    ZL.GameStatus = 3
    hook.Run("Build")

    print("Game status changed in "..ZL.GameStatus)
end

function GM:Think()
    if ZL.GameStatus == 0 then
        hook.Run("MenuThink")
    elseif ZL.GameStatus == 1 then
        hook.Run("PlayingThink")
    elseif ZL.GameStatus == 2 then
        hook.Run("WaveTransitionThink")
    elseif ZL.GameStatus == 3 then
        hook.Run("BuildThink")
    end
end