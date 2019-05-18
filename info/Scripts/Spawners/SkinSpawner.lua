SkinSpawner = {

--[[
	Property descriptions:
	skins - All of the possible skins that can be spawned for the venicle class
		name - the name of the skin
		percent - the percent change to receive this skin
	minDistance -- the minimum distance in meters the vehicle needs to be moved to have a chance to receive a skin
	percent -- the percent chance to be awarded some skin - check is performed every 30 seconds

	For the math, use this formula at this website:

	The 480 below is the number of checks performed over four hours and we want a 50% (.5) chance of getting
	a skin during that time.

	.5=1-\left(\frac{x}{1}\right)^{480}
	https://www.mathpapa.com/algebra-calculator.html

	Then subtract the number return from 1.0 to get the % used below
]]--

	skinCategories =
	{
		{
			category = "dune_buggy",
			skins =
			{
				{ name = "DuneBuggy_Black", percent = 8.0 },
				{ name = "DuneBuggy_Blue", percent = 9.0 },
				{ name = "DuneBuggy_Camo1", percent = 5.0 },
				{ name = "DuneBuggy_Camo2", percent = 5.0 },
				{ name = "DuneBuggy_Camo3", percent = 5.0 },
				{ name = "DuneBuggy_Camo4", percent = 5.0 },
				{ name = "DuneBuggy_Green", percent = 9.0 },
				{ name = "DuneBuggy_Orange", percent = 9.0 },
				{ name = "DuneBuggy_Pink", percent = 9.0 },
				{ name = "DuneBuggy_Purple", percent = 9.0 },
				{ name = "DuneBuggy_Red", percent = 9.0 },
				{ name = "DuneBuggy_White", percent = 9.0 }, -- Default skin
				{ name = "DuneBuggy_Yellow", percent = 9.0 },
			},
			minDistance = 180, -- top speed * 30 seconds / 3
			percent = .1443,
		},

		{
			category = "f100truck",
			skins =
			{
				{ name = "F100Truck_Black", percent = 8.0 },
				{ name = "F100Truck_Blue", percent = 9.0 },
				{ name = "F100Truck_Camo1", percent = 5.0 },
				{ name = "F100Truck_Camo2", percent = 5.0 },
				{ name = "F100Truck_Camo3", percent = 5.0 },
				{ name = "F100Truck_Camo4", percent = 5.0 },
				{ name = "F100Truck_Green", percent = 9.0 },
				{ name = "F100Truck_Orange", percent = 9.0 }, -- Default skin
				{ name = "F100Truck_Pink", percent = 9.0 },
				{ name = "F100Truck_Purple", percent = 9.0 },
				{ name = "F100Truck_Red", percent = 9.0 },
				{ name = "F100Truck_White", percent = 9.0 },
				{ name = "F100Truck_Yellow", percent = 9.0 },
			},
			minDistance = 210, -- top speed * 30 seconds / 3
			percent = .1443,
		},

		{
			category = "fishing_boat",
			skins =
			{
				{ name = "FishingBoat_Black", percent = 8.0 },
				{ name = "FishingBoat_Blue", percent = 9.0 },
				{ name = "FishingBoat_Camo1", percent = 5.0 },
				{ name = "FishingBoat_Camo2", percent = 5.0 },
				{ name = "FishingBoat_Camo3", percent = 5.0 },
				{ name = "FishingBoat_Camo4", percent = 5.0 },
				{ name = "FishingBoat_Green", percent = 9.0 },
				{ name = "FishingBoat_Orange", percent = 9.0 },
				{ name = "FishingBoat_Pink", percent = 9.0 },
				{ name = "FishingBoat_Purple", percent = 9.0 },
				{ name = "FishingBoat_Red", percent = 9.0 },
				{ name = "FishingBoat_White", percent = 9.0 }, -- Default skin
				{ name = "FishingBoat_Yellow", percent = 9.0 },
			},
			minDistance = 100, -- top speed * 30 seconds / 3
			percent = .1443,
		},

		{
			category = "quadbike",
			skins =
			{
				{ name = "Quadbike_Black", percent = 8.0 },
				{ name = "Quadbike_Blue", percent = 9.0 },
				{ name = "Quadbike_Camo1", percent = 5.0 },
				{ name = "Quadbike_Camo2", percent = 5.0 },
				{ name = "Quadbike_Camo3", percent = 5.0 },
				{ name = "Quadbike_Camo4", percent = 5.0 },
				{ name = "Quadbike_Green", percent = 9.0 },
				{ name = "Quadbike_Orange", percent = 9.0 },
				{ name = "Quadbike_Pink", percent = 9.0 },
				{ name = "Quadbike_Purple", percent = 9.0 },
				{ name = "Quadbike_Red", percent = 9.0 }, -- Default skin
				{ name = "Quadbike_White", percent = 9.0 },
				{ name = "Quadbike_Yellow", percent = 9.0 },
			},
			minDistance = 180, -- top speed * 30 seconds / 3
			percent = .1443,
		},

		{
			category = "sedan_base",
			skins =
			{
				{ name = "SedanBase_Black", percent = 8.0 },
				{ name = "SedanBase_Blue", percent = 9.0 },
				{ name = "SedanBase_Camo1", percent = 5.0 },
				{ name = "SedanBase_Camo2", percent = 5.0 },
				{ name = "SedanBase_Camo3", percent = 5.0 },
				{ name = "SedanBase_Camo4", percent = 5.0 },
				{ name = "SedanBase_Green", percent = 9.0 },
				{ name = "SedanBase_Orange", percent = 9.0 },
				{ name = "SedanBase_Pink", percent = 9.0 },
				{ name = "SedanBase_Purple", percent = 9.0 },
				{ name = "SedanBase_Red", percent = 9.0 },
				{ name = "SedanBase_White", percent = 9.0 }, -- Default skin
				{ name = "SedanBase_Yellow", percent = 9.0 },
			},
			minDistance = 210, -- top speed * 30 seconds / 3
			percent = .1443,
		},

		{
			category = "suv_basic",
			skins =
			{
				{ name = "SUVBasic_Black", percent = 8.0 },
				{ name = "SUVBasic_Blue", percent = 9.0 },
				{ name = "SUVBasic_Camo1", percent = 5.0 },
				{ name = "SUVBasic_Camo2", percent = 5.0 },
				{ name = "SUVBasic_Camo3", percent = 5.0 },
				{ name = "SUVBasic_Camo4", percent = 5.0 },
				{ name = "SUVBasic_Green", percent = 9.0 },
				{ name = "SUVBasic_Orange", percent = 9.0 },
				{ name = "SUVBasic_Pink", percent = 9.0 },
				{ name = "SUVBasic_Purple", percent = 9.0 },
				{ name = "SUVBasic_Red", percent = 9.0 },
				{ name = "SUVBasic_White", percent = 9.0 }, -- Default skin
				{ name = "SUVBasic_Yellow", percent = 9.0 },
			},
			minDistance = 190, -- top speed * 30 seconds / 3
			percent = .1443,
		},

		{
			category = "truck_semi",
			skins =
			{
				{ name = "TruckSemi_Black", percent = 8.0 },
				{ name = "TruckSemi_Blue", percent = 9.0 },
				{ name = "TruckSemi_Camo1", percent = 5.0 },
				{ name = "TruckSemi_Camo2", percent = 5.0 },
				{ name = "TruckSemi_Camo3", percent = 5.0 },
				{ name = "TruckSemi_Camo4", percent = 5.0 },
				{ name = "TruckSemi_Green", percent = 9.0 },
				{ name = "TruckSemi_Orange", percent = 9.0 },
				{ name = "TruckSemi_Pink", percent = 9.0 },
				{ name = "TruckSemi_Purple", percent = 9.0 },
				{ name = "TruckSemi_Red", percent = 9.0 },
				{ name = "TruckSemi_White", percent = 9.0 }, -- Default skin
				{ name = "TruckSemi_Yellow", percent = 9.0 },
			},
			minDistance = 200, -- top speed * 30 seconds / 3
			percent = .1443,
		},

		------------------------------------------------------------------
		-- Skins Awards for Weather Patterns
		-- These use: .5=1-\left(\frac{x}{1}\right)^{60}
		-- 50% chance every 30 minutes of a severe storm, except TheMist
		------------------------------------------------------------------

		{
			category = "RadStorm_Peak",
			skins =
			{
				{ name = "GasMaskBlue", percent = 25.0 },
				{ name = "GasMaskGreen", percent = 25.0 },
				{ name = "GasMaskRed", percent = 25.0 },
				{ name = "GasMaskYellow", percent = 25.0 },
			},
			minDistance = 0, -- no distance check since not in a vehicle
			percent = 1.1486,
		},

		{
			category = "NuclearFlashFreeze_Peak",
			skins =
			{
				{ name = "GasMaskBlue", percent = 25.0 },
				{ name = "GasMaskGreen", percent = 25.0 },
				{ name = "GasMaskRed", percent = 25.0 },
				{ name = "GasMaskYellow", percent = 25.0 },
			},
			minDistance = 0, -- no distance check since not in a vehicle
			percent = 1.1486,
		},

		{
			category = "TheMist",
			skins =
			{
				{ name = "GasMaskBlue", percent = 25.0 },
				{ name = "GasMaskGreen", percent = 25.0 },
				{ name = "GasMaskRed", percent = 25.0 },
				{ name = "GasMaskYellow", percent = 25.0 },
			},
			minDistance = 0, -- no distance check since not in a vehicle
			percent = .576, -- 50% chance every 60 minutes
		},
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function SkinSpawner:OnInit()
	--Log("SkinSpawner:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function SkinSpawner:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function SkinSpawner:OnReset()
	--Log("SkinSpawner:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function SkinSpawner:OnSpawn()
	self:Reset();
end

function SkinSpawner:Reset()
	--Log("SkinSpawner:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/skin_mods", true, true)