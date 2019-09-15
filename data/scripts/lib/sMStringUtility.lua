--The Shrooblord Mothership (C) 2019 Shrooblord
--Library module that contains essential string manipulation functions.

--returns true if the string <str> starts with the string given in <start>
function stringStartsWith(str, start)
    return str:sub(1, #start) == start
 end

 --returns true if the string <str> ends with the string given in <ending>
function stringEndsWith(str, ending)
    return ending == "" or str:sub(-#ending) == ending
 end

--replaces the input string <str> with a version that is capitalised.
--[firsWordOnly] if only the start of <str> should be capitalised.
--[ignoreSingleLetters] if single-lettered words (like "a") should not be capitalised.
 function stringCapitalise(str, firstWordOnly, singleLetters)
    if firstWordOnly then
        return str:gsub("^%l", string.upper)
    end

    if ignoreSingleLetters then
        return str:gsub("(%l)(%w+)", function(a,b) return string.upper(a)..b end)
    else
        return str:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
    end
end
