--[[ -- remove the block comment to enable

local newVehicle = {
	class = "placeholder1", -- TODO: Add class name here (Please note atm you can only reuse/replace existing vehicle classes (placeholder1-12) in mods its not possible to add new names)
	contents = "RandomF100TruckContents"
	}

-- search category to modify... (replace dune_buggy with the spawner cone type you wish to expand)
local categoryToAdjust = FindInTable(VehicleSpawnerManager.vehicleCategories, "category", "dune_buggy")

-- insert into the table and determine the current class count
local oldCount = #categoryToAdjust.classes
table.insert(categoryToAdjust.classes, newVehicle)
local newCount = #categoryToAdjust.classes

-- add more vehicles so that the new one is being selected as well
categoryToAdjust.initialMinVehicles = math.ceil( categoryToAdjust.initialMinVehicles * (newCount / oldCount) )

-- can be used to output changed script to server.log
-- examine the log file if everything is correct, in doubt you can log information out using System.Log
--dump(VehicleSpawnerManager)

]]--
