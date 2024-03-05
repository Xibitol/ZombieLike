local PANEL = {}

PANEL.LEFT = 1
PANEL.RIGHT = 2

AccessorFunc(PANEL, "modelColor", "ModelColor")

local timerIdentifier = {
    "modelPanelAlpha",
    "newModelPanelAlpha"
}

function PANEL:Init()
    self:SetSize(ScrW()/5*3, ScrH()/5*3)

    -- Model panel
    self.Model = vgui.Create("DModelPanel", self)
    self.Model:SetModel(LocalPlayer():GetModel())
    self.Model:SetCamPos(Vector(75, 0, 50))
    function self.Model:LayoutEntity(entity) end
    self.Model:SetCursor("arrow")
    self.Model:SetAlpha(255)

    -- New model panel
    self.NewModel = vgui.Create("DModelPanel", self)
    self.NewModel:SetModel(LocalPlayer():GetModel())
    self.NewModel:SetCamPos(Vector(75, 0, 50))
    function self.NewModel:LayoutEntity(entity) end
    self.NewModel:SetCursor("arrow")
    self.NewModel:SetAlpha(0)

    -- Color
    self:SetModelColor(Color(61, 87, 105))

    -- Back arrow
    self.BackButton = vgui.Create("DButton", self)
    self.BackButton:SetSize(50, 50)
    self.BackButton:SetText("")
    self.BackButton.Paint = function(s, w, h)
        ZLDraw.Image(0, 0, w, h, Material("arrow.png", "smooth mips"), "white")
    end
    self.BackButton.DoClick = function()
        ZL.MODEL.currentIndex = ZL.MODEL.currentIndex - 1
        self:ChangeModel(self.RIGHT)
    end

    -- Forward arrow
    self.ForwardArrow = vgui.Create("DButton", self)
    self.ForwardArrow:SetSize(50, 50)
    self.ForwardArrow:SetText("")
    self.ForwardArrow.Paint = function(s, w, h)
        ZLDraw.ImageRotated(0, 0, w, h, 180, Material("arrow.png", "smooth mips"), "white")
    end
    self.ForwardArrow.DoClick = function()
        ZL.MODEL.currentIndex = ZL.MODEL.currentIndex + 1
        self:ChangeModel(self.LEFT)
    end

    self:InvalidateLayout()
end

function PANEL:PerformLayout(w, h)
    self.xDistance = w/2 + w/8

    self.Model:SetPos(xDistance, 0)
    self.Model:SetSize(w, h)
    self.NewModel:SetPos(xDistance, 0)
    self.NewModel:SetSize(w, h)
    self.BackButton:SetPos(0, h/2 - 50/2)
    self.ForwardArrow:SetPos(w - 50, h/2 - 50/2)
end

function PANEL:Reset(direction)
    self.Model:Stop()
    self.Model:SetPos(0, 0)
    self.Model:SetAlpha(255)
    self.NewModel:Stop()
    self.NewModel:SetPos(xDistance, 0)
    self.NewModel:SetAlpha(0)

    if direction == 1 then
        self.Model:SetModel(ZL.MODEL.models[ZL.MODEL.currentIndex - 1])
    elseif direction == 2 then
        self.Model:SetModel(ZL.MODEL.models[ZL.MODEL.currentIndex + 1])
    end
    function self.Model.Entity:GetPlayerColor() return PANEL:GetModelColor() end
end

local function LaunchAlphaTimers(idNumber, panel, alpha)
    if timer.Exists(timerIdentifier[idNumber]) then
        timer.Stop(timerIdentifier[idNumber])
        timer.Start(timerIdentifier[idNumber])
    else
        timer.Create(timerIdentifier[idNumber], 0.475, 1, function()
            if IsValid(panel) then
                panel:SetAlpha(alpha)
            end
        end)
    end
end

function PANEL:ChangeModel(direction, changePlayerModel)
    self:Reset()

    if ZL.MODEL.currentIndex == 0 then ZL.MODEL.currentIndex = table.getn(ZL.MODEL.models)
    elseif ZL.MODEL.currentIndex == table.getn(ZL.MODEL.models) + 1 then ZL.MODEL.currentIndex = 1 end

    net.Start("ChangePlayerModel")
    net.WriteEntity(LocalPlayer())
    net.WriteString(ZL.MODEL.models[ZL.MODEL.currentIndex])
    net.SendToServer()

    -- Animation
    self.NewModel:SetModel(ZL.MODEL.models[ZL.MODEL.currentIndex])
    function self.NewModel.Entity:GetPlayerColor() return PANEL:GetModelColor() end

    local xAdding, xStartPos
    if direction == 1 then
        xAdding = -self.xDistance
        xStartPos = self.xDistance
    elseif direction == 2 then
        xAdding = self.xDistance
        xStartPos = -self.xDistance
    else
        return
    end

    self.Model:MoveTo(xAdding, 0, 0.7, 0, 0.25, function(table, panel)
        panel:SetPos(0, 0)
    
        panel:SetModel(ZL.MODEL.models[ZL.MODEL.currentIndex])
        function panel.Entity:GetPlayerColor() return PANEL:GetModelColor() end
    end)
    self.Model:AlphaTo(0, 0.25, 0, function(table, panel)
        LaunchAlphaTimers(1, panel, 255)
    end)

    self.NewModel:SetPos(xStartPos, 0)
    self.NewModel:MoveTo(xStartPos + xAdding, 0, 0.75, 0, 0.25, function(table, panel)
        panel:SetPos(xDistance, 0)
    end)
    self.NewModel:AlphaTo(255, 0.25, 0, function(table, panel)
        LaunchAlphaTimers(2, panel, 0)
    end)
end

function PANEL:SetModelColor(color)
    local color = Color(color.r, color.g, color.b)

    function self.Model.Entity:GetPlayerColor() return color:ToVector() end

    function self.NewModel.Entity:GetPlayerColor() return color:ToVector() end

    PANEL.modelColor = color:ToVector()
end

vgui.Register("DModelAnimated", PANEL, "PANEL")