--[[
		User's informations related µLua compatibility layer/lib for ctrµLua

	Informations are fake ones, until ctrµLua/the ctruLib can deal with it.
]]

-- Module

dsUser = {}

function dsUser.getColor()
	return 0
end

function dsUser.getBirthDay()
	return 1
end

function dsUser.getBirthMonth()
	return 1
end

function dsUser.getName()
	return "NDS"
end

function dsUser.getNameLength()
	return 3
end

function dsUser.getMessage()
	return ""
end

function dsUser.getMessageLength()
	return 0
end

function dsUser.getAlarmHour()
	return 0
end

function dsUser.getAlarmMinute()
	return 0
end

function dsUser.getLanguage()
	return 0
end

function dsUser.getGBAScreen()
	return false
end

function dsUser.getDefaultBrightness()
	return 0
end

function dsUser.getAutoMode()
	return false
end

dsUser.color = dsUser.getColor()
dsUser.birthDay = dsUser.getBirthDay()
dsUser.birthMonth = dsUser.getBirthMonth()
dsUser.name = dsUser.getName()
dsUser.nameLength = dsUser.getNameLength()
dsUser.message = dsUser.getMessage()
dsUser.messageLength = dsUser.getMessageLength()
dsUser.alarmHour = dsUser.getAlarmHour()
dsUser.alarmMinute = dsUser.getAlarmMinute()
dsUser.language = dsUser.getLanguage()
dsUser.GBAScreen = dsUser.getGBAScreen()
dsUser.defaultBrightness = dsUser.getDefaultBrightness()
dsUser.getAutoMode = dsUser.getAutoMode() -- strange, isn't it ?
