--The Shrooblord Mothership (C) 2019 Shrooblord
--Exposes configuration file utility functions so that mods, when updated, only add new default keys to user configuration files. This reduces update overhead for server owners.
--Heavily inspired by Hammelpilaw's ConfigLib and adapted to our needs.

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
package.path = package.path .. ";data/scripts/config/?.lua"

include("callable")
local sMConf = include("sMConf")

-- Don't remove or alter the following comment, it tells the game the namespace this script lives in. If you remove it, the script will break.
-- namespace sMConfUtil
sMConfUtil = {}


