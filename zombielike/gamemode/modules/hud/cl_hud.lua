Data = {
    health = 100,
    armor = 100,
    zombie = 0
}
zombieNumber = 0
zombieKilledMsg = {}
delay = CurTime()

local yPI, wPI, hPI = 15, 225, 23
local yW, wW, hW = 50, 1200, 18

hook.Add("HUDPaint", "Hud_HookHud_CL", function()
    -- Health
    ZLDraw.RoundedBox(4, yPI, ScrH()-yPI-hPI, wPI, hPI, "gray")

    Data.health = Lerp(5*FrameTime(), Data.health, LocalPlayer():Health())
    if Data.health > 3 and Data.health <= 100 then
        ZLDraw.RoundedBox(4, yPI, ScrH()-yPI-hPI, Data.health*wPI/100, hPI, Color(200, 40, 70))
    elseif Data.health > 100 then
        ZLDraw.RoundedBox(4, yPI, ScrH()-yPI-hPI, 0, hPI, Color(200, 40, 70))
    end

    -- Armor
    ZLDraw.RoundedBox(4, yPI, ScrH()-hPI*2-yPI*2, wPI, hPI, "gray")

    Data.armor = Lerp(5*FrameTime(), Data.armor, LocalPlayer():Armor())
    if Data.armor > 3 and Data.armor <= 100 then
        ZLDraw.RoundedBox(4, yPI, ScrH()-hPI*2-yPI*2, Data.armor*wPI/100, hPI, Color(0, 60, 200))
    elseif Data.armor > 100 then
        ZLDraw.RoundedBox(4, yPI, ScrH()-hPI*2-yPI*2, 100, hPI, Color(0, 60, 200))
    end

    -- Wave bar
    local textUp, barFill, barColor, textDown = "", 1200, "gray", ""
    if ZL.GameStatus == 1 then
        textUp = "Wave : "..ZL.wave

        Data.zombie = Lerp(5*FrameTime(), Data.zombie, ZL.remainingZombie)
        if Data.zombie > 0 and Data.zombie < zombieNumber then
            barFill = Data.zombie*wW/zombieNumber
        end
        barColor = "green"
        
        textDown = "Zombie remaining : "..ZL.remainingZombie
    elseif ZL.GameStatus == 2 then
        textUp = "Wave Transition"

        barFill = timer.TimeLeft("WaveTransitionTimer")*wW/ZL.WAVE_TRANSITION_TIME
        barColor = "pink"

        textDown = "Temps left : "..math.Round(timer.TimeLeft("WaveTransitionTimer"), 2)
    end
    
    ZLDraw.Text(textUp, "ZL50", ScrW()/2, 0, "white", TEXT_ALIGN_CENTER)
    ZLDraw.RoundedBox(4, ScrW()/2-wW/2, yW, wW, hW, "gray")

    ZLDraw.RoundedBox(4, ScrW()/2-wW/2, yW, barFill, hW, barColor)

    ZLDraw.Text(textDown, "ZL28", ScrW()/2, yW + hW, "white", TEXT_ALIGN_CENTER)

    -- Zombie points
    for k,v in ipairs(zombieKilledMsg) do
        if delay < CurTime() then
            v.pos.y = v.pos.y - 4
            v.alpha = v.alpha - 3
        elseif v.alpha <= 0 then
            table.RemoveByValue(zombieKilledMsg, v)
        end

        ZLDraw.Text("+ "..v.value.."xp", "ZL10", v.pos.x, v.pos.y, Color(212, 44, 76, v.alpha), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    if delay < CurTime() then
        delay = CurTime() + 0.05
    end
end)
hook.Add("HUDShouldDraw", "Hud_HookHudShouldDraw_CL", function(name)
	if name == "CHudHealth" or name == "CHudBattery" then return false end
end)

hook.Add("Play", "Hud_HookPlay_CL", function()
    timer.Simple(0.1, function()
        zombieNumber = ZL.remainingZombie
    end)
end)
hook.Add("WaveTransition", "Hud_HookWaveTransition_CL", function()
    timer.Create("WaveTransitionTimer", ZL.WAVE_TRANSITION_TIME, 1, function()
    end)
end)

gameevent.Listen("entity_killed")
hook.Add("entity_killed", "Hud_HookEntityKilled_CL", function(data)
    if LocalPlayer() ~= ents.GetByIndex(data.entindex_attacker) then return end

    local npc = ents.GetByIndex(data.entindex_killed)

    for k,v in ipairs(ZL.ZOMBIE) do
        if npc:GetClass() == v.entity then
            local point = npc:GetPos() + npc:OBBCenter()*2
            local point2D = point:ToScreen()

            if not point2D.visible then continue end

            table.insert(zombieKilledMsg, {value = v.experience, pos = {x=point2D.x, y=point2D.y}, alpha = 255})
        end
    end
end)