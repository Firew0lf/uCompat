--[[
		User's informations related µLua compatibility layer/lib for ctrµLua

	Informations are fake ones, until ctrµLua/the ctruLib can deal with it.
]]

-- Local

local cfgu = require("ctr.cfgu")

local language5 = {
	[cfgu.LANGUAGE_JP] = 0,
	[cfgu.LANGUAGE_EN] = 1,
	[cfgu.LANGUAGE_FR] = 2,
	[cfgu.LANGUAGE_DE] = 3,
	[cfgu.LANGUAGE_IT] = 4,
	[cfgu.LANGUAGE_ES] = 5,
	-- always english if not in the list above
	[cfgu.LANGUAGE_ZH] = 1,
	[cfgu.LANGUAGE_KO] = 1,
	[cfgu.LANGUAGE_NL] = 1,
	[cfgu.LANGUAGE_PT] = 1,
	[cfgu.LANGUAGE_RU] = 1,
	[cfgu.LANGUAGE_TW] = 1
}

-- Module

dsUser = {}

function dsUser.getColor()
	return 0
end

function dsUser.getBirthDay()
	local _, day = cfgu.getBirthday()
	return day
end

function dsUser.getBirthMonth()
	local month, _ = cfgu.getBirthday()
	return month
end

function dsUser.getName()
	return cfgu.getUsername()
end

function dsUser.getNameLength()
	return #(dsUser.getName())
end

function dsUser.getMessage()
	return ""
end

function dsUser.getMessageLength()
	return #(dsUser.getMessage())
end

function dsUser.getAlarmHour()
	return 0
end

function dsUser.getAlarmMinute()
	return 0
end

function dsUser.getLanguage()
	return language5[cgfu.getLanguage()]
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
