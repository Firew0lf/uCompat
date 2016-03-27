--[[
		Images related µLua compatibility layer/lib for ctrµLua
]]

-- Local

local texture = require("ctr.gfx.texture")

-- Constants

RAM = texture.PLACE_RAM
VRAM = texture.PLACE_VRAM -- has to be "PLACE_RAM" on hardware

-- Module

Image = {}

function Image.load(path, dest)
	local t = texture.load(path, dest)
	if not t then return nil end
	return { -- Image object
		texture = t,
		rotation = 0,
		scaleX = 1,
		scaleY = 1
	}
end

function Image.destroy(img)
	img.texture:unload()
	img = nil
end

function Image.width(img)
	local x,y = img.texture:getSize()
	return x
end

function Image.height(img)
	local x,y = img.texture:getSize()
	return y
end

function Image.scale(img, w, h)
	local iw,ih = img.texture:getSize()
	img.scaleX = w/iw
	img.scaleY = h/ih
	img.texture:scale(img.scaleX, img.scaleY)
end

function Image.rotate(img, angle, cx, cy)
	img.rotation = angle*(math.pi/256)
end

function Image.rotateDegree(img, angle, cx, cy)
	img.rotation = angle*(math.pi/180)
end

function Image.mirrorH(img, activate)
	img.scaleY = (0-img.scaleY)
	img.texture:scale(img.scaleX, img.scaleY)
end

function Image.mirrorV(img, activate)
	img.scaleX = (0-img.scaleY)
	img.textire:scale(img.scaleX, img.scaleY)
end

function Image.setTint(img, color)
	img.texture:setBlendColor(color*256)
end

