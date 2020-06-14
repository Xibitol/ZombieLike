local main = nil
local playerList = nil

function ReloadPlayerList()
    playerList:Clear()

    for i=0, 10 do--k,v in ipairs(player.GetAll()) do
        local plyBox = playerList:Add("DPanel")
        plyBox:SetHeight(50)
        plyBox:Dock(TOP)
	    plyBox:DockMargin(9, 5, 5, 0)
        plyBox.Paint = function(s, w, h)
            ZLDraw.OutlineBox(0, 0, w, h, "pink", 1)
        end

        local plyAvatar = vgui.Create("AvatarImage", plyBox)
        plyAvatar:SetPos(3, 3)
        plyAvatar:SetSize(44, 44)
        plyAvatar:SetPlayer(LocalPlayer(), 44)
    end
end

hook.Add("Menu", "GameMenuStatusHook", function()
    -- Main
    main = vgui.Create("DFrame")
    main:SetPos(0, 0)
    main:SetSize(ScrW(), ScrH())
    main:SetTitle("")
    main:SetVisible(true)
    main:SetDraggable(false)
    main:ShowCloseButton(true)
    main:MakePopup()
    main.Paint = function(s, w, h)
        ZLDraw.Box(0, 0, w, h, Color(51, 51, 51))

        --[[ZLDraw.Texts(w / 2, 40, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, {
            {text = "Zombie", color = "green", font = "ZL200"},
            {text = "Like", color = "pink", font = "ZL200"}
        })]]
        ZLDraw.Image(w/2 - 576/2, 20, 576, 256, Material("logo2x.png", "alphatest smooth"), "white")
    end


    -- Player list
    playerList = vgui.Create("DScrollPanel", main)
    playerList:SetPos(100, 300)
    playerList:SetSize(550, 500)
    playerList:SetZPos(10)
    playerList.Paint = function(s, w, h)
        ZLDraw.OutlineBox(0, 0, w, h, "pink", 4)
    end
    local scrollBar = playerList:GetVBar()
    scrollBar:SetPos(playerList:GetWide() - 4, 0)
    scrollBar:SetSize(4, 500)
    function scrollBar:Paint(w, h)
        ZLDraw.Box(0, 0, w, h, "gray")
    end
    function scrollBar.btnUp:Paint(w, h)
        ZLDraw.Box(0, 0, w, h, "pink")
    end
    function scrollBar.btnDown:Paint(w, h)
        ZLDraw.Box(0, 0, w, h, "pink")
    end
    function scrollBar.btnGrip:Paint(w, h)
        ZLDraw.Box(0, 0, w, h, "pink")
    end
    ReloadPlayerList()

    -- Player info
    local model = vgui.Create("DModelPanel", main)
    model:SetPos(ScrW()/2 - 450/2, 300)
    model:SetSize(450, 400)
    model:SetModel(LocalPlayer():GetModel())
    model:SetCamPos(Vector(75, 0, 50))
    function model:LayoutEntity(entity)end
    function model.Entity:GetPlayerColor() return ZLDraw.SetColor("white") end

    local name = vgui.Create("DLabel", main)
    name:SetPos(ScrW()/2 - 250, 750)
    name:SetSize(200, 40)
    name:SetText(LocalPlayer():GetName())
    name:SetFont("ZL40")
    name:SetTextColor(ZLDraw.SetColor("white"))

    local modelColor = vgui.Create( "DColorPalette", main)
    modelColor:SetPos(ScrW()/2, 750)
    modelColor:SetSize(250, 50)
    modelColor:SetColor(Color(255, 255, 255))
    modelColor:SetButtonSize(15)
    modelColor.OnValueChanged = function(s, color)
        local meta = FindMetaTable("Player")
        function meta:GetPlayerColor() return Vector(color.r/255, color.g/255, color.b/255) end
        function model.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end
    end

    -- Description and Highest Score
    local game = vgui.Create("DPanel", main)
    game:SetPos(ScrW() - 650, 300)
    game:SetSize(550, 500)
    game.Paint = function(s, w, h)
        ZLDraw.OutlineBox(0, 0, w, h, "green", 4)
    end

    local desc = vgui.Create("DLabel", game)
    desc:SetPos(25, 25)
    desc:SetSize(500, 100)
    desc:SetText(ZL.Description)
    desc:SetFont("ZL28")
    desc:SetTextColor(ZLDraw.SetColor("white"))
    desc:SetWrap(true)


    -- Button
    local startBtn = vgui.Create("DButton", main)
    startBtn:SetPos(ScrW()/2 - 600, ScrH() - 150)
    startBtn:SetSize(400, 100)
    startBtn:SetText("Start Game")
    startBtn:SetTextColor(ZLDraw.SetColor("white"))
    startBtn:SetFont("ZL50")
    startBtn.Paint = function(s, w, h)
        if LocalPlayer() == player.GetAll()[1] then
            ZLDraw.RoundedBox(20, 0, 0, w, h, "green")
        else
            ZLDraw.RoundedBox(20, 0, 0, w, h, Color(169, 169, 169, 255))
        end
    end
    if LocalPlayer() == player.GetAll()[1] then
        startBtn.DoClick = function()
            ZL.GoInPlay()
            main:Remove()
        end
    end

    local BuildBtn = vgui.Create("DButton", main)
    BuildBtn:SetPos(ScrW()/2 + 200, ScrH() - 150)
    BuildBtn:SetSize(400, 100)
    BuildBtn:SetText("Go in build mode")
    BuildBtn:SetTextColor(ZLDraw.SetColor("white"))
    BuildBtn:SetFont("ZL50")
    BuildBtn.Paint = function(s, w, h)
        if LocalPlayer() == player.GetAll()[1] then
            ZLDraw.RoundedBox(20, 0, 0, w, h, "pink")
        else
            ZLDraw.RoundedBox(20, 0, 0, w, h, Color(169, 169, 169, 255))
        end
    end
end)