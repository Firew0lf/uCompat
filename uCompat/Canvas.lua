--[[
		Canvas related µLua compatibility layer/lib for ctrµLua
	
	If you used to use the canvas to speed up your drawing: f*ck you.
]]

require("uCompat.screen")

-- Constants

ATTR_X1 = 1
ATTR_Y1 = 2
ATTR_X2 = 3
ATTR_Y2 = 4
ATTR_X3 = 5
ATTR_Y3 = 6
ATTR_COLOR = 7
ATTR_COLOR1 = 8
ATTR_COLOR2 = 9
ATTR_COLOR3 = 10
ATTR_COLOR4 = 11
ATTR_TEXT = 12
ATTR_VISIBLE = 13
ATTR_FONT = 14
ATTR_IMAGE = 15

-- Local

local function attrTable()
	return {
		type = false,
		[ATTR_X1] = false,
		[ATTR_Y1] = false,
		[ATTR_X2] = false,
		[ATTR_Y2] = false,
		[ATTR_X3] = false,
		[ATTR_Y3] = false,
		[ATTR_COLOR] = false,
		[ATTR_COLOR1] = false,
		[ATTR_COLOR2] = false,
		[ATTR_COLOR3] = false,
		[ATTR_COLOR4] = false,
		[ATTR_TEXT] = false,
		[ATTR_VISIBLE] = false,
		[ATTR_FONT] = false,
		[ATTR_IMAGE] = false
	}
end

local TYPE_LINE = 1
local TYPE_POINT = 2
local TYPE_RECT = 3
local TYPE_FILLRECT = 4
local TYPE_GRADIENTRECT = 5
local TYPE_TEXT = 6
local TYPE_TEXTFONT = 7
local TYPE_TEXTBOX = 8
local TYPE_IMAGE = 9

local function searchObject(t, o)
	for n,v in pairs(t) do
		if (v == o) then return n end
	end
	return nil
end

-- Module

Canvas = {}

function Canvas.new()
	return {}
end

function Canvas.destroy(canvas)
	--
	collectgarbage()
end

function Canvas.newLine(x1, y1, x2, y2, color)
	local o = attrTable()
	o.type = TYPE_LINE
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_X2] = x2
	o[ATTR_Y2] = y2
	o[ATTR_COLOR] = color
	return o
end

function Canvas.newPoint(x1, y1, color)
	local o = attrTable()
	o.type = TYPE_POINT
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_COLOR] = color
	return o
end

function Canvas.newRect(x1, y1, x2, y2, color)
	local o = attrTable()
	o.type = TYPE_RECT
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_X2] = x2
	o[ATTR_Y2] = y2
	o[ATTR_COLOR] = color
	return o
end

function Canvas.newFillRect(x1, y1, x2, y2, color)
	local o = attrTable()
	o.type = TYPE_FILLRECT
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_X2] = x2
	o[ATTR_Y2] = y2
	o[ATTR_COLOR] = color
	return o
end

function Canvas.newGradientRect(x1, y1, x2, y2, color1, color2, color3, color4)
	local o = attrTable()
	o.type = TYPE_GRADIENTRECT
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_X2] = x2
	o[ATTR_Y2] = y2
	o[ATTR_COLOR1] = color1
	o[ATTR_COLOR2] = color2
	o[ATTR_COLOR3] = color3
	o[ATTR_COLOR4] = color4
	return o
end

function Canvas.newText(x1, y1 text, color)
	local o = attrTable()
	o.type = TYPE_TEXT
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_TEXT] = text
	o[ATTR_COLOR] = color
	return o
end

function Canvas.newTextFont(x1, y1, text, color, font)
	local o = attrTable()
	o.type = TYPE_TEXTFONT
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_TEXT] = text
	o[ATTR_COLOR] = color
	o[ATTR_FONT] = font
	return o
end

function Canvas.newTextBox(x1, y1, x2, y2, text, color)
	local o = attrTable()
	o.type = TYPE_TEXTBOX
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_X2] = x2
	o[ATTR_Y2] = y2
	o[ATTR_TEXT] = text
	o[ATTR_COLOR] = color
	return o
end

function Canvas.newImage(x1, y1, image, x2, y2, x3, y3)
	local o = attrTable()
	o.type = TYPE_IMAGE
	o[ATTR_X1] = x1
	o[ATTR_Y1] = y1
	o[ATTR_IMAGE] = image
	o[ATTR_X2] = x2
	o[ATTR_Y2] = y2
	o[ATTR_X3] = x3
	o[ATTR_Y3] = y3
end

function Canvas.add(canvas, object)
	canvas[#canvas+1] = object
end

function Canvas.draw(scr, canvas, x, y)
	for i=1, #canvas do
		local o = canvas[i] -- gotta go fast
		if o.type == TYPE_LINE then
			screen.drawLine(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_X2]+x, o[ATTR_Y2]+y, o[ATTR_COLOR])
		elseif o.type == TYPE_POINT then
			screen.drawPoint(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_COLOR])
		elseif o.type == TYPE_RECT then
			screen.drawRect(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_X2]+x, o[ATTR_Y2]+y, o[ATTR_COLOR])
		elseif o.type == TYPE_FILLRECT then
			screen.drawFillRect(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_X2]+x, o[ATTR_Y2]+y, o[ATTR_COLOR])
		elseif o.type == TYPE_GRADIENTRECT then
			screen.drawGradientRect(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_X2]+x, o[ATTR_Y2]+y, o[ATTR_COLOR1], o[ATTR_COLOR2], o[ATTR_COLOR3], o[ATTR_COLOR4])
		elseif o.type == TYPE_TEXT then
			screen.print(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_TEXT], o[ATTR_COLOR])
		elseif o.type == TYPE_TEXTFONT then
			screen.printFont(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_TEXT], o[ATTR_COLOR], o[ATTR_FONT])
		elseif o.type == TYPE_TEXTBOX then
			screen.drawTextBox(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_X2]+x, o[ATTR_Y2]+y, o[ATTR_TEXT], o[ATTR_COLOR])
		elseif o.type == TYPE_IMAGE then
			screen.blit(scr, o[ATTR_X1]+x, o[ATTR_Y1]+y, o[ATTR_IMAGE], o[ATTR_X2], o[ATTR_Y2], o[ATTR_X3], o[ATTR_Y3])
		end
	end
end

function Canvas.setAttr(object, attrName, attrValue)
	object[attrName] = attrValue
end

function Canvas.getAttr(object, attrName)
	return obect[attrName]
end

function Canvas.setObjOnTop(canvas, object)
	local i = searchObject(canvas, object)
	if not i then return end
	
	table.remove(canvas, i)
	canvas[#canvas+1] = object
end

function Canvas.removeObj(canvas, object)
	local i = searchObject(canvas, object)
	if not i then return end
	table.remove(canvas, i)
end
