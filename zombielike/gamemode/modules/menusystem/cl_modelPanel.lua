local PANEL = {}

PANEL.LEFT = 1
PANEL.RIGHT = 2

AccessorFunc(PANEL, "modelColor", "ModelColor")

local w, h = 450, 400
local xDistance = w/2 + w/8

local model
local newModel

local timerIdentifier = {
    "modelPanelAlpha",
    "newModelPanelAlpha"
}

function PANEL:Init()
    -- Model panel
    model = vgui.Create("DModelPanel", self)
    model:SetPos(0, 0)
    model:SetSize(w, h)
    model:SetModel(LocalPlayer():GetModel())
    model:SetCamPos(Vector(75, 0, 50))
    function model:LayoutEntity(entity) end
    model:SetCursor("arrow")
    model:SetAlpha(255)

    -- New model panel
    newModel = vgui.Create("DModelPanel", self)
    newModel:SetPos(xDistance, 0)
    newModel:SetSize(w, h)
    newModel:SetModel(LocalPlayer():GetModel())
    newModel:SetCamPos(Vector(75, 0, 50))
    function newModel:LayoutEntity(entity) end
    newModel:SetCursor("arrow")
    newModel:SetAlpha(0)

    -- Color
    self:SetModelColor(Color(61, 87, 105))

    -- Back arrow
    local modelBack = vgui.Create("DButton", self)
    modelBack:SetPos(0, h/2 - 50/2)
    modelBack:SetSize(50, 50)
    modelBack:SetText("")
    modelBack.Paint = function(s, w, h)
        ZLDraw.Image(0, 0, w, h, Material("arrow.png", "smooth mips"), "white")
    end
    modelBack.DoClick = function()
        ZL.allowedModel.currentIndex = ZL.allowedModel.currentIndex - 1
        self:ChangeModel(self.RIGHT)
    end

    -- Forward arrow
    local modelForward = vgui.Create("DButton", self)
    modelForward:SetPos(w - 50, h/2 - 50/2)
    modelForward:SetSize(50, 50)
    modelForward:SetText("")
    modelForward.Paint = function(s, w, h)
        ZLDraw.ImageRotated(0, 0, w, h, 180, Material("arrow.png", "smooth mips"), "white")
    end
    modelForward.DoClick = function()
        ZL.allowedModel.currentIndex = ZL.allowedModel.currentIndex + 1
        self:ChangeModel(self.LEFT)
    end
end

function PANEL:Reset(direction)
    model:SetPos(0, 0)
    model:SetAlpha(255)
    newModel:SetPos(xDistance, 0)
    newModel:SetAlpha(0)

    if direction == 1 then
        model:SetModel(ZL.allowedModel.models[ZL.allowedModel.currentIndex - 1])
    elseif direction == 2 then
        model:SetModel(ZL.allowedModel.models[ZL.allowedModel.currentIndex + 1])
    end
    function model.Entity:GetPlayerColor() return PANEL:GetModelColor() end

    for k,v in ipairs(timerIdentifier) do
        timer.Remove(v)
    end
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

    if ZL.allowedModel.currentIndex == 0 then ZL.allowedModel.currentIndex = table.getn(ZL.allowedModel.models)
    elseif ZL.allowedModel.currentIndex == table.getn(ZL.allowedModel.models) + 1 then ZL.allowedModel.currentIndex = 1 end

    net.Start("ChangePlayerModel")
    net.WriteEntity(LocalPlayer())
    net.WriteString(ZL.allowedModel.models[ZL.allowedModel.currentIndex])
    net.SendToServer()

    -- Animation
    newModel:SetModel(ZL.allowedModel.models[ZL.allowedModel.currentIndex])
    function newModel.Entity:GetPlayerColor() return PANEL:GetModelColor() end

    local xAdding, xStartPos
    if direction == 1 then
        xAdding = -xDistance
        xStartPos = xDistance
    elseif direction == 2 then
        xAdding = xDistance
        xStartPos = -xDistance
    else
        return
    end

    model:Stop()
    model:MoveTo(xAdding, 0, 0.7, 0, 0.25, function(table, panel)
        panel:SetPos(0, 0)

        panel:SetModel(ZL.allowedModel.models[ZL.allowedModel.currentIndex])
        function panel.Entity:GetPlayerColor() return PANEL:GetModelColor() end
    end)
    model:AlphaTo(0, 0.25, 0, function(table, panel)
        LaunchAlphaTimers(1, panel, 255)
    end)

    newModel:Stop()
    newModel:SetPos(xStartPos, 0)
    newModel:MoveTo(xStartPos + xAdding, 0, 0.75, 0, 0.25, function(table, panel)
        panel:SetPos(xDistance, 0)
    end)
    newModel:AlphaTo(255, 0.25, 0, function(table, panel)
        LaunchAlphaTimers(2, panel, 0)
    end)
end

function PANEL:SetModelColor(color)
    local color = Color(color.r, color.g, color.b)

    function model.Entity:GetPlayerColor() return color:ToVector() end

    function newModel.Entity:GetPlayerColor() return color:ToVector() end

    PANEL.modelColor = color:ToVector()
end

vgui.Register("DModelAnimated", PANEL, "PANEL")