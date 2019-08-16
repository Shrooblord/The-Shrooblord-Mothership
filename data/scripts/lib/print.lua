--Library module that contains essential print functions, such as extended log printing, debug strings, error messages, and prints to chat.

package.path = package.path .. ";data/scripts/lib/?.lua"
package.path = package.path .. ";data/scripts/?.lua"

function prt(strIn, fromScript, fromFunc, isServer)
    if onClient() then
        invokeServerFunction("prt", strIn, fromScript, fromFunc, isServer)
        return false
    end

    local ent

    if isServer then
        ent = {}
        ent.translatedTitle = "SERVER"
        ent.name = ""
    else
        ent = Entity()            
    end

    local x,y = Sector():getCoordinates()
    local coords = padCoords(x, y)
    print("GTTS <"..tostring(ent.translatedTitle).." "..tostring(ent.name)..">:["..fromScript.."]->"..fromFunc.." "..coords..":"..strIn%_t)
end
callable(nil, "prt")