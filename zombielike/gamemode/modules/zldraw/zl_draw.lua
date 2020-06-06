module("ZLDraw", package.seeall)

----- Create font -----
surface.CreateFont("ZL200", {font = "Comic Sans MS", size = 200})
surface.CreateFont("ZL100", {font = "Comic Sans MS", size = 100})
surface.CreateFont("ZL50", {font = "Comic Sans MS", size = 50})
surface.CreateFont("ZL28", {font = "Comic Sans MS", size = 28})
surface.CreateFont("ZL10", {font = "Comic Sans MS", size = 20})

----- Text Align -----
TEXT_ALIGN_LEFT		= 0
TEXT_ALIGN_CENTER	= 1
TEXT_ALIGN_RIGHT	= 2
TEXT_ALIGN_TOP		= 3
TEXT_ALIGN_BOTTOM	= 4

----- Draw function -----
function ZLDraw.Box(x, y, w, h, color)
    surface.SetDrawColor(color.r, color.g, color.b, color.a)
    surface.DrawRect(x, y, w, h)
end
function ZLDraw.RoundedBox(cornerRadius, x, y, w, h, color)
    draw.RoundedBox(cornerRadius, x, y, w, h, color)
end

function ZLDraw.BoxBorder(x, y, w, h, color, borderRadius, borderColor)
    if borderRadius == 0 then
        ZLDraw.Box(x, y, w, h, color)
    else
        ZLDraw.Box(x, y, w, h, color)

        surface.SetDrawColor(borderColor.r, borderColor.g, borderColor.b, borderColor.a)
        surface.DrawRect(x, y, w, borderRadius) -- UP
        surface.DrawRect(x + w - borderRadius, y, borderRadius, h) -- LEFT
        surface.DrawRect(x, y + h - borderRadius, w, borderRadius) -- DOWN
        surface.DrawRect(x, y, borderRadius, h) -- RIGHT
    end
end
function ZLDraw.RoundedBoxBorder(cornerRaduis, x, y, w, h, color, borderRadius, borderColor)
    if borderRadius == 0 and cornerRaduis == 0 then
        ZLDraw.Box(x, y, w, h, color)
    elseif cornerRadius == 0 then
        ZLDraw.BoxBorder(x, y, w, h, color, borderRadius, borderColor)
    elseif borderRadius == 0 then
        ZLDraw.RoundedBox(cornerRadius, x, y, w, h, color)
    else
        ZLDraw.RoundedBox(x, y, w, h, color)

        ZLDraw.RoundedBox(x, y, w, borderRadius, borderColor) -- UP
        ZLDraw.RoundedBox(x + w - borderRadius, y, borderRadius, h, borderColor) -- LEFT
        ZLDraw.RoundedBox(x, y + h - borderRadius, w, borderRadius, borderColor) -- DOWN
        ZLDraw.RoundedBox(x, y, borderRadius, h, borderColor) -- RIGHT
    end
end

function ZLDraw.OutlineBox(x, y, w, h, color, borderRadius)
    if borderRadius == 0 then
        return
    else
        surface.SetDrawColor(color.r, color.g, color.b, color.a)
        surface.DrawRect(x, y, w, borderRadius) -- UP
        surface.DrawRect(x + w - borderRadius, y, borderRadius, h) -- LEFT
        surface.DrawRect(x, y + h - borderRadius, w, borderRadius) -- DOWN
        surface.DrawRect(x, y, borderRadius, h) -- RIGHT
    end
end
function ZLDraw.RoundedOutlineBox(cornerRaduis, x, y, w, h, color, borderRadius)
    if borderRadius == 0 then
        return
    else
        ZLDraw.RoundedBox(x, y, w, borderRadius, color) -- UP
        ZLDraw.RoundedBox(x + w - borderRadius, y, borderRadius, h, color) -- LEFT
        ZLDraw.RoundedBox(x, y + h - borderRadius, w, borderRadius, color) -- DOWN
        ZLDraw.RoundedBox(x, y, borderRadius, h, color) -- RIGHT
    end
end

-- Not working
--[[function ZLDraw.Image(x, y, w, h, material)
    surface.SetDrawColor(0,0,0,0)
    surface.SetMaterial(material)
    surface.DrawRect(x, y, w, h)
end]]

function ZLDraw.Text(text, fontName, x, y, color, xalign, yalign)
    surface.SetTextColor(color.r, color.g, color.b, color.a)
    surface.SetFont(fontName)

    local xalign = xalign or TEXT_ALIGN_LEFT
	local yalign = yalign or TEXT_ALIGN_TOP
	local w, h = surface.GetTextSize( text )

	if ( xalign == TEXT_ALIGN_CENTER ) then
		x = x - w / 2
	elseif ( xalign == TEXT_ALIGN_RIGHT ) then
		x = x - w
	end

	if ( yalign == TEXT_ALIGN_CENTER ) then
		y = y - h / 2
	elseif ( yalign == TEXT_ALIGN_BOTTOM ) then
		y = y - h
	end

    surface.SetTextPos(x, y)
    surface.DrawText(text)
end
function ZLDraw.GetTextSize(text)
    return surface.GetTextSize(text)
end