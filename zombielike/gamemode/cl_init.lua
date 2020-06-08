include( "shared.lua" )

----- Include Module -----
include("modules/gamestatus/game_status.lua") -- Main module

include("modules/zldraw/zl_draw.lua") -- Main draw module
ZLDraw.LoadFont()

include("modules/menusystem/menu_system.lua")
--------------------------
ZL.GoInMenu()