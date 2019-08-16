--The Shrooblord Mothership (C) 2019 Shrooblord
--Library module that contains essential print functions, such as extended log printing, debug strings, error messages, and prints to chat.

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

include("callable")
include("sMFormat")
local sMConf = include("sMConf")

function prt(strIn, isError, modID, fromScript, fromFunc, override)
    if onClient() then
        invokeServerFunction("prt", strIn, fromScript, fromFunc, additional, override)
        return false
    end

    local ent

    if override then
        ent = {}
        ent.translatedTitle = override
        ent.name = ""
    else
        ent = Entity()            
    end

    local additional = ""
    if isError == 1 then
        additional = "[ERROR]"
    end

    local x,y = Sector():getCoordinates()
    local coords = padCoords(x, y)
    print("["..modID.."]"..additional.." <"..tostring(ent.translatedTitle).." "..tostring(ent.name)..">:["..fromScript.."]->"..fromFunc.." "..coords..":"..strIn)
end
callable(nil, "prt")

function prtDbg(strIn, isError, modID, dbgLevel, fromScript, fromFunc, override)
    if onClient() then
        invokeServerFunction("prtDbg", strIn, isError, modID, dbgLevel, fromScript, fromFunc, override)
        return false
    end

    if sMConf[0].override == true then
        if sMConf[0].dbgLevel >= dbgLevel then
            prt(strIn,isError, modID, dbgLevel, fromScript, fromFunc, override)
        end
    else
        for i=0, #sMConf do
            print("["..modID.."] == "..sMConf[i].id.."?")
            if sMConf[i].id == modID then
                if sMConf[i].dbgLevel >= dbgLevel then
                    prt(strIn,isError, modID, dbgLevel, fromScript, fromFunc, override)
                end
                goto done
            end
        end

        prt("Mod not found in config list! This is a mod installation error. Please make sure all dependencies are met, and contact Shrooblord if this problem persists.", 1, modID, fromScript, fromFunc, override)
    end
    ::done::
end
callable(nil, "prtDbg")