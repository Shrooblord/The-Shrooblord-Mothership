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