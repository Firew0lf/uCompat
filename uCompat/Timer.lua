--[[
		Timers related µLua compatibility layer/lib for ctrµLua
	
	The code comes directly from µLua, befores timers were coded in C, but with
the name patch.
]]

-- Local

local ctr = require("ctr")

-- Module

Timer = {
	new = function()
		local t = ctr.time() -- small patch
		local isStarted = false
		local tick = 0
	
		local time = function(self)
			if isStarted then return ctr.time() - t
			else return tick end
		end
	
		local stop = function(self)
			if isStarted then
				isStarted = false
				tick = ctr.time() - t
			end
		end
		
		local start = function(self)
			if not isStarted then
				isStarted = true
				t = ctr.time() - tick 	
			end
		end
		
		local reset = function(self)
			t = ctr.time()
			isStarted = false
			tick = 0				
		end
	
		return{
			time = time,
			getTime = time, -- name patch
			stop = stop,
			start = start,
			reset = reset
		}
	end
}
