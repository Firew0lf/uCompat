--[[
		Debug Images related µLua compatibility layer/lib for ctrµLua
]]

-- Module

Debug = {}

Debug.isDebugOn = false
Debug.listText = {}
Debug.debugText = ""
Debug.debugColor = Color.new(31, 31, 31)

function Debug.ON()
	Debug.isDebugOn = true
	Debug.clear()
end

function Debug.OFF()
	Debug.isDebugOn = false
end

Debug.print = function(text,aff)
	local i
	if(text == nil) then text = "<nil>"
	elseif(text == true) then text = "TRUE"
	elseif(text == false) then text = "FALSE"
	elseif(type(text) == "table") then text = "<"..tostring(text).."["..table.maxn(text).."]>"
	elseif(type(text) == "userdata") then text = "<"..tostring(text)..">"
	elseif(type(text) == "function") then text = "<"..tostring(text)..">"
	elseif(type(text) == "thread") then text = "<"..tostring(text)..">"
	end
	if(aff ~= nil) then
		if(aff ~= true) then aff = false end
	end
	if(#Debug.listText == 21) then
		for i=1,20 do
			Debug.listText[i] = Debug.listText[i+1]
		end
		Debug.listText[21] = text
	else
		Debug.listText[#Debug.listText] = text
	end
	Debug.debugText = ""
	for i = 1,#Debug.listText do
		Debug.debugText = (Debug.debugText..Debug.listText[i].."\n")
	end
	if aff then render() end
end

Debug.setColor = function(color)
	assert(color ~= nil, "Color can't be null")
	Debug.debugColor = color
end

Debug.clear = function()
	local i
	for i = 1,#Debug.listText do
		table.remove(Debug.listText,1)
	end
end
