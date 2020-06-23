--[[-- remove the block comment to enable

-- Other options include disabling a pattern: 

-- find the patterns to modify (using function from common.lua)
local patternToAdjust = FindInTable(Weather.patterns, "name", "ClearSky")
local patternToAdjust2 = FindInTable(Weather.patterns, "name", "RadStorm")

-- add probability
patternToAdjust.probability = patternToAdjust.probability + patternToAdjust2.probability

-- remove probability
patternToAdjust2.probability = 0

-- the same way any other properties can be modified of exisiting patterns

]]--