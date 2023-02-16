--The Shrooblord Mothership (C) 2020 Shrooblord
--Library module that contains essential Maths functions, such as rounding a float to the nearest number of decimals.

--round to nearest given decimal places, by rounding down
function floorToNearest(num, dec)
    local mult = 10 ^ dec
    num = math.floor(num * mult) / mult

    return num
end

--round to nearest given decimal places, by rounding up
function ceilToNearest(num, dec)
    local mult = 10 ^ dec
    num = math.ceil(num * mult) / mult

    return num
end
