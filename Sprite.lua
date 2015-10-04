--[[
		Sprites related µLua compatibility layer/lib for ctrµLua

	The code comes directly from the "libs.lua" file of the original µLua.
]]

-- Module

require("uCompat.Image")
require("uCompat.screen")

Sprite = {

	-- graph: path of the image which contains the sprite, or a image object
	-- height: height of the frames
	-- width: width of the frames
	-- dest: destination (RAM or VRAM)
	new = function(graph, width, height, dest)
		assert(graph ~= nil, "Graph can't be null")
		assert(width > 0, "Width must be positive")
		assert(height > 0, "Height must be positive")

		local img
		local animations = {}

		if type(graph) == "string" then
			assert(dest == RAM or dest == VRAM, "Destination must be RAM or VRAM")
			img = Image.load(graph, dest)
			assert(img, "Image not found: "..graph)
		elseif type(graph) == "userdata" then
			img = graph
		else
			error("Bad graph type")
		end
		
		-- ### Public methods ###
		
		-- Draw a frame
		-- scr: screen (SCREEN_UP or SCREEN_DOWN)
		-- x: X-coordinate where to draw the frame
		-- y: Y-coordinate where to draw the frame
		-- noFrame: number of the frame to draw
		local drawFrame = function(self, scr, x, y, noFrame)
			assert(scr == SCREEN_UP or scr == SCREEN_DOWN, "Bad screen number")
			assert(x ~= nil, "X can't be null")
			assert(y ~= nil, "Y can't be null")
			assert(noFrame ~= nil, "Frame number can't be null")
			local boardWidth = Image.width(img) / width
			local yy = math.floor(noFrame / boardWidth)
			local xx = noFrame - (yy * boardWidth)
			screen.blit(scr, x, y, img, xx*width, yy*height, width, height)
		end
		
		-- Create an animation
		-- tabAnim: the table of the animation frames
		-- delay: delay between each frame
		local addAnimation = function(self, tabAnim, delay)
			assert(tabAnim ~= nil, "Table can't be null")
			assert(delay >= 0, "Delay  must be positive")
			table.insert(animations, SpriteAnimation.new(tabAnim, delay))
		end
		
		-- Reset an animation
		-- noAnim: number of the animation
		local resetAnimation = function(self, noAnim)
			assert(noAnim > 0, "Animation number must be 1 or more")
			animations[noAnim].tmr:reset()
		end
		
		-- Start an animation
		-- noAnim: number of the animation
		local startAnimation = function(self, noAnim)
			assert(noAnim > 0, "Animation number must be 1 or more")
			animations[noAnim].tmr:start()
		end
		
		-- Stop an animation
		-- noAnim: number of the animation
		local stopAnimation = function(self, noAnim)
			assert(noAnim > 0, "Animation number must be 1 or more")
			animations[noAnim].tmr:stop()
		end
		
		-- Return true if the animation is at the end of a loop
		-- noAnim: number of the animation
		local isAnimationAtEnd = function(self, noAnim)
			assert(noAnim > 0, "Animation number must be 1 or more")
			return math.floor(animations[noAnim].tmr:getTime()/animations[noAnim].delay+1) >= #(animations[noAnim].tabAnim)
		end
		
		-- Play an animation
		-- scr: screen (SCREEN_UP or SCREEN_DOWN)
		-- x: X-coordinate where to draw the animation
		-- y: Y-coordinate where to draw the animation
		-- noAnim: number of the animation to draw
		local playAnimation = function(self, scr, x, y, noAnim)
			assert(scr == SCREEN_UP or scr == SCREEN_DOWN, "Bad screen number")
			assert(x ~= nil, "X can't be null")
			assert(y ~= nil, "Y can't be null")
			assert(noAnim > 0, "Animation number must be 1 or more")
			if not animations[noAnim].isPlayed then
				animations[noAnim].tmr:reset()
				animations[noAnim].tmr:start()
				animations[noAnim].isPlayed = true
			end
			if math.floor(animations[noAnim].tmr:getTime()/animations[noAnim].delay) >= #(animations[noAnim].tabAnim) then
				resetAnimation(self, noAnim)
				startAnimation(self, noAnim)
			end
			local animToDraw = animations[noAnim].tabAnim[math.floor(animations[noAnim].tmr:getTime()/animations[noAnim].delay)+1]
			if animToDraw ~= nil then
				drawFrame(self, scr, x, y, animToDraw)
			end
		end
		
		local getWidth = function(self)
			return width
		end
		
		local getHeight = function(self)
			return height
		end
		
		local destroy = function(self)
			for _, value in pairs(animations) do
				value = nil
			end
			Image.destroy(img)
			img = nil
		end
		
		-- ### Returns ###
		
		return {
			getWidth = getWidth,
			getHeight = getHeight,
			drawFrame = drawFrame,
			addAnimation = addAnimation,
			playAnimation = playAnimation,
			resetAnimation = resetAnimation,
			stopAnimation = stopAnimation,
			startAnimation = startAnimation,
			isAnimationAtEnd = isAnimationAtEnd,
			destroy = destroy
		}
	end

}

-- Declaration of the SpriteAnimation class
SpriteAnimation = {

	-- tabAnim: the table of the animation frames
	-- delay: delay between each frame
	new = function(tabAnim, delay)
			return {
				tabAnim = tabAnim,
				delay = delay,
				tmr = Timer.new(),
				isPlayed = false
			}
	end
	
}

