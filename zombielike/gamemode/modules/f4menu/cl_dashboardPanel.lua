local PANEL = {}

function PANEL:Init()
    self:SetSize(1000, 500)
    
    -- Left
    self.Left = vgui.Create("DPanel", self)
    self.Left:Dock(FILL)
    self.Left:DockMargin(0, 0, 10, 0)
    self.Left.Paint = function(s, w, h)
        ZLDraw.Box(0, 0, w, h, "gray")
        ZLDraw.OutlineBox(0, 0, w, h, "pink", 4)
    end

    self.Left.Model = vgui.Create("DModelPanel", self.Left)
    self.Left.Model:Dock(LEFT)
    self.Left.Model:SetCamPos(Vector(75, 0, 50))
    self.Left.Model:SetFOV(30)
    self.Left.Model:SetCursor("arrow")
    self.Left.Model:SetModel(LocalPlayer():GetModel())
    function self.Left.Model:LayoutEntity(entity) end
    function self.Left.Model.Entity:GetPlayerColor() return LocalPlayer():GetPlayerColor() end

    self.Left.UpperBox = vgui.Create("DPanel", self.Left)
    self.Left.UpperBox:Dock(TOP)
    self.Left.UpperBox.Paint = function(s, w, h) end

    self.Left.Name = vgui.Create("DLabel", self.Left)
    self.Left.Name:Dock(TOP)
    self.Left.Name:DockMargin(0, 0, 0, 10)
    self.Left.Name:SetText(LocalPlayer():GetName())
    self.Left.Name:SetFont("ZL28")
    self.Left.Name:SetTextColor(ZLDraw.SetColor("white"))

    self.Left.Health = vgui.Create("DPanel", self.Left)
    self.Left.Health:Dock(TOP)
    self.Left.Health:DockMargin(0, 0, 10, 10)
    self.Left.Health.Paint = function(s, w, h)
        ZLDraw.RoundedBox(4, 0, 0, w, h, Color(112, 112, 112))
        ZLDraw.RoundedBox(4, 0, 0, LocalPlayer():Health()*w/100, h, Color(200, 40, 70))
        ZLDraw.Text(LocalPlayer():Health(), "ZL10", 10, 5, "white")
    end

    -- Right
    self.Right = vgui.Create("DPanel", self)
    self.Right:Dock(RIGHT)
    self.Right.Paint = function(s, w, h)
        ZLDraw.Box(0, 0, w, h, "gray")
        ZLDraw.OutlineBox(0, 0, w, h, "green", 4)
    end

    self:InvalidateLayout()
end

function PANEL:PerformLayout(w, h)
    self:SetSize(w, h)

    self.Left.Model:SetSize(w/5, h-h/12)
    self.Left.UpperBox:SetSize(0, h/6)
    self.Left.Health:SetSize(0, 20)

    self.Right:SetSize(w/3.8, 0)
end

function PANEL:Paint(w, h)
    ZLDraw.Box(0, 0, w, h, "gray")
end

vgui.Register("DDashboard", PANEL, "DPanel")