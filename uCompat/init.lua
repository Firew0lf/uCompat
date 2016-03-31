--[[
		Main µLua compatibility layer/lib for ctrµLua

	The goal is not to provide a full compatibility, but something close.
]]

-- Just something needed

local ctr = require("ctr")
local ptm = require("ctr.ptm")

-- Setup the new3DS overclock, uncomment if you need more speed
ptm.init()
ptm.configureNew3DSCPU(true)

-- Constants
MICROLUA_VERSION = "Microlua 4.1" -- such old, very version
ULUA_VERSION = "Microlua 4.7.2"
ULUA_DIR = ctr.root -- you can change it to anything
ULUA_SCRIPTS = (ULUA_DIR.."scripts/") -- Warning: you may need to create the folder
ULUA_LIBS = (ULUA_DIR.."libs/")
ULUA_BOOT_FILE = "main.lua"
ULUA_BOOT_FULLPATH = (ULUA_DIR..ULUA_BOOT_FILE)

-- Some old Lua functions
function table.getn(t)
	return #t
end

unpack = table.unpack

-- Other libs
require("uCompat.screen")
require("uCompat.Color")
require("uCompat.Debug")
require("uCompat.Font")
require("uCompat.Image")
require("uCompat.Canvas")
require("uCompat.Map")
require("uCompat.ScrollMap")
require("uCompat.Timer")
require("uCompat.Sprite")
require("uCompat.Sound")
require("uCompat.Controls")
require("uCompat.Motion")
require("uCompat.Rumble")
require("uCompat.dsUser")
require("uCompat.System")
require("uCompat.ini")
require("uCompat.Wifi")
require("uCompat.Nifi")
require("uCompat.DateTime")
