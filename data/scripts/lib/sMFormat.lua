--The Shrooblord Mothership (C) 2019 Shrooblord
--Library module that contains essential string formatting functions, such as padding Sector coordinates so they always take up the same amount of space in-text, time formatting, and others.

package.path = package.path .. ";data/scripts/lib/?.lua"

include("utility")
include("stringutility")

--Pads Sector coordinates so that coords like (23:2) take up the same space as (-302:-142) in-text.
function padCoords(x_in, y_in)
    local str = "("
    local x = x_in
    local y = y_in
        
    --  (-1  :y, (-20 :y, (-300:y
    if x < 0 then   --"(-x"
        if x > -100 then
            if x > -10 then
                str = string.format("%s ", str)
            end
            str = string.format("%s ", str)
        end
        -- (x
        str = string.format("%s%i", str, x)
    else            --"( x"
        if x < 100 then     --"(  99"
            if x < 10 then  --"(   9"
                str = string.format("%s ", str)
            end
            str = string.format("%s ", str)
        end
        str = string.format("%s %i", str, x)
    end
    
    --(x:
    str = string.format("%s:", str)
    
    --  (x:  -1), (x: -20), (x:-300)
    if y < 0 then
        if y < -99 then
            str = string.format("%s%i", str, y)
        elseif y < -9 then
            str = string.format("%s %i", str, y)
        else
            str = string.format("%s  %i", str, y)
        end
    else    
        if y < 10 then
            str = string.format("%s   %i", str, y)
        elseif y < 100 then
            str = string.format("%s  %i", str, y)
        else
            str = string.format("%s %i", str, y)
        end
    end
    
    --(x:y)
    str = string.format("%s)", str)
    return str
end

--Formats seconds into hours, minutes and seconds.
function formatTime(time_in)
    local timeTCS, timeTCM, timeTCH, timeStr
    timeTCS = time_in         --seconds
    timeTCM = 0
    timeTCH = 0
    
    while timeTCS >= 60 do
        timeTCM = timeTCM + 1
        
        if timeTCM >= 60 then
            timeTCH = timeTCH + 1
            timeTCM = timeTCM - 60
        end
        
        timeTCS = timeTCS - 60
    end
    
    if timeTCH > 0 then
        timeStr = tostring(timeTCH).."h "..tostring(timeTCM).."m "..tostring(timeTCS).."s"
    elseif timeTCM > 0 then
        timeStr = tostring(timeTCM).."m "..tostring(timeTCS).."s"
    else
        timeStr = tostring(timeTCS).."s"
    end
    
    return timeStr
end