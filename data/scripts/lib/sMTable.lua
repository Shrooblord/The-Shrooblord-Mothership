--The Shrooblord Mothership (C) 2020 Shrooblord
--Library module that contains essential table functions, such as key sorting for associative arrays.

-- *** Key Sorting in Associative Arrays *** --
--thanks to Karl @ https://stackoverflow.com/questions/2038418/associatively-sorting-a-table-by-value-in-lua
--[[ Eg.

items = {
    [1004] = "foo",
    [1234] = "bar",
    [3188] = "baz",
    [7007] = "quux",
}

local sortedKeys = getKeysSortedByValue(items, function(a, b) return a < b end)


--sortedKeys is {1234,3188,1004,7007}, and you can access your data like so:

for _, key in ipairs(sortedKeys) do
  print(key, items[key])
end


--result:

1234     bar     
3188     baz     
1004     foo     
7007     quux

]]
function getKeysSortedByValue(tbl, sortFunction)
    local keys = {}
    for key in pairs(tbl) do
        table.insert(keys, key)
    end

    table.sort(keys, function(a, b)
        return sortFunction(tbl[a], tbl[b])
    end)

    return keys
end
