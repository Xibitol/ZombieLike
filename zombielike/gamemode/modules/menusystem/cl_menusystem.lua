hook.Add("Menu", "GameMenuStatusHook", function()
    -- Main
    local main = vgui.Create("DFrame")
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
        ZLDraw.Image(w/2 - 576/2, 20, 576, 256, "logo2x.png", "white")
    end


    -- Player list
    local playerList = vgui.Create("DScrollPanel", main)
    playerList:SetPos(100, 300)
    playerList:SetSize(550, 500)
    playerList.Paint = function(s, w, h)
        ZLDraw.OutlineBox(0, 0, w, h, "pink", 4)
    end


    -- Player info
    local model = vgui.Create("DModelPanel", main)
    model:SetPos(ScrW()/2 - 450/2, 300)
    model:SetSize(450, 400)
    model:SetModel(LocalPlayer():GetModel())
    model:SetCamPos(Vector(75, 0, 50))
    function model:LayoutEntity(entity)end
    function model.Entity:GetPlayerColor() return ZLDraw.SetColor("white") end

    local name = vgui.Create( "DLabel", main) -- create the form as a child of frame
    name:SetPos(ScrW()/2 - 100, 750)
    name:SetSize(200, 40)
    name:SetText(LocalPlayer():GetName())
    name:SetFont("ZL28")
    name:SetTextColor(ZLDraw.SetColor("white"))

    local setName = vgui.Create( "DTextEntry", main) -- create the form as a child of frame
    setName:SetPos(ScrW()/2 - 275, 750)
    setName:SetSize(120, 40)
    setName:SetFont("ZL10")
    setName:SetValue(LocalPlayer():Nick())
    setName.OnEnter = function(self)
        net.Start("SetName")
        net.WriteEntity(LocalPlayer())
        net.WriteString(self:GetValue())
        net.SendToServer()

        name:SetText(LocalPlayer():GetName())
    end

    local modelColor = vgui.Create( "DColorMixer", main)
    modelColor:SetPos(ScrW()/2 + 75, 735)
    modelColor:SetSize(200, 70)
    modelColor:SetBaseColor(false)
    modelColor:SetAlphaBar(false)
    modelColor:SetWangs(false)
    modelColor:SetPalette(true)
    modelColor:SetColor(Color(255, 255, 255))



    -- Description and Highest Score
    local desc = vgui.Create("DPanel", main)
    desc:SetPos(ScrW() - 650, 300)
    desc:SetSize(550, 500)
    desc.Paint = function(s, w, h)
        ZLDraw.OutlineBox(0, 0, w, h, "green", 4)
    end


    -- Button
    local startBtn = vgui.Create("DButton", main)
    startBtn:SetPos(ScrW()/2 - 600, ScrH() - 150)
    startBtn:SetSize(400, 100)
    startBtn:SetText("Start Game")
    startBtn:SetTextColor(ZLDraw.SetColor("white"))
    startBtn:SetFont("ZL50")
    startBtn.Paint = function(s, w, h)
        ZLDraw.RoundedBox(20, 0, 0, w, h, "green")
    end
    startBtn.DoClick = function()
        ZL.GoInPlay()
        main:Remove()
    end

    local BuildBtn = vgui.Create("DButton", main)
    BuildBtn:SetPos(ScrW()/2 + 200, ScrH() - 150)
    BuildBtn:SetSize(400, 100)
    BuildBtn:SetText("Go in build mode")
    BuildBtn:SetTextColor(ZLDraw.SetColor("white"))
    BuildBtn:SetFont("ZL50")
    BuildBtn.Paint = function(s, w, h)
        ZLDraw.RoundedBox(20, 0, 0, w, h, "pink")
    end
end)