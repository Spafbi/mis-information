--[[-- remove the block comment to enable

-- sample weather mod
-- .. place as many files in the mods folder as you like they all will be executed in same order on client/server resulting in the same indicies etc.

-- define a new weather pattern
local newWeather = {
  name="NewClearSky",
  probability=1, 
  danger=-8,
  duration={15, 19},
  audio=
  {
    {
      class="AudioAreaAmbience",
      trigger="Play_wind",
      rtpc="wind_speed",
      rtpcValue=0.3,
    },
  },
}

-- Add new weather to patterns at the end of list
table.insert(Weather.patterns, newWeather)

-- Now adjust the weather chance so they total 100% again (substract from ClearSky/pattern 1)
local patternToAdjust = FindInTable(Weather.patterns, "name", "ClearSky") -- using function from common.lua)
patternToAdjust.probability = patternToAdjust.probability - newWeather.probability

-- to check if your mod has taken effect you can run wm_startPattern without params which will list all patterns and their probabilities

]]--