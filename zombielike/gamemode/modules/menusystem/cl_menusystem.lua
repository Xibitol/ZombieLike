local main = nil
local playerList = nil
local playerHost = nil

print(ScrW(), ScrH())

function ReloadPlayerList()
    playerList:Clear()

    local top = playerList:Add("DPanel")
    top:SetHeight(9)
    top:Dock(TOP)
    top.Paint = function(s, w, h)
    end

    for k,v in ipairs(player.GetAll()) do
        local plyBox = playerList:Add("DPanel")
        plyBox:SetHeight(50)
        plyBox:Dock(TOP)
	    plyBox:DockMargin(9, 0, 5, 5)
        plyBox.Paint = function(s, w, h)
            ZLDraw.OutlineBox(0, 0, w, h, "pink", 1)
        end

        local plyAvatar = vgui.Create("AvatarImage", plyBox)
        plyAvatar:SetPos(3, 3)
        plyAvatar:SetSize(44, 44)
        plyAvatar:SetPlayer(v, 44)

        local plyName = vgui.Create("DLabel", plyBox)
        plyName:SetPos(57, 3)
        plyName:SetSize(200, 44)
        plyName:SetText(v:GetName())
        plyName:SetFont("ZL28")
        plyName:SetTextColor(ZLDraw.SetColor("white"))

        if v == playerHost then
            local plyHostTag = vgui.Create("DPanel", plyBox)
            plyHostTag:SetPos(495, 7.5)
            plyHostTag:SetSize(35, 35)
            plyHostTag.Paint = function(s, h, w)
                ZLDraw.Image(0, 0, w, h, Material("stars.png", "smooth mips"), Color(255, 220, 0))
            end
        end
    end

    local bottom = playerList:Add("DPanel")
    bottom:SetHeight(4)
    bottom:Dock(TOP)
    bottom.Paint = function(s, w, h)
    end
end

hook.Add("Menu", "GameMenuStatusHook", function()
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
        ZLDraw.Box(0, 0, w, h, Color(51, 51, 51))

        --[[ZLDraw.Texts(w / 2, 40, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, {
            {text = "Zombie", color = "green", font = "ZL200"},
            {text = "Like", color = "pink", font = "ZL200"}
        })]]
        ZLDraw.Image(w/2 - 576/2, 20, 576, 256, Material("logo2x.png", "alphatest"), "white")
    end


    -- Player list
    local playerListBox = vgui.Create("DPanel", main)
    playerListBox:SetPos(ScrW()*0.05, ScrH()*0.25)
    playerListBox:SetSize(550, 500)
    playerListBox.Paint = function(s, w, h)
        ZLDraw.OutlineBox(0, 0, w, h, "pink", 4)
    end
    playerList = vgui.Create("DScrollPanel", playerListBox)
    playerList:Dock(FILL)
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
    model:SetPos(ScrW()/2 - 450/2, ScrH()*0.25)
    model:SetSize(450, 400)
    model:SetModel(LocalPlayer():GetModel())
    model:SetCamPos(Vector(75, 0, 50))
    function model:LayoutEntity(entity)end
    function model.Entity:GetPlayerColor() return ZLDraw.SetColor("white") end

    local name = vgui.Create("DLabel", main)
    name:SetPos(ScrW()/2 - 250, ScrH()*0.7)
    name:SetSize(200, 40)
    name:SetText(LocalPlayer():GetName())
    name:SetFont("ZL40")
    name:SetTextColor(ZLDraw.SetColor("white"))

    local modelColor = vgui.Create( "DColorPalette", main)
    modelColor:SetPos(ScrW()/2, ScrH()*0.7)
    modelColor:SetSize(250, 50)
    modelColor:SetColor(Color(255, 255, 255))
    modelColor:SetButtonSize(15)
    modelColor.OnValueChanged = function(s, color)
        net.Start("ChangePlayerColor")
        net.WriteEntity(LocalPlayer())
        net.WriteVector(Color(color.r, color.g, color.b):ToVector())
        net.SendToServer()

        function model.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end
    end

    -- Description and Highest Score
    local game = vgui.Create("DPanel", main)
    game:SetPos(ScrW() - ScrW()*0.05 - 550, ScrH()*0.25)
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
    startBtn:SetPos(ScrW()/2 - ScrW()*0.35, ScrH() - ScrH()*0.15)
    startBtn:SetSize(400, 100)
    startBtn:SetText("Start Game")
    startBtn:SetTextColor(ZLDraw.SetColor("white"))
    startBtn:SetFont("ZL50")
    startBtn.Paint = function(s, w, h)
        if LocalPlayer() == playerHost then
            ZLDraw.RoundedBox(20, 0, 0, w, h, "green")
        else
            ZLDraw.RoundedBox(20, 0, 0, w, h, Color(169, 169, 169, 255))
        end
    end
    if LocalPlayer() == playerHost then
        startBtn.DoClick = function()
            ZL.GoInPlay()
            main:Remove()
        end
    end

    local BuildBtn = vgui.Create("DButton", main)
    BuildBtn:SetPos(ScrW()/2 + ScrW()*0.1, ScrH() - ScrH()*0.15)
    BuildBtn:SetSize(400, 100)
    BuildBtn:SetText("Go in build mode")
    BuildBtn:SetTextColor(ZLDraw.SetColor("white"))
    BuildBtn:SetFont("ZL50")
    BuildBtn.Paint = function(s, w, h)
        if LocalPlayer() == playerHost then
            ZLDraw.RoundedBox(20, 0, 0, w, h, "pink")
        else
            ZLDraw.RoundedBox(20, 0, 0, w, h, Color(169, 169, 169, 255))
        end
    end
end)

net.Receive("PlayerSpawnMS", function()
    ReloadPlayerList()
end)

net.Receive("PlayerDisconnectMS", function()
    local ply = net.ReadEntity()

    if ply == playerHost then
        playerHost = player.GetAll()[1]
        print("New host is "..player.GetAll()[1]:GetName())
    end

    ReloadPlayerList()
end)