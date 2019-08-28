--The Shrooblord Mothership (C) 2019 Shrooblord
--General config for the Shrooblord Mothership library mod.

-- Don't remove or alter the following comment, it tells the game the namespace this script lives in. If you remove it, the script will break.
-- namespace sMConf
sMConf = {}

    sMConf[0] = {
        modID = "GBL",      --identifier for the mod used in print strings, in this case, "global"
        override = false,   --when true, the settings in this configuration file override the settings in all other mods' config files where possible  
        develop = false,    --development/debug mode
        dbgLevel = 0,       --0 = off; 1 = info; 2 = verbose; 3 = extremely verbose; 4 = I WANT TO KNOW EVERYTHING
    }

return sMConf