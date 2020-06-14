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