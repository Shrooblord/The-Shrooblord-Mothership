--The Shrooblord Mothership (C) 2019 Shrooblord
--Works together with other sMConfig scripts to handle the file I/O necessary for creating user config files that remain untouched by mod updates, save for adding new default keys.
--Heavily inspired by Hammelpilaw's ConfigLib and adapted to our needs.

package.path = package.path .. ";data/scripts/config/?.lua"
package.path = package.path .. ";data/scripts/lib/?.lua"

local sMConf = include("sMConf")

include ("sMPrint")

-- Don't remove or alter the following comment, it tells the game the namespace this script lives in. If you remove it, the script will break.
-- namespace sMConfIO
sMConfIO = {}

local fromScript = "lib/sMConfigIO"

-- [[*** Directories ***]]
function sMConfIO.getMod(modID)
    local fromFunc = "sMConfIO.getMod"

	local manager = ModManager()
	local mod = manager:findEnabled(modID)
	
	if not mod then
        prt("Could not load mod with ID [" .. modID .. "]", 1, sMConf.modID, fromScript, fromFunc, "SERVER")
	end
	
	return mod
end

-- Get the filename of the given mod without ".lua" extension.
function sMConfIO.getFilename(modID, ModName)
	if not modID then return end
	
	local mod = sMConfIO.getMod(modID)
	if not mod then return end
	
	if not ModName then
		ModName = mod.name
	end
	
	return ModName .. "-" .. modID
end

-- Get the modconfig path.
function sMConfIO.getConfigPath()
	if onServer() then -- Get config path inside galaxy folder
		return Server().folder .. "/moddata/ShrooblordMothership/config/"
	else -- Get config path in userdata folder
		return "ShrooblordMothership/config/"
	end
end

-- Get the full mod config path with filename and type extension (.lua)
function sMConfIO.getFullConfigPath(modID)
	local path = sMConfIO.getConfigPath()
	
	if onClient() then
		path = "moddata/" .. path -- getConfigPath() does not add moddata folder for client
	end
	local filename = sMConfIO.getFilename(modID)
	
	if path and filename then
		return path .. filename .. ".lua"
	end
	
	return ""
end

-- Get the original modconfig path.
function sMConfIO.getOrigConfigPath()
	return "data/scripts/modconfig/"
end

---------------------------------
------- Public namespace --------
---------------------------------
local PublicNamespace = {}

-- Load metadata for given mod
function PublicNamespace.getMod(modID)
	return sMConfIO.getMod(modID)
end

-- Load mod configs for given mods
function PublicNamespace.getModConfig(modID)
	local filename = sMConfIO.getFullConfigPath(modID)
	return sMConfIO.read(filename)
end

-- Update the server sided config file. Create if it does not exist yet
function PublicNamespace.updateModConfig(modID, origConfig)
	if not onServer() or not modID then return end
	local mod = sMConfIO.getMod(modID)
	
	if not mod then return end
	
	local filename = sMConfIO.getFilename(modID, mod.name)
	local path = sMConfIO.getConfigPath()
	
	if not origConfig then
		origConfig = include(sMConfIO.getOrigConfigPath() .. filename)
	end
	
	if origConfig then
		local modConfig = sMConfIO.read(path .. filename .. ".lua")
		
		if not modConfig then return end
		
		sMConfIO.merge(path .. filename .. ".lua", origConfig, modConfig)
	end
end

-- Write a temporary client sided config
function PublicNamespace.writeClientConfig(modID, modConfig)
	if not onClient() or not modConfig then return end
	
	local filename = sMConfIO.getFullConfigPath(modID)
	sMConfIO.write(filename, modConfig)
end


return PublicNamespace
