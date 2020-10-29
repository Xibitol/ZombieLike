include( "shared.lua" )

----- Include Module -----
local moduleFolder = GM.FolderName.."/gamemode/modules/"
local files, folders = file.Find(moduleFolder.."*", "LUA")

for k,v in ipairs(folders) do
    for kF,vF in ipairs(file.Find(moduleFolder..v.."/sh_*.lua", "LUA")) do
        include(moduleFolder..v.."/"..vF)
    end

    for kF,vF in ipairs(file.Find(moduleFolder..v.."/cl_*.lua", "LUA")) do
        include(moduleFolder..v.."/"..vF)
    end
end

include(moduleFolder.."zldraw/zl_draw.lua")
--------------------------
ZLDraw.LoadFont()

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