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
    model:SetModel("models/player/Group01/male_07.mdl")
    --[[model.Paint = function(s, w, h)
        ZLDraw.OutlineBox(0, 0, w, h, "white", 4)
    end]]
    model:SetCamPos(Vector(75, 0, 50))
    function model:LayoutEntity(entity)end
    function model.Entity:GetPlayerColor() return ZLDraw.SetColor("white") end
    local name = vgui.Create( "DTextEntry", main) -- create the form as a child of frame
    name:SetPos(75, 50)
    name:SetSize(75, 85)
    name:SetValue(LocalPlayer():Nick())
    name.OnEnter = function( self )
	    
    end

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