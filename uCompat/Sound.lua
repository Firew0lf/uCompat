--[[
	Sound
]]

Sound = {}

PLAY_ONCE = 0
PLAY_LOOP = 1

-- Module

function Sound.loadMod(id)

end

function Sound.unloadMod(id)

end

function Sound.startMod(id, playmode)

end

function Sound.pause()

end

function Sound.stop()

end

function Sound.setPosition(id, position)

end

function Sound.isActive()
	return false
end

function Sound.startJingle(id)

end

function Sound.setModVolume(volume) -- range: 0-1024

end

function Sound.setJingleVolume(volume) -- range: 0-1024

end

function Sound.setModTempo(tempo) -- range: 512-2048

end

function Sound.setModPitch(pitch)

end
