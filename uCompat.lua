--[[
		Main µLua compatibility layer/lib for ctrµLua

	The goal is not to provide a full compatibility, but something close.
]]

-- Constants
ULUA_VERSION = "4.7.2"
ULUA_DIR = "sdmc:/3ds/ctruLua/"
ULUA_SCRIPTS = (ULUA_DIR.."scripts/") -- Warning: you need to create the folder
ULUA_LIBS = (ULUA_DIR.."libs/")
ULUA_BOOT_FILE = "main.lua"
ULUA_BOOT_FULLPATH = (ULUA_DIR..ULUA_BOOT_FILE)

-- Other libs
require("uCompat.screen")
require("uCompat.Color")
require("uCompat.Controls")
