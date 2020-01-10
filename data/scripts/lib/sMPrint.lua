--The Shrooblord Mothership (C) 2019 Shrooblord
--Library module that contains essential print functions, such as extended log printing, debug strings, error messages, and prints to chat.

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"
package.path = package.path .. ";data/scripts/config/?.lua"

include("callable")
include("sMFormat")
local sMConf = include("sMConf")

--strIn         : the string to print
--isError [0/1] : if it's an error, will display differently for the user to indicate an error
--modID         : global tag for the mod that's printing this string, so you can tell which mod is spitting out messages
--fromScript    : which .lua script is causing this print message? (defined in each script as it calls this function)
--fromFunc      : which function is causing this print message? (similar to above)
--override      : if defined, labels the area normally reseved for the Entity that's running the script triggering this print with the string supplied (very useful for "server prints")
function prt(strIn, isError, modID, fromScript, fromFunc, override)
    if onClient() then
        invokeServerFunction("prt", strIn, isError, modID, fromScript, fromFunc, override)
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

    local label = ""
    if isError == 1 then
        label = "[ERROR]"
    end

    local x,y = Sector():getCoordinates()
    local coords = padCoords(x, y)
    print("["..modID.."]"..label.." <"..tostring(ent.translatedTitle).." "..tostring(ent.name)..">:["..fromScript.."]->"..fromFunc.." "..coords..":"..strIn)
end
callable(nil, "prt")

--see prt(); additionally:
--This function only runs on the Client. Doesn't include calls to onServer() only objects like Sector(), and should only be called from Client-only functions (such as UI code)
function prtClient(strIn, isError, modID, fromScript, fromFunc, override)
    local ent

    if override then
        ent = {}
        ent.translatedTitle = override
        ent.name = ""
    else
        ent = Entity()            
    end

    local label = ""
    if isError == 1 then
        label = "[ERROR]"
    end

    print("["..modID.."]"..label.." <"..tostring(ent.translatedTitle).." "..tostring(ent.name)..">:["..fromScript.."]->"..fromFunc..":"..strIn)
end

--See prt(); additionally:
--dbgLevel      : if the dbgLevel for this debug message < the dbgLevel set in config, this message will "silently fail" to print, i.e. dbgLevel in config hides debug messages of higher order
--isClient      : whether this is a print that should use onServer() functionality like Sector(), or whether it would fail if we call this onServer(), such as calling it from a Client-only function
function prtDbg(strIn, isError, modID, dbgLevel, fromScript, fromFunc, override, isClient)
    if sMConf[0].override == true then
        if sMConf[0].dbgLevel >= dbgLevel then
            prt(strIn, isError, modID, fromScript, fromFunc, override)
        end
    else
        for i=0, #sMConf do
            if sMConf[i].modID == modID then
                if sMConf[i].dbgLevel >= dbgLevel then
                    if isClient then
                        prtClient(strIn, isError, modID, fromScript, fromFunc, override)
                    else
                        prt(strIn, isError, modID, fromScript, fromFunc, override)
                    end
                end
                goto done
            end
        end

        local err = "Mod not found in config list! This is a mod installation error. Please make sure all dependencies are met, and contact Shrooblord if this problem persists."%_t
        
        if isClient then
            prtClient(err, 1, modID, fromScript, fromFunc, override)
        else
            prt(err, 1, modID, fromScript, fromFunc, override)
        end
    end
    ::done::
end
callable(nil, "prtDbg")

--See prtDbg(); additionally:
function prtDbgClient(strIn, isError, modID, dbgLevel, fromScript, fromFunc, override)
    prtDbg(strIn, isError, modID, dbgLevel, fromScript, fromFunc, override, true)
end