function ReloadPlayerList(pl)
    local pl = pl || playerList
    if not IsValid(pl) then return end
    pl:Clear()

    local top = pl:Add("DPanel")
    top:SetHeight(9)
    top:Dock(TOP)
    top.Paint = function(s, w, h)
    end

    for k,v in ipairs(player.GetAll()) do
        local plyBox = pl:Add("DPanel")
        plyBox:SetHeight(50)
        plyBox:Dock(TOP)
	    plyBox:DockMargin(9, 0, 9, 5)
        plyBox:DockPadding(3, 3, 3, 3)
        plyBox.Paint = function(s, w, h)
            ZLDraw.OutlineBox(0, 0, w, h, "pink", 1)
        end

        local plyAvatar = vgui.Create("AvatarImage", plyBox)
        plyAvatar:Dock(LEFT)
        plyAvatar:SetSize(plyBox:GetTall()-6, plyBox:GetTall()-6)
        plyAvatar:SetPlayer(v, plyBox:GetTall()-6)

        local plyName = vgui.Create("DLabel", plyBox)
        plyName:Dock(LEFT)
        plyName:SetSize(200, plyBox:GetTall()-6)
        plyName:DockMargin(5, 0, 0, 0)
        plyName:SetText(v:GetName())
        plyName:SetFont("ZL28")
        plyName:SetTextColor(ZLDraw.SetColor("white"))

        if v == playerHost then
            local plyHostTag = vgui.Create("DPanel", plyBox)
            plyHostTag:Dock(RIGHT)
            plyHostTag:DockMargin(4.5, 4.5, 4.5, 4.5)
            plyHostTag:SetSize(plyBox:GetTall()-6-9, plyBox:GetTall()-6-9)
            plyHostTag.Paint = function(s, h, w)
                ZLDraw.Image(0, 0, w, h, Material("stars.png", "smooth mips"), Color(255, 220, 0))
            end
        end
    end

    local bottom = pl:Add("DPanel")
    bottom:SetHeight(4)
    bottom:Dock(TOP)
    bottom.Paint = function(s, w, h)
    end
end

hook.Add("Menu", "MenuSystem_HookMenu_CL", function()
    playerHost = player.GetAll()[1]
    print("The host is "..playerHost:GetName())

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
        ZLDraw.Box(0, 0, w, h, "gray")

        --[[ZLDraw.Texts(w / 2, 40, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, {
            {text = "Zombie", color = "green", font = "ZL200"},
            {text = "Like", color = "pink", font = "ZL200"}
        })]]
        data = ScrH()*0.25/26
        imageW, imageH = data*24*2.25, data*24
        ZLDraw.Image(w/2 - imageW/2, data, imageW, imageH, Material("logo2x.png", "smooth mips"), "white")
    end


    -- Player list
    playerList = vgui.Create("DScrollPanel", main)
    playerList:SetPos(ScrW()*0.05, ScrH()*0.25)
    playerList:SetSize(450, 500)
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
    ReloadPlayerList(playerList)

    -- Player info
    local model = vgui.Create("DModelAnimated", main)
    model:SetPos(ScrW()/2 - 450/2, ScrH()*0.25)
    model:SetSize(450, 400)

    local name = vgui.Create("DLabel", main)
    name:SetPos(ScrW()/2 - model:GetWide()/2, ScrH()*0.25 + model:GetTall() + 25)
    name:SetSize(model:GetWide()/2-50, 50)
    name:SetText(LocalPlayer():GetName())
    name:SetFont("ZL40")
    name:SetTextColor(ZLDraw.SetColor("white"))

    local modelColor = vgui.Create( "DColorPalette", main)
    modelColor:SetPos(ScrW()/2, ScrH()*0.25 + model:GetTall() + 25)
    modelColor:SetSize(model:GetWide()/2, 50)
    modelColor:SetColor(Color(255, 255, 255))
    modelColor:SetButtonSize(15)
    modelColor.OnValueChanged = function(s, color)
        net.Start("ChangePlayerColor")
        net.WriteEntity(LocalPlayer())
        net.WriteVector(Color(color.r, color.g, color.b):ToVector())
        net.SendToServer()

        model:SetModelColor(color)
    end

    -- Description and Highest Score
    local game = vgui.Create("DPanel", main)
    game:SetPos(ScrW() - ScrW()*0.05 - 450, ScrH()*0.25)
    game:SetSize(450, 500)
    game.Paint = function(s, w, h)
        ZLDraw.OutlineBox(0, 0, w, h, "green", 4)
    end

    local desc = vgui.Create("DLabel", game)
    desc:SetPos(25, 25)
    desc:SetSize(400, 150)
    desc:SetText(ZL.Description)
    desc:SetFont("ZL28")
    desc:SetTextColor(ZLDraw.SetColor("white"))
    desc:SetWrap(true)


    -- Button
    local startBtn = vgui.Create("DButton", main)
    startBtn:SetPos(ScrW()/2 - ScrW()*0.35, ScrH() - ScrH()*0.15)
    startBtn:SetSize(400, 100)
    startBtn:SetText("Start Game")
    startBtn:SetTextColor(ZLDraw.SetColor("white"))
    startBtn:SetFont("ZL50")
    if LocalPlayer() == playerHost then
        startBtn.Paint = function(s, w, h)
            ZLDraw.RoundedBox(20, 0, 0, w, h, "green")
        end
        startBtn.DoClick = function()
            ZL.GoInPlay()
        end
    else
        startBtn.Paint = function(s, w, h)
            ZLDraw.RoundedBox(20, 0, 0, w, h, Color(169, 169, 169, 255))
        end
        startBtn:SetCursor("no")
    end

    local buildBtn = vgui.Create("DButton", main)
    buildBtn:SetPos(ScrW()/2 + ScrW()*0.1, ScrH() - ScrH()*0.15)
    buildBtn:SetSize(400, 100)
    buildBtn:SetText("Go in build mode")
    buildBtn:SetTextColor(ZLDraw.SetColor("white"))
    buildBtn:SetFont("ZL50")
    if LocalPlayer() == playerHost then
        buildBtn.Paint = function(s, w, h)
            ZLDraw.RoundedBox(20, 0, 0, w, h, "pink")
        end
    else
        buildBtn.Paint = function(s, w, h)
            ZLDraw.RoundedBox(20, 0, 0, w, h, Color(169, 169, 169, 255))
        end
        buildBtn:SetCursor("no")
    end
end)
net.Receive("PlayerSpawn", function()
    ReloadPlayerList()
end)
net.Receive("PlayerDisconnect", function()
    if net.ReadEntity() == playerHost then
        playerHost = player.GetAll()[1]
        print("New host is "..player.GetAll()[1]:GetName())
    end

    ReloadPlayerList()
end)

hook.Add("Play", "MenuSystem_HookPlay_CL", function()
    main:Remove()
end)