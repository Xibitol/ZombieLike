include( "shared.lua" )

----- Include Module -----
include("modules/gamestatus/cl_gamestatus.lua") -- Main module

include("modules/zldraw/zl_draw.lua") -- Main draw module
ZLDraw.LoadFont()

include("modules/menusystem/cl_modelPanel.lua")
include("modules/menusystem/cl_menusystem.lua")
--------------------------
function GM:InitPostEntity()
    net.Start("InitPostPlayer")
    net.WriteEntity(LocalPlayer())
    net.SendToServer()
end

hook.Add("OnPlayerChat", "HelloCommand", function(ply, strText, bTeam, bDead) 
        if !ply:IsPlayer() then return end

        strText = string.lower(strText)

        if strText == "/pos" then
            chat.AddText(Color(39, 76, 216), "---- Position ----")
            chat.AddText(Color(187, 16, 210), "XYZ :"..tostring(ply:GetPos()))
            chat.AddText(Color(39, 76, 216), "------------------")
            return true
        end
    end)