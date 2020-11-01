local PANEL = {}

function PANEL:Init()
    self.tabList = {}

    self:SetSize(ScrW()/5*3, ScrH()/5*3)
    self:SetTitle("")
    self:SetDraggable(false)
    self:ShowCloseButton(false)

    -- Title bar
    self.Title = vgui.Create("DLabel", self)
    self.Title:SetPos(10, 0)
    self.Title:SetSize(ZLDraw.GetTextSize("F4 Menu - Zombie Like", "ZL28"), 28)
    self.Title:SetText("F4 Menu - Zombie Like")
    self.Title:SetFont("ZL28")
    self.Title:SetTextColor(ZLDraw.SetColor("white"))

    self.CloseButton = vgui.Create("DButton", self)
    self.CloseButton:SetSize(28, 28)
    self.CloseButton:SetText("")
    self.CloseButton.Paint = function(s, w, h)
        ZLDraw.Image(0, 0, w, h, Material("close.png", "smooth mips"), "red")
    end
    self.CloseButton.DoClick = function()
        self:Close()
    end

    ---- Elements ----
    self:DockPadding(10, self.Title:GetTall()+10, 10, 10)

    -- Categories
    self.Categories = vgui.Create("DHorizontalScroller", self)
    self.Categories:Dock(TOP)
    self.Categories:DockMargin(0, 0, 0, 10)
    self.Categories:DockPadding(10, 0, 10, 0)

    -- Tab
    self.Tab = vgui.Create("DPanel", self)
    self.Tab:Dock(FILL)

    self:InvalidateLayout()
end

function PANEL:PerformLayout(w, h)
    self:SetSize(w, h)

    self.CloseButton:SetPos(w-5-28, 0)

    self.Categories:SetSize(0, (h-28)/11)
end

function PANEL:Paint(w, h)
    ZLDraw.Box(0, 0, w, h, "gray")
end

function PANEL:AddTab(name, panel, index)
    local button = self.Categories:Add("DButton")
    button:SetWidth(140)
    button:Dock(LEFT)
    button:DockMargin(10, 0, 10, 0)
    button:SetText("")
    button.Paint = function(s, w, h)
        ZLDraw.Text(name, "ZL28", w/2, 0, "white", TEXT_ALIGN_CENTER)
        if button.Selected then
            ZLDraw.Box(0, h-4, w, 4, "white")
        end
    end
    button.DoClick = function()
        self:SelectTab(name)
    end

    panel:SetVisible(false)
    panel:SetParent(self.Tab)
    panel:Dock(FILL)
    
    local tab = {
        name = name,
        button = button,
        panel = panel
    }
    table.insert(self.tabList, index or table.getn(self.tabList), tab)

    self:InvalidateLayout()
end

function PANEL:SelectTab(name)
    for k,v in pairs(self.tabList) do
        if name == v.name then
            v.button.Selected = true
            v.panel:SetVisible(true)
        else
            v.button.Selected = false
            v.panel:SetVisible(false)
        end
    end
end

vgui.Register("DF4Menu", PANEL, "DFrame")