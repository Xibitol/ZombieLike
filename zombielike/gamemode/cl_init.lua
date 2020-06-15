include( "shared.lua" )

----- Include Module -----
include("modules/gamestatus/cl_gamestatus.lua") -- Main module

include("modules/zldraw/zl_draw.lua") -- Main draw module
ZLDraw.LoadFont()

include("modules/menusystem/cl_menusystem.lua")
--------------------------
function GM:InitPostEntity()
    ZL.GoInMenu()
end

local meta = FindMetaTable("Player")

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
    self:SetNWInt("ZombieKilled", self:GetNWInt("ZombieKilled") + number)
end
function meta:AddExperiance(number)
    self:SetNWInt("Experiance", self:GetNWInt("Experiance") + number)
end
function meta:SetHighestExperiance(number)
    self:SetNWInt("HighestExperiance", number)
end