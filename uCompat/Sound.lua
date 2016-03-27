--[[
	Sound
]]

Sound = {}

PLAY_ONCE = 0
PLAY_LOOP = 1

-- Module

-- Sound banks

function Sound.loadBank(filename)

end

function Sound.unloadBank()

end

-- Mods
function Sound.loadMod(id)

end

function Sound.unloadMod(id)

end

function Sound.startMod(id, playmode)

end

function Sound.pause()

end

function Sound.resume()

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

-- SFX

function Sound.loadSFX(id)

end

function Sound.unloadSFX(id)

end

function Sound.startSFX(id)
	return {"I am a SFX handle"}
end

function Sound.stopSFX(handle)

end

function Sound.releaseSFX(handle)

end

function Sound.stopAllSFX()

end

function Sound.setSFXVolume(handle, volume)

end

function Sound.setSFXPanning(handle, panning)

end

function Sound.setSFXPitch(handle, pitch)

end

function Sound.setSFXScalePitch(handle, scale)

end
