--[[
		Fonts related µLua compatibility layer/lib for ctrµLua.
	
	No support for bitmap fonts actually, it would be too slow.
]]

-- Module

Font = {}

function Font.load(path)
	return true
end

function Font.destroy(font)
	font = nil
end

function Font.getCharHeight(font)
	return 8
end

function Font.getStringWidth(font, text)
	return (#text*6)
end
