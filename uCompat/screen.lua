--[[
		Screen related µLua compatibility layer/lib for ctrµLua

	Warning: as µLua API was created with the ass, all functions are declared as
globals. Keep this in mind.
	Also, not all the functions are implemented, it won't trigger errors but just
won't draw some things.
	The screen size is a real problem when you write something like this, so by
default the library uses NDS screen size, but you can change it to the 3DS size.
	Finally, µLua draw 1 screen each frame at 60 FPS, so to avoid graphical bugs
I had to reproduce this. That's bad, but I want something as close to the
original µLua as possible.

	µLua have ~4MB of RAM available to the user, so using some more bytes for this
library shouldn't be a problem :). Same thing for the CPU.
]]

-- Constants

SCREEN_WIDTH = 256
SCREEN_HEIGHT = 192
--SCREEN_WIDTH = 320 -- uncomment for a larger screen
--SCREEN_HEIGHT = 240 -- idem
SCREEN_UP = 0
SCREEN_DOWN = 1
ALPHA_RESET = 100

NB_FPS = 0

-- Local

local ctr = require("ctr")
local gfx = require("ctr.gfx")
local color = require("ctr.gfx.color")

-- As the µLua and ctrµLua drawing systems are very differents, we have to use a
-- stack. That's bad, but it's the only solution.
local videoStack = {[0] = {}, [1] = {}}

local alpha = ALPHA_RESET

local drawScreen = SCREEN_UP
local offsetX, offsetY = 0,0

local fpscount = 0
local fpstime = ctr.time()

local function RGB2RGBA(c)
	if not c then return color.getDefault() end
	local r = (c%32)*8
	local g = math.floor(c%1024/32)*8
	local b = math.floor(c/1024)*8
	return color.RGBA8(r, g, b, math.floor(alpha*2.55))
end

local function checkBuffer(scr)
	if scr == drawScreen then
		return videoStack[drawScreen]
	else
		return {}
	end
end

-- Module
function startDrawing()
	screen.startDrawing2D()
end

function stopDrawing()
	
	-- FPS counter
	if drawScreen == 0 then
		fpscount = fpscount + 1
	end
	if (ctr.time() - fpstime) > 1000 then
		NB_FPS = fpscount
		fpstime = ctr.time()
		fpscount = 0
	end

	-- Debug
	
	if Debug and Debug.isDebugOn then
		local buffer="FPS: "..NB_FPS
		local xx=255-(string.len(buffer)*6)
		screen.print(SCREEN_UP,171,152,"RAM : "..math.floor(collectgarbage("count")).."ko.",Debug.debugColor)
		screen.print(SCREEN_UP,171,162,"VRAM: "..System.CurrentVramFree().."o.",Debug.debugColor)
		screen.print(SCREEN_UP,171,172,"PRAM: "..System.CurrentPalFree().."o.",Debug.debugColor)
		screen.print(SCREEN_UP,171,182,"FPS : "..NB_FPS,Debug.debugColor)
		screen.drawTextBox(SCREEN_DOWN, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, Debug.debugText, Debug.debugColor)
	end
	
	-- render
	screen.endDrawing()
	screen.setAlpha(ALPHA_RESET)
end

function render()
	stopDrawing()
	startDrawing()
end

screen = {}


function screen.switch()
	SCREEN_UP, SCREEN_DOWN = SCREEN_DOWN, SCREEN_UP
end

function screen.getLayer()
	return #videoStack[drawScreen]
end

function screen.getAlphaLevel()
	return ALPHA_RESET
end

function screen.setAlpha(level, layer)
	alpha = level
end

function screen.print(scr, x, y, text, color)
	checkBuffer(scr)[#videoStack[scr]+1] = {"text", {offsetX+x, offsetY+y, text, 8, RGB2RGBA(color), nil}}
end

function screen.printFont(scr, x, y, text, color, font)
	checkBuffer(scr)[#videoStack[scr]+1] = {"text", {offsetX+x, offsetY+y, text, 8, RGB2RGBA(color), font}}
end

function screen.blit(scr, x, y, img, sx, sy, w, h)
	local sizex, sizey = img.texture:getSize()
	checkBuffer(scr)[#videoStack[scr]+1] = {"img", img.texture, {offsetX+x, offsetY+y, (sx or 0), (sy or 0), (w or sizex), (h or sizey), img.rotation}}
end

function screen.drawPoint(scr, x, y, color)
	checkBuffer(scr)[#videoStack[scr]+1] = {"point", {offsetX+x, offsetY+y, RGB2RGBA(color)}}
end

function screen.drawLine(scr, x0, y0, x1, y1, color)
	checkBuffer(scr)[#videoStack[scr]+1] = {"line", {offsetX+x0, offsetX+y0, offsetX+x1, offsetY+y1, RGB2RGBA(color)}}
end

function screen.drawRect(scr, x0, y0, x1, y1, color)
	checkBuffer(scr)[#videoStack[scr]+1] = {"line", {offsetX+x0, offsetY+y0, offsetX+x0, offsetY+y1, RGB2RGBA(color)}}
	checkBuffer(scr)[#videoStack[scr]+1] = {"line", {offsetX+x0, offsetY+y0, offsetX+x1, offsetY+y0, RGB2RGBA(color)}}
	checkBuffer(scr)[#videoStack[scr]+1] = {"line", {offsetX+x0, offsetY+y1, offsetX+x1, offsetY+y1, RGB2RGBA(color)}}
	checkBuffer(scr)[#videoStack[scr]+1] = {"line", {offsetX+x1, offsetY+y0, offsetX+x1, offsetY+y1, RGB2RGBA(color)}}
end

function screen.drawFillRect(scr, x0, y0, x1, y1, color)
	checkBuffer(scr)[#videoStack[scr]+1] = {"rectangle", {offsetX+x0, offsetY+y0, (x1-x0), (y1-y0), 0, RGB2RGBA(color)}}
end

function screen.drawGradientRect(scr, x0, y0, x1, y1, color, color, color, color)

end

function screen.drawTextBox(scr, x0, y0, x1, y1, text, color)
	checkBuffer(scr)[#videoStack[scr]+1] = {"wrappedText", {offsetX+x0, offsetY+y0, text, x1-x0, 8, RGB2RGBA(color)}}
end

function screen.drawTexturedQuad(scr, x0, y0, x1, y1, x2, y2, x3, y3, img, sx, sy, w, h)

end

function screen.drawTexturedTriangle(scr, x0, y0, x1, y1, x2, y2, img, sx, sy, w, h)

end

function screen.getMainLcd()
	return (drawScreen == SCREEN_UP)
end

function screen.setSpaceBetweenScreens(space) -- deprecated in µLua 4.7.1

end

function screen.init() -- unused

end

function screen.startDrawing2D() -- unused
		--reset the video stacks
	videoStack[drawScreen] = {}
	
	-- As you can change the screen size, we have to re-calculate this every time.
	offsetX = math.floor((gfx.BOTTOM_WIDTH-SCREEN_WIDTH)/2)
	offsetY = math.floor((gfx.BOTTOM_HEIGHT-SCREEN_HEIGHT)/2)
	if drawScreen == gfx.GFX_TOP then
		offsetX = offsetX + 40
	end
end

function screen.endDrawing()
	gfx.startFrame(drawScreen)
	--gfx.text(2, 2, "x: "..offsetX.." ;y: "..offsetY.." ;stackUP: "..#videoStack[0].." ;stackDOWN: "..#videoStack[1]) -- debug only
	--gfx.text(2, 12, "screen: "..drawScreen.." ; stack: "..#videoStack[drawScreen]) -- debug only
	for i=1, #videoStack[drawScreen] do
		local e = videoStack[drawScreen][i]
		if e[1] == "img" then
			e[2]:drawPart(table.unpack(e[3]))
		elseif e[1] == "map" then
			e[2]:draw(table.unpack(e[3]))
		else
			gfx[e[1]](table.unpack(e[2]))
		end
	end
	gfx.endFrame()
	
	-- set the screen
	drawScreen = ((drawScreen == 0 and 1) or 0)
	if drawScreen == 0 then
		gfx.render()
	else
		gfx.waitForVBlank()
	end
end

function screen.waitForVBL() -- unused
	gfx.waitForVBLank()
end

-- Interface

function screen.offset()
	return offsetX, offsetY
end

function screen.getStack(scr)
	return checkBuffer(scr)
end

-- Initialize the thing

startDrawing()
