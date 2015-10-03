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

-- As the µLua and ctrµLua drawing systems are very differents, we have to use a
-- stack. That's bad, but it's the only solution.
local videoStack = {}

local alpha = ALPHA_RESET

local drawScreen = SCREEN_UP

local fpscount = 0
local fpstime = ctr.time()

local function RGB2RGBA(c)
	return (c*256)+alpha)
end

-- Module
function startDrawing()
	screen.startDrawing2D()
end

function stopDrawing()
	-- As you can change the screen size, we have to re-calculate this every time.
	local offsetX = (gfx.BOTTOM_WIDTH-SCREEN_WIDTH)/2
	local offsetY = (gfx.BOTTOM_HEIGHT-SCREEN_HEIGHT)/2
	if drawScreen == gfx.SCREEN_UP then
		offsetX = offsetX + 40
	end
	
	-- FPS counter
	fpscount = fpscount + 1
	if (ctr.time() - fpstime) > 1000 then
		NB_FPS = fpscount
		fpscount = 0
	end
	
	-- render
	screen.endDrawing()
	
	-- set the screen
	drawScreen = ((drawScreen == 0 and 1) or 0)
end

function render()
	startDrawing()
	stopDrawing()
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
	videoStack[scr][#videoStack[scr]] = {"text", {x, y, text, 8, RGB2RGBA(color), nil}}
end

function screen.printFont(scr, x, y, text, color, font)
	videoStack[scr][#videoStack[scr]] = {"text", {x, y, text, 8, RGB2RGBA(color), font}}
end

function screen.blit(scr, x, y, img, sx, sy, w, h)
	local sizex, sizey = img:getSize()
	videoStack[scr][#videoStack[scr]] = {"img", {x, y, (sx or 0), (sy or 0), (w or sizex), (h or sizey)}}
end

function screen.drawPoint(scr, x, y, color)
	videoStack[scr][#videoStack[scr]] = {"point", {x, y, RGB2RGBA(color)}}
end

function screen.drawLine(scr, x0, y0, x1, y1, color)
	videoStack[scr][#videoStack[scr]] = {"line", {x0, y0, x1, y1, RGB2RGBA(color)}}
end

function screen.drawRect(scr, x0, y0, x1, y1, color)
	videoStack[scr][#videoStack[scr]] = {"line", {x0, y0, x0, y1, RGB2RGBA(color)}}
	videoStack[scr][#videoStack[scr]] = {"line", {x0, y0, x1, y0, RGB2RGBA(color)}}
	videoStack[scr][#videoStack[scr]] = {"line", {x0, y1, x1, y1, RGB2RGBA(color)}}
	videoStack[scr][#videoStack[scr]] = {"line", {x1, y0, x1, y1, RGB2RGBA(color)}}
end

function screen.drawFillRect(scr, x0, y0, x1, y1, color)
	videoStack[scr][#videoStack[scr]] = {"rectangle", {x0, y0, (x1-x0), (y1-y0), 0, RGB2RGBA(color)}}
end

function screen.drawGradientRect(scr, x0, y0, x1, y1, color, color, color, color)

end

function screen.drawTextBox(scr, x0, y0, x1, y1, text, color)

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
	videoStack = {}
	videoStack[0] = {}
	videoStack[1] = {}
end

function screen.endDrawing()
	gfx.startFrame(drawScreen)
	for i=1, #videoStack[drawScreen] do
		local e = videoStack[drawScreen][i]
		if e[1] == "img" then
			
		else
			gfx[e[1]](unpack(e[2])
		end
	end
	gfx.endFrame()
	gfx.render()
end

function screen.waitForVBL() -- unused

end
