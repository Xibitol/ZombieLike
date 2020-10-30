local surface = surface
local draw = draw
local ipairs = ipairs
local Color = Color
local print = print

fontLoaded = false
module("ZLDraw")

----- Create font -----
function LoadFont()
    surface.CreateFont("ZL200", {font = "Comic Sans MS", size = 200})
    surface.CreateFont("ZL100", {font = "Comic Sans MS", size = 100})
    surface.CreateFont("ZL50", {font = "Comic Sans MS", size = 50})
    surface.CreateFont("ZL40", {font = "Comic Sans MS", size = 40})
    surface.CreateFont("ZL28", {font = "Comic Sans MS", size = 28})
    surface.CreateFont("ZL10", {font = "Comic Sans MS", size = 20, weight = 800})

    fontloaded = true
end

----- Text Align -----
TEXT_ALIGN_LEFT		= 0
TEXT_ALIGN_CENTER	= 1
TEXT_ALIGN_RIGHT	= 2
TEXT_ALIGN_TOP		= 3
TEXT_ALIGN_BOTTOM	= 4

----- Color function -----
function SetColor(color)
    if color == "white" then
        return Color(255, 255, 255, 255)
    elseif color == "green" then
        return Color(57, 164, 74, 255)
    elseif color == "pink" then
        return Color(237, 30, 121, 255)
    elseif color == "red" then
        return Color(212, 44, 76, 255)
    elseif color == "gray" then
        return Color(51, 51, 51, 255)
    else
        return color
    end
end

----- Draw box function -----
function Box(x, y, w, h, color)
    color = SetColor(color)

    surface.SetDrawColor(color.r, color.g, color.b, color.a)
    surface.DrawRect(x, y, w, h)
end
function RoundedBox(cornerRadius, x, y, w, h, color)
    color = SetColor(color)

    draw.RoundedBox(cornerRadius, x, y, w, h, color)
end

function BoxBorder(x, y, w, h, color, borderRadius, borderColor)
    if borderRadius == 0 then
        Box(x, y, w, h, color)
    else
        Box(x, y, w, h, color)

        Box(x, y, w, borderRadius) -- UP
        Box(x + w - borderRadius, y, borderRadius, h) -- LEFT
        Box(x, y + h - borderRadius, w, borderRadius) -- DOWN
        Box(x, y, borderRadius, h) -- RIGHT
    end
end
function RoundedBoxBorder(cornerRaduis, x, y, w, h, color, borderRadius, borderColor)
    if borderRadius == 0 and cornerRaduis == 0 then
        Box(x, y, w, h, color)
    elseif cornerRadius == 0 then
        BoxBorder(x, y, w, h, color, borderRadius, borderColor)
    elseif borderRadius == 0 then
        RoundedBox(cornerRadius, x, y, w, h, color)
    else
        RoundedBox(x, y, w, h, color)

        RoundedBox(x, y, w, borderRadius, borderColor) -- UP
        RoundedBox(x + w - borderRadius, y, borderRadius, h, borderColor) -- LEFT
        RoundedBox(x, y + h - borderRadius, w, borderRadius, borderColor) -- DOWN
        RoundedBox(x, y, borderRadius, h, borderColor) -- RIGHT
    end
end

function OutlineBox(x, y, w, h, color, borderRadius)
    if borderRadius == 0 then
        return
    else
        Box(x, y, w, borderRadius, color) -- UP
        Box(x + w - borderRadius, y, borderRadius, h, color) -- LEFT
        Box(x, y + h - borderRadius, w, borderRadius, color) -- DOWN
        Box(x, y, borderRadius, h, color) -- RIGHT
    end
end

----- Draw image function -----
function Image(x, y, w, h, material, color)
    ImageRotated(x, y, w, h, 0, material, color)
end
function ImageRotated(x, y, w, h, r, material, color)
    color = SetColor(color)

    surface.SetDrawColor(color.r, color.g, color.b, color.a)
    surface.SetMaterial(material)
    surface.DrawTexturedRectRotated(x+w/2, y+h/2, w, h, r)
end

----- Draw text function -----
function GetTextSize(text, font)
    surface.SetFont(font)
    return surface.GetTextSize(text)
end
function Text(text, font, x, y, color, xalign, yalign)
    if fontLoaded == false then return end

    color = SetColor(color)
    xalign = xalign or TEXT_ALIGN_LEFT
	yalign = yalign or TEXT_ALIGN_TOP
	local w, h = GetTextSize(text, font)

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

    surface.SetTextColor(color.r, color.g, color.b, color.a)
    surface.SetFont(font)
    surface.SetTextPos(x, y)
    surface.DrawText(text)
end
--[[
    ZLDraw.Texts(x, y, xalign, yalign, {
        {text = "Zombie", color = "green", font = "ZL200"},
        {text = "Like", color = Color(237, 30, 121, 255), font = "ZL200"}
    })
]]
function Texts(x, y, xalign, yalign, texts)
    xalign = xalign or TEXT_ALIGN_LEFT
	yalign = yalign or TEXT_ALIGN_TOP
    local text = ""
    local w, h = 0, 0
    for k, v in pairs(texts) do
        text = text..v.text
        local w2, h2 = GetTextSize(v.text, v.font)
        w = w + w2

        if h2 > h then
            h = h2 
        end
    end

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

    for k, v in pairs(texts) do
        Text(v.text, v.font, x, y, v.color, xalign, yalign)

        x = x + GetTextSize(v.text, v.font)
    end
end