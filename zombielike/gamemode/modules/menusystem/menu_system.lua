hook.Add("Menu", "GameMenuStatusHook", function()
    local menu = vgui.Create("DFrame")
    menu:SetPos(0, 0)
    menu:SetSize(ScrW(), ScrH())
    menu:SetTitle("")
    menu:SetVisible(true)
    menu:SetDraggable(false)
    menu:ShowCloseButton(false)
    menu:MakePopup()
    menu.Paint = function(s, w, h)
        ZLDraw.Box(0, 0, w, h, Color(51, 51, 51, 255))

        --[[ZLDraw.Texts(w / 2, 40, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, {
            {text = "Zombie", color = "green", font = "ZL200"},
            {text = "Like", color = "pink", font = "ZL200"}
        })]]
        ZLDraw.Image(w / 2 - 288 / 2, 40, 576, 256, "logo.png")
    end

    local startBtn = vgui.Create("DButton", menu)
    startBtn:SetText("Start Game")
    startBtn:SetPos(ScrW() / 2 - 600, ScrH() - 250)
    startBtn:SetSize(400, 100)
    --[[startBtn.Paint = function(s, w, h)

    end]]
    startBtn.DoClick = function()
        ZL.GoInPlaying()
        menu:Remove()
    end
end)