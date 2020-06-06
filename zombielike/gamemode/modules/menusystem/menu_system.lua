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

        ZLDraw.Text("Zombie", "ZL200", w / 2 - ZLDraw.GetTextSize("Zomb") - 11, 40, Color(57, 164, 74, 255))
        ZLDraw.Text("Like", "ZL200", w / 2 + ZLDraw.GetTextSize("ie") - 11, 40, Color(237, 30, 121, 255))
    end

    local startBtn = vgui.Create("DButton", menu)
    startBtn:SetText("Start Game")
    startBtn:SetPos(ScrW() / 2 - 600, ScrH() - 400)
    startBtn:SetSize(400, 100)
    --[[startBtn.Paint = function(s, w, h)

    end]]
    startBtn.DoClick = function()
        ZL.GoInPlaying()
        menu:Remove()
    end
end)