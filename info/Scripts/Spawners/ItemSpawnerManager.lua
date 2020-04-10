ItemSpawnerManager =
{

--[[

Each item category below can either have a "classes" or a "group" table in it.
If it contains a "group", then the spawner will process ALL of the items in the group and attempt to spawn all of them.
Using a group allows you to spawn a group of items at once (like a weapon and ammo for it).
If it contains a "classes" then it will radomly pick just ONE of them to attempt to spawn.

Example:

	category = "RandomAttachments",
	group = -- tries to spawn ALL items below
	{
		{ class = "M40x5", percent = 25.0 }, -- 25% chance this item will be spawned
		{ class = "HuntingScope", percent = 5.0 }, -- 5% chance this item will be spawned
	},

{ class = "SchoolPackGreen", percent = 100 },

The percent can be accurate to 4 decimal places (.001) to make for rare item spawns (one in 1,000), but the categories can be nested,
so you can have for example a 1 in 1,000 chance for a category that has a 1 in 1,000 chance of an item so 1 in 1,000,000 in that case for a really rare spawn

Item Categories can be nested to allow for a great amount of variety when spawning items.

--------------

Item Contents:

To add contents to the storage space for an item when it is spawned you need to tell the storage
category that it has "contents", like this:

	{ class = "RuggedPack", contents="RandomBackpackContents", percent = 25 },

Then, when you define the contents category you can use the optional percent, min, and max attributes like so:

	category = "RandomBackpackContents",
	classes =
	{
		{category = "RandomFood", percent = 15, min = 1, max = 4 },
	},

What the above does is if a "RuggedPack" is spawned then there is a 15% chance that it will spawn with between
1 and 4 "RandomFood" items. A first item is always guaranteed to be spawned, but each successive item's percent is
reduced to 25% of the prior item's, like so:

1st item = 100% to spawn
2nd item = 25% to spawn (if first item spawned)
3rd item = 6.25% to spawn (if second item spawned)
4th item = 1.5625% to spawn (if third item spawned)
...

The level_specific flag only works on a cateogory
If it is set to 1, then it will try and match to the specified category name appended with an underscore and the current level name.
For example, if the current level is islands and the category name is fred, then it would try and find a catgory named fred_islands.
If fred_islands does not exist, then it will use fred_default instead. This allows you to override categoriers at a map level, if desired.

--]]


	itemCategories =
	{
		-- ====================================================================
		-- BASIC CATEGORIES
		-- ====================================================================

		-- --------------------------------------------------------------------
		-- Static Spawners
		-- These are currently placed on the level to only spawn these items
		-- by the level designers
		-- --------------------------------------------------------------------

		-- --------------------------------------------------------------------
		-- FOR INTERNAL TESTING - DONT USE
		-- --------------------------------------------------------------------

		{
			category = "SpawnTest",
			classes =
			{
				{ class = "G18Pistol", contents="RandomM40A5Attachments", percent = 100 },
			},
		},

		{
			category = "RandomM40A5Attachments",
			group =
			{
				{ class = "9mmx10", percent = 100.0 },
			},
		},

		-- --------------------------------------------------------------------
		-- WEAPONS
		-- --------------------------------------------------------------------

		{
			category = "Map",
			classes =
			{
				{ category = "RandomFireStarter", percent = 15 },
				{ class = "Binoculars", percent = 15 },
				{ class = "Cb_radio", percent = 35 },
				{ category = "GridMap", percent = 15 },
				{ category = "Map", percent = 19, level_specific=1 },
				{ class = "TranslationCard", percent = 1 },
			},
		},

		{
			category = "GridMap",
			classes =
			{
				{ category = "GridMap", percent = 100, level_specific=1 },
			},
		},

		{
			category = "Map_default",
			classes =
			{
				{ class = "Map", percent = 100 },
			},
		},

		{
			category = "Map_canyonlands",
			classes =
			{
				{ class = "Map_canyonlands", percent = 100 },
			},
		},

		{
			category = "GridMap_default",
			classes =
			{
				{ class = "GridMap", percent = 100 },
			},
		},

		{
			category = "GridMap_canyonlands",
			classes =
			{
				{ class = "GridMap_canyonlands", percent = 100 },
			},
		},

		-- A random epic spawn for hard to reach areas. Use sparingly.
		{
			category = "RandomEpicWeapon",
			classes =
			{
				{ category = "Mk18ReaverWithMagazines", percent = 5 },
				{ category = "AA12WithMagazines", percent = 5 },
				{ category = "AKMGoldWithMagazines", percent = 5 },
				{ category = "ColtPythonGrimeyRickWithRounds", percent = 5 },
				{ class = "AxePatrick", percent = 10 },
				{ class = "BaseballBatHerMajesty", percent = 10 },
				{ class = "KatanaBlackWidow", percent = 10 },
			},
		},
		


		{
			category = "RandomFlashlight",
			classes =
			{
				{ class = "Flashlight", percent = 1 },
				{ class = "FlashlightMounted", percent = 15 },
				{ class = "Headlamp", percent = 19 },
				{ class = "HeadlampRed", percent = 5 },
				{ class = "Maglite", percent = 25 },
				{ class = "MagliteSmall", percent = 35 },
			},
		},
		
		{
			category = "RandomCraftedTools",
			classes =
			{
				{ class = "CraftedHammer", percent = 33 },
				{ class = "CraftedHatchet", percent = 34 },
				{ class = "CraftedPickaxe", percent = 33 },
			},
		},

		{
			category = "RandomCraftedWeapons",
			classes =
			{
				{ category = "CraftedBowWithMagazines", percent = 17 },
				{ class = "CraftedPistol", percent = 17 },
				{ class = "CraftedRifleLong", percent = 10 },
				{ class = "CraftedSMG", percent = 5 },
				{ class = "CraftedLongPistol", percent = 12 },
				{ class = "CraftedPistol556", percent = 9 },
				{ class = "CraftedRifle9mm", percent = 5 },
				{ class = "CraftedShortRifle556", percent = 5 },
				{ class = "CraftedShortShotgun", percent = 10 },
				{ class = "CraftedShotgun", percent = 10 },
			},
		},

		-- --------------------------------------------------------------------
		-- ATTACHMENTS
		-- --------------------------------------------------------------------

		-- --------------------------------------------------------------------
		-- THROWABLES
		-- --------------------------------------------------------------------

		-- --------------------------------------------------------------------
		-- TENT CONTENTS
		-- See tent's XML item file - loot_item_category
		-- --------------------------------------------------------------------

		{
			category = "RandomTentContents",
			classes =
			{
				-- Can add all kinds of stuff to this category - clothes/weapons/etc
				{category = "Map", percent = 9 },
				{category = "RandomConsumable", percent = 74, min = 1, max = 2 },
				{category = "RandomCraftedTools", percent = 11, min = 1, max = 2 },
				{category = "RandomMedical", percent = 2 },
				{category = "RandomCrafting", percent = 1 },
				{category = "RandomAccessory", percent = 2 },
			},
		},

		-- --------------------------------------------------------------------
		-- VEHICLE CONTENTS
		-- See VehicleSpawnerManager.lua
		-- --------------------------------------------------------------------

		{
			category = "RandomTowcarContents",
			classes =
			{
				{category = "Map", percent = 10 },
				{class = "CarBattery", percent = 10 },
				{class = "DriveBelt", percent = 10 },
				{class = "SparkPlugs", percent = 10 },
				{class = "Wheel", percent = 15, min = 1, max = 4 },
			},
		},

		{
			category = "RandomF100TruckContents",
			classes =
			{
				{category = "Map", percent = 4 },
				{category = "RandomAmmo", percent = 4 },
				{category = "RandomCargoPants", percent = 4 },
				{category = "RandomCraftedTools", percent = 2 },
				{category = "RandomConsumable", percent = 10 },
				{category = "RandomIncapacition", percent = 4 },
				{category = "RandomRanged", percent = 5 },
				{class = "CarBattery", percent = 10 },
				{class = "DriveBelt", percent = 10 },
				{class = "SparkPlugs", percent = 10 },
				{class = "Wheel", percent = 15, min = 1, max = 4 },
				{ class = "AmcoinLedger", percent = 2 },
			},
		},

		{
			category = "RandomFishingBoatContents",
			classes =
			{
				{category = "RandomAlcohol", percent = 25, min = 1, max = 3 },
				{category = "RandomClothes", percent = 25 },
				{category = "RandomFlashlight", percent = 25 },
				{category = "RandomHat", percent = 25 },
			},
		},

		{
			-- We spawn quadbikes as a group so they will have more items because of their 6 hour decay
			category = "RandomQuadBikeContents",
			group =
			{
				{class = "CarBattery", percent = 50 },
				{class = "DriveBelt", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
				{class = "Wheel", percent = 100, min = 1, max = 4 },
			},
		},

		{
			-- We spawn jetskis as a group so they will have more items because of their 6 hour decay
			category = "RandomJetskiContents",
			group =
			{
				{class = "CarBattery", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
			},
		},

		{
			-- We spawn tractors as a group so they will have more items because of their 6 hour decay
			category = "RandomTractorContents",
			group =
			{
				{class = "CarBattery", percent = 50 },
				{class = "DriveBelt", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
				{class = "Wheel", percent = 100, min = 1, max = 4 },
				{class = "TowCable", percent = 50 },
			},
		},

		{
			category = "RandomTruck5TonContents",
			classes =
			{
				{category = "RandomAccessory", percent = 2 },
				{category = "RandomAmmo", percent = 5 },
				{category = "RandomCamoFace", percent = 5 },
				{category = "RandomCamoGloves", percent = 5 },
				{category = "RandomCamoHats", percent = 5 },
				{category = "RandomMilitaryItems", percent = 3 },
				{category = "RandomRanged", percent = 5 },
				{class = "CarBattery", percent = 5 },
				{class = "DriveBelt", percent = 5 },
				{class = "SparkPlugs", percent = 5 },
				{class = "Wheel", percent = 10, min = 1, max = 6 },
			},
		},

		{
			category = "RandomPartyBusContents",
			classes =
			{
				{category = "Map", percent = 10 },
				{category = "RandomClothes", percent = 3 },
				{category = "RandomFlashlight", percent = 5 },
				{category = "RandomConsumable", percent = 20 },
				{category = "RandomMaintenance", percent = 1 },
				{category = "RandomMedical", percent = 10 },
				{class = "CarBattery", percent = 10 },
				{class = "DriveBelt", percent = 10 },
				{class = "SparkPlugs", percent = 10 },
				{class = "Wheel", percent = 15, min = 1, max = 4 },
			},
		},

		{
			category = "RandomPoliceSedanSlot",
			classes =
			{
				{category = "Map", percent = 5 },
				{category = "RandomFlashlight", percent = 5 },
				{category = "RandomConsumable", percent = 14 },
				{category = "RandomIncapacition", percent = 9 },
				{category = "RandomMedical", percent = 10 },
				{category = "RandomPoliceItems", percent = 20 },
				{class = "CarBattery", percent = 5 },
				{class = "DriveBelt", percent = 5 },
				{class = "SparkPlugs", percent = 5 },
				{class = "Wheel", percent = 20 },
				{ class = "AmcoinLedger", percent = 2 },
			},
		},

		{
			category = "RandomPoliceSedanContents",
			group =
			{
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
			},
		},

		-- --------------------------------------------------------------------
		-- AI CONTENTS/LOOT
		-- See AI's XX_x.lua files - esLootItemCategory property
		-- --------------------------------------------------------------------

		-- Animals
		{
			category = "RandomChickenLoot",
			group =
			{
				{ class = "ChickenRaw" },
				{ class = "AnimalFat", percent = 25 },
				{ class = "AnimalGut", percent = 25 },
			},
		},

		{
			category = "RandomPigLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "HamRaw", min = 2, max = 4 },
			},
		},

		-- AI
		{
			category = "RandomMutantLoot",
			group =
			{
				{ category = "Map", percent = 10 },
				{ class = "AmcoinLedger", percent = 15, min = 1, max = 3},
				{ category = "RandomConsumable", percent = 20 },
				--{ category = "RandomConsumable", percent = 20 },-- disabled for easter event
				{category = "RandomAccessory", percent = 7 },
				{ category = "RandomEggs", percent = 10 },
			},
		},

		{
			category = "RandomBearLoot",
			group =
			{
				{ class = "AnimalGut" },
				{ class = "AnimalFat", min = 4, max = 5 },
				{ class = "BearMeatRaw", min = 5, max = 6, },
				{ class = "BearPelt" },
			},
		},

		{
			category = "RandomBruteLoot",
			group =
			{
				--{ category = "RandomCraftingGuide", percent = 40 },-- commented out for easter event
				{ category = "RandomAmmo", percent = 10 },
				--{ category = "RandomGnome", percent = 20 }, -- commented out for easter event
				--{ category = "RandomMushroom", percent = 50 },-- commented out for easter event
				{ class = "AmcoinLedger", percent = 20, min = 1, max = 5},
				{category = "RandomAccessory", percent = 30 },
				{category = "RandomArmorTier2", percent = 25 },
				{category = "RandomEggs", percent = 25 },
				--{ class = "HalloweenBagBrute", percent = 30 }, -- halloween event.
				--{ class = "ChristmasPresentRare", percent = 30 },-- Christmas event
			},
		},

		{
			category = "RandomDeerLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut", min = 1, max = 2 },
				{ class = "DeerMeatSteakRaw", min = 3, max = 4 },
				{ class = "DeerPelt" },
			},
		},

		{
			category = "RandomHumanSpiderLoot",
			group =
			{
				{ category = "RandomCraftingGuide", percent = 25 },
				{ class = "AmcoinLedger", percent = 20, min = 1, max = 5},
				--{ category = "RandomConsumable", percent = 100 },-- disabled for easter event
				{ category = "RandomAmmo", percent = 100 },
				{category = "RandomAccessory", percent = 40 },
				{category = "RandomArmorTier3", percent = 20 },
				{category = "RandomEggs", percent = 25 },
				--{ class = "HalloweenBagSpider", percent = 30 },-- Halloween event
				--{ class = "ChristmasPresentRare", percent = 30 },-- Christmas event
			},
		},

		{
			category = "RandomWolfLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "WolfMeatSteakRaw", min = 2, max = 3 },
				{ class = "WolfPelt" },
			},
		},

		{
			category = "RandomRamLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "RamMeatSteakRaw", min = 1, max = 2 },
			},
		},
		
		{
			category = "RandomDonkeyLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "DonkeyMeatSteakRaw", min = 1, max = 2 },
			},
		},

		{
			category = "RandomGiantScorpionLoot",
			group =
			{
				{ class = "AnimalFat" },
				{ class = "AnimalGut" },
				{ class = "ScorpionMeatSteakRaw" },
			},
		},

		-- --------------------------------------------------------------------
		-- ITEM CONTENTS
		-- --------------------------------------------------------------------

		{
			category = "RandomBackpackContents",
			classes =
			{
				--{ category = "RandomChristmasPresent", percent = 3 }, Christmas event
				--{ category = "halloweenBagCommon", percent = 3 },-- Halloween event
				{ category = "Map", percent = 2 },
				{ category = "RandomEggs", percent = 3 },
				{ category = "RandomCraftingGuide", percent = 2 },
				{ category = "RandomClothes", percent = 3 },
				{ category = "RandomCrafting", percent = 1 },
				{ category = "RandomFlashlight", percent = 1 },
				{ category = "RandomConsumable", percent = 8, min = 1, max = 2 },
				{ category = "RandomMaintenance", percent = 2 },
				{ category = "RandomMedical", percent = 2 },
				{category = "RandomArmorTier2", percent = 2 },
				{class = "AmcoinLedger", percent = 3 },
			},
		},

		{
			category = "RandomTorsoContents",
			classes =
			{
				{category = "Map", percent = 2 },
				{category = "RandomConsumable", percent = 5 },
				{category = "RandomMedical", percent = 3 },
			},
		},

		{
			category = "RandomWaistContents",
			classes =
			{
				{category = "RandomConsumable", percent = 6 },
				{category = "RandomFlashlight", percent = 1 },
				{class = "AmcoinLedger", percent = 3 },
			},
		},

		{
			category = "RandomLegsContents",
			classes =
			{
				{category = "RandomConsumable", percent = 8 },
				{category = "RandomFlashlight", percent = 1 },
				{category = "RandomMedical", percent = 1 },
				{ class = "AmcoinLedger", percent = 3 },
			},
		},

		-- --------------------------------------------------------------------
		-- POLICE SECTION
		-- --------------------------------------------------------------------
		-- Special Police Spawner
		{
			category = "RandomPoliceItems", 
			classes =
			{
				{category = "HandcuffsWithKey", percent = 6 },
				{category = "RandomPoliceClothing", percent = 14 },
				{category = "RandomAccessory", percent = 8 },
				{category = "RandomPoliceWeaponWithMagazines", percent = 9 },
				{class = "Cb_radio", percent = 10 },
				{class = "FlashbangPickup", percent = 7 },
				{class = "GrenadeGasTearPickup", percent = 6 },
				{class = "GrenadeGasSleepPickup", percent = 6 },
				{class = "MagliteSmall", percent = 8 },
				{class = "Megaphone", percent = 7 },
				{class = "PoliceBaton", percent = 5 },
				{ class = "StunBaton", percent = 3 },
				{ class = "AmcoinLedger", percent = 4 },
				{ category = "RandomPoliceArmor", percent = 2 },
				
			},
		},

		{
			category = "RandomPoliceClothing",
			classes =
			{
				{ category = "RandomArmorTier2", percent = 3 },
				{ class = "CargoPantsBlack", percent = 10 },
				{ class = "flexcap_policefrontback_black", percent = 10 },
				{ class = "flexcap_policefrontback_blue", percent = 10 },
				{ class = "flexcap_policefrontback_camo1", percent = 10 },
				{ class = "flexcap_policefrontback_camo2", percent = 10 },
				{ class = "flexcap_policefrontback_camo3", percent = 10 },
				{ class = "flexcap_policefrontback_camo4", percent = 10 },
				{ class = "TshirtPoliceBlack", percent = 10 },
				{ class = "TshirtPoliceBlue", percent = 10 },
			},
		},

		{
			category = "RandomPoliceWeaponWithMagazines",
			classes =
			{
				{ category = "G18PistolWithMagazines", percent = 7 },
				{ category = "Shotgun870TacticalWithMagazines", percent = 8 },
				{ category = "TranquilizerGunWithDarts", percent = 5 },
				{ category = "MP5WithMagazines", percent = 5 },
				{ category = "RandomAccessory", percent = 8 },
				{ category = "PX4WithMagazines", percent = 5 },
				{ category = "AA12WithMagazines", percent = 10 },
				{ category = "AUMP45WithMagazines", percent = 5 },
				{ category = "R90WithMagazines", percent = 10 },
				{ category = "AkValWithMagazines", percent = 5 },
				{ category = "SAS12WithRounds", percent = 10 },
				{ category = "AK5DWithMagazines", percent = 10 },
				{ category = "MAK10WithRounds", percent = 5 },
				{ category = "M97WithRounds", percent = 2 },
				
			},
		},

		-- --------------------------------------------------------------------
		-- MILITARY SECTION
		-- --------------------------------------------------------------------
		-- Special Military Spawner
		{
			category = "RandomMilitaryItems", 
			classes =
			{
				{ category = "RandomAccessory", percent = 2 },
				{ category = "RandomCraftingGuide", percent = 1 },
				{ category = "RandomGhillieSuit", percent = 1 },
				{ category = "RandomHazmatSuit", percent = 2 },
				{ category = "RandomMilitaryClothing", percent = 34 },
				{ category = "RandomMilitaryGrenade", percent = 15 },
				{ category = "RandomMilitaryWeaponWithMagazines", percent = 12 },
				{ class = "Binoculars", percent = 2 },
				{ class = "C4Bricks", percent = 0.1 },
				{ class = "Cb_radio", percent = 5 },
				{ class = "GasMask", percent = 1 },
				{ category = "GridMap_level", percent = 3 },
				{ class = "Maglite", percent = 3 },
				{ class = "MagliteSmall", percent = 2 },
				{ class = "MilitaryCanteenPlastic", percent = 4 },
				{ class = "MilitaryCanteenMetal", percent = 2 },
				{ class = "MRE", percent = 3 },
				{ class = "SurvivalKnife", percent = 2.9 },
				{ class = "hesco_barrier", percent = 4 },
			},
		},

		{
			category = "RandomMilitaryClothing",
			classes =
			{
				{ category = "RandomArmorTier3", percent = 2 },
				{ category = "RandomArmorTier2", percent = 5 },
				{ category = "RandomArmorTier1", percent = 8 },
				{ category = "RandomCamoClothes", percent = 20 },
				{ category = "RandomMilitaryGloves", percent = 20 },
				{ category = "RandomMilitaryJacket", percent = 20 },
				{ category = "RandomMilitaryShoes", percent = 10 },
			},
		},

		{
			category = "RandomMilitaryWeaponWithMagazines",
			classes =
			{
				{ category = "RandomPoliceWeaponWithMagazines", percent = 29.5 },
				{ category = "M249WithMagazines", percent = .5 },
				{ category = "KrissVWithMagazines", percent = 5 },
				{ category = "M1911WithMagazines", percent = 20 },
				{ category = "M40A5WithMagazines", percent = 5 },
				{ category = "M16WithMagazines", percent = 18 },
				{ category = "AT15WithMagazines", percent = 17 },
				{ category = "M97WithRounds", percent = 2 },
			},
		},

		-- --------------------------------------------------------------------
		-- HUNTING SECTION
		-- --------------------------------------------------------------------
		-- Civilian Hunting Items Spawner
		{
			category = "RandomHuntingItems",
			classes =
			{
				{ category = "RandomHuntingWeapons", percent = 20 },
				{ category = "RandomHuntingClothing", percent = 19 },
				{ category = "RandomCraftingGuide", percent = 1 },
				{ class = "Cb_radio", percent = 20 },
				{ category = "Map", percent = 10 },
				{ class = "Binoculars", percent = 20 },
				{ class = "HuntingScope", percent = 10 },
			},
		},

		-- Civilian Hunting Weapons
		{
			category = "RandomHuntingWeapons",
			classes =
			{
				{ category = "Rem700WithRounds", percent = 25 },
				{ category = "Rem870WithRounds", percent = 25 },
				{ category = "Sako85WithRounds", percent = 20 },
				{ category = "CrossbowWithMagazines", percent = 25 },
				{ class = "HuntingKnife", percent = 5 },
			},
		},

		-- Civilian Hutning Clothing 
		-- camo1 is the duck type camo good for civilian use
		{
			category = "RandomHuntingClothing",
			classes =
			{
				{ class = "CargoPantsCamo1", percent = 25 },
				{ class = "WoolGlovesCamo1", percent = 10 },
				{ class = "CottonShirtBrown", percent = 20 },
				{ class = "RuggedPackCamo1", percent = 20 },
				{ class = "TshirtCamo1", percent = 25 },
			},
		},

		-- --------------------------------------------------------------------
		-- HOLIDAY/SEASONAL
		-- --------------------------------------------------------------------

		{
			category = "RandomChristmasPresent",
			classes =
			{
				{ class = "ChristmasPresentCommon1", percent = 50 },
				{ class = "ChristmasPresentCommon2", percent = 50 },
			},
		},
		
		{
			category = "halloweenBagCommon",
			classes =
			{
				{ class = "HalloweenBagMonster", percent = 50 },
				{ class = "HalloweenBagPumpkin", percent = 50 },
			},
		},

		-- BASE PARTS
		-- Used in presents and easter eggs
		{
			category = "ChristmasPresentCommon",
			classes =
			{
				{ class = "christmas_light_string", percent = 20 },
				{ class = "christmas_candle", percent = 10 },
				{ class = "christmas_gift_pile", percent = 20 },
				{ class = "christmas_rug_01", percent = 10 },
				{ class = "christmas_rug_02", percent = 10 },
				{ class = "SweaterChristmasGreen", percent = 8 },
				{ class = "SweaterChristmasRed", percent = 8 },
				{ class = "ChristmasHat", percent = 6 },
				{ class = "snowman_small", percent = 6 },
				{ class = "Peacemaker", percent = 2 },
			},
		},
		
		{
			category = "ChristmasPresentRare",
			classes =
			{
				{ class = "snowman", percent = 20 },
				{ class = "christmas_rug_03", percent = 20 },
				{ class = "SweaterChristmasGreen2", percent = 15 },
				{ class = "SweaterChristmasRed2", percent = 15 },
				{ class = "christmas_wreath", percent = 12 },
				{ class = "christmas_stocking", percent = 10 },
				{ class = "christmas_snowglobe", percent = 5 },
				{ class = "ScavengerHelmet", percent = 2 },
				{ class = "EggNog", percent = 0.5 },
				{ class = "GingerBreadMan", percent = 0.5 },
			},
		},
		
		{
			category = "RandomBpartPresent",
			classes =
			{
				{ class = "wood_watchtower", percent = 17 },
				{ class = "wood_watchtower_tire", percent = 17 },
				{ class = "wood_gate_lockable_3m_4m", percent = 17 },
				{ class = "wood_gatehouse", percent = 17 },
				{ class = "wood_crate_large_packed", percent = 16 },
				{ class = "wood_door_lockable_1m_2m", percent = 16 },
			},
		},

		{
			category = "RandomChristmasClothing",
			classes =
			{
				{ class = "ChristmasHat", percent = 20 },
				{ class = "SweaterChristmasGreen", percent = 20 },
				{ class = "SweaterChristmasGreen2", percent = 20 },
				{ class = "SweaterChristmasRed", percent = 20 },
				{ class = "SweaterChristmasRed2", percent = 20 },
			},
		},
		
		{
			category = "HalloweenBagCommonLoot",
			classes =
			{
				{ class = "jack_o_lantern", percent = 15 },
				{ class = "halloween_light_string", percent = 24.5 },
				{ class = "halloween_creepy_bunny", percent = 24.9 },
				{ class = "SkullMask", percent = 10 },
				{ class = "SkullMaskSilver", percent = 5 },
				{ class = "R90", percent = 5 },
				{ class = "AK74U", percent = 5 },
				{ class = "Mk18Reaver", percent = 0.5 },
				{ class = "Model1873", percent = 0.5 },
				{ class = "ScavengerShirt", percent = 9.6 },
			},
		},
		
		{
			category = "HalloweenBagRare",
			classes =
			{
				{ class = "jack_o_lantern", percent = 15 },
				{ class = "halloween_candle", percent = 24.9 },
				{ class = "halloween_creepy_bear", percent = 24.5 },
				{ class = "SkullMask", percent = 10 },
				{ class = "SkullMaskGold", percent = 5 },
				{ class = "R90", percent = 5 },
				{ class = "AKM", percent = 5 },
				{ class = "AKMGold", percent = 0.5 },
				{ class = "SpaceHelmet", percent = 0.5 },
				{ class = "ScavengerPants", percent = 9.6 },
			},
		},

		-- --------------------------------------------------------------------
		-- CLOTHING
		-- --------------------------------------------------------------------

		-- Back
		{
			category = "RuggedPack",
			classes =
			{
				{ class = "RuggedPack", contents="RandomBackpackContents", percent = 9 },
				{ class = "RuggedPackBlack", contents="RandomBackpackContents", percent = 9 },
				{ class = "RuggedPackBrown", contents="RandomBackpackContents", percent = 9 },
				{ class = "RuggedPackCamo1", contents="RandomBackpackContents", percent = 8 },
				{ class = "RuggedPackCamo2", contents="RandomBackpackContents", percent = 8 },
				{ class = "RuggedPackCamo3", contents="RandomBackpackContents", percent = 8 },
				{ class = "RuggedPackCamo4", contents="RandomBackpackContents", percent = 8 },
				{ class = "RuggedPackGreen", contents="RandomBackpackContents", percent = 9 },
				{ class = "RuggedPackGreenCamo1", contents="RandomBackpackContents", percent = 8 },
				{ class = "RuggedPackGreenCamo2", contents="RandomBackpackContents", percent = 8 },
				{ class = "RuggedPackGreenCamo3", contents="RandomBackpackContents", percent = 8 },
				{ class = "RuggedPackGreenCamo4", contents="RandomBackpackContents", percent = 8 },
			},
		},

		{
			category = "RandomRuggedPackAirPlane",
			classes =
			{
				{ class = "RuggedPack", contents="RandomBackpackAirPlaneContents", percent = 9 },
				{ class = "RuggedPackBlack", contents="RandomBackpackAirPlaneContents", percent = 9 },
				{ class = "RuggedPackBrown", contents="RandomBackpackAirPlaneContents", percent = 9 },
				{ class = "RuggedPackCamo1", contents="RandomBackpackAirPlaneContents", percent = 8 },
				{ class = "RuggedPackCamo2", contents="RandomBackpackAirPlaneContents", percent = 8 },
				{ class = "RuggedPackCamo3", contents="RandomBackpackAirPlaneContents", percent = 8 },
				{ class = "RuggedPackCamo4", contents="RandomBackpackAirPlaneContents", percent = 8 },
				{ class = "RuggedPackGreen", contents="RandomBackpackAirPlaneContents", percent = 9 },
				{ class = "RuggedPackGreenCamo1", contents="RandomBackpackAirPlaneContents", percent = 8 },
				{ class = "RuggedPackGreenCamo2", contents="RandomBackpackAirPlaneContents", percent = 8 },
				{ class = "RuggedPackGreenCamo3", contents="RandomBackpackAirPlaneContents", percent = 8 },
				{ class = "RuggedPackGreenCamo4", contents="RandomBackpackAirPlaneContents", percent = 8 },
			},
		},

		{
			category = "RandomRuckSack",
			classes =
			{
				{ class = "RuckSack", contents="RandomBackpackContents", percent = 100 },
			},
		},

		{
			category = "RandomRuckSackAirPlane",
			classes =
			{
				{ class = "RuckSack", contents="RandomBackpackAirPlaneContents", percent = 100 },
			},
		},

		{
			category = "RandomDuffelBag",
			classes =
			{
				{ class = "DuffelBag", contents="RandomBackpackContents", percent = 6 },
				{ class = "DuffelBagBlack", contents="RandomBackpackContents", percent = 6 },
				{ class = "DuffelBagGreen", contents="RandomBackpackContents", percent = 6 },
				{ class = "DuffelBagGreenCamo1", contents="RandomBackpackContents", percent = 6 },
				{ class = "DuffelBagGreenCamo2", contents="RandomBackpackContents", percent = 6 },
				{ class = "DuffelBagGreenCamo3", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagGreenCamo4", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagTanCamo1", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagTanCamo2", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagTanCamo3", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagTanCamo4", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo1", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo2", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo3", contents="RandomBackpackContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo4", contents="RandomBackpackContents", percent = 7 },
			},
		},

		{
			category = "RandomDuffelBagAirPlane",
			classes =
			{
				{ class = "DuffelBag", contents="RandomBackpackAirPlaneContents", percent = 6 },
				{ class = "DuffelBagBlack", contents="RandomBackpackAirPlaneContents", percent = 6 },
				{ class = "DuffelBagGreen", contents="RandomBackpackAirPlaneContents", percent = 6 },
				{ class = "DuffelBagGreenCamo1", contents="RandomBackpackAirPlaneContents", percent = 6 },
				{ class = "DuffelBagGreenCamo2", contents="RandomBackpackAirPlaneContents", percent = 6 },
				{ class = "DuffelBagGreenCamo3", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagGreenCamo4", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagTanCamo1", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagTanCamo2", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagTanCamo3", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagTanCamo4", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo1", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo2", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo3", contents="RandomBackpackAirPlaneContents", percent = 7 },
				{ class = "DuffelBagUrbanCamo4", contents="RandomBackpackAirPlaneContents", percent = 7 },
			},
		},

		{
			category = "RandomStowPack",
			classes =
			{
				{ class = "StowPackBlack", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackBlue", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackGreen", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackOrange", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackPink", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackPurple", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackRed", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackWhite", contents="RandomBackpackContents", percent = 11 },
				{ class = "StowPackYellow", contents="RandomBackpackContents", percent = 12 },
			},
		},

		-- Face
		{
			category = "RandomBandana",
			classes =
			{
				{ class = "BandanaBlack", percent = 8 },
				{ class = "BandanaBrown", percent = 8 },
				{ class = "BandanaCamo1", percent = 9 },
				{ class = "BandanaCamo2", percent = 9 },
				{ class = "BandanaCamo3", percent = 9 },
				{ class = "BandanaCamo4", percent = 9 },
				{ class = "BandanaGray", percent = 8 },
				{ class = "BandanaGreen", percent = 8 },
				{ class = "BandanaKhaki", percent = 8 },
				{ class = "BandanaOrange", percent = 8 },
				{ class = "BandanaPink", percent = 8 },
				{ class = "BandanaRed", percent = 8 },
			},
		},

		{
			category = "RandomBalaclava",
			classes =
			{
				{ class = "BalaclavaBlack", percent = 20 },
				{ class = "BalaclavaGray", percent = 20 },
				{ class = "BalaclavaGreen", percent = 20 },
				{ class = "BalaclavaPink", percent = 20 },
				{ class = "BalaclavaYellow", percent = 20 },
			},
		},


		-- Feet
		{
			category = "RandomCombatBoots",
			classes =
			{
				{ class = "CombatBootsBlack", percent = 34 },
				{ class = "CombatBootsCamo", percent = 33 },
				{ class = "CombatBootsTan", percent = 33 },
			},
		},

		{
			category = "RandomHitops",
			classes =
			{
				{ class = "HitopsBlack", percent = 16 },
				{ class = "HitopsBlue", percent = 14 },
				{ class = "HitopsGreen", percent = 14 },
				{ class = "HitopsPink", percent = 14 },
				{ class = "HitopsPurple", percent = 14 },
				{ class = "HitopsRed", percent = 14 },
				{ class = "HitopsYellow", percent = 14 },
			},
		},

		{
			category = "RandomSneakers",
			classes =
			{
				{ class = "Sneakers", percent = 6.25 },
				{ class = "SneakersBlack", percent = 6.25 },
				{ class = "SneakersBlackBlue", percent = 6.25 },
				{ class = "SneakersBlackGreen", percent = 6.25 },
				{ class = "SneakersBlackPink", percent = 6.25 },
				{ class = "SneakersBlackRed", percent = 6.25 },
				{ class = "SneakersBlueBlack", percent = 6.25 },
				{ class = "SneakersBrown", percent = 6.25 },
				{ class = "SneakersGreenBlack", percent = 6.25 },
				{ class = "SneakersPinkBlack", percent = 6.25 },
				{ class = "SneakersRedBlack", percent = 6.25 },
				{ class = "SneakersSilver", percent = 6.25 },
				{ class = "SneakersWhite", percent = 6.25 },
				{ class = "SneakersWhiteBlue", percent = 6.25 },
				{ class = "SneakersWhiteGreen", percent = 6.25 },
				{ class = "SneakersWhitePink", percent = 6.25 },
			},
		},

		{
			category = "RandomSteeltoedBoots",
			classes =
			{
				{ class = "SteeltoedBootsBlack", percent = 50 },
				{ class = "SteeltoedBootsBrown", percent = 50 },
			},
		},


		-- Hands
		{
			category = "RandomMilitaryGloves",
			classes =
			{
				{ class = "MilitaryGlovesBlack", percent = 25 },
				{ class = "MilitaryGlovesBrown", percent = 25 },
				{ class = "MilitaryGlovesGreen", percent = 25 },
				{ class = "MilitaryGloves", percent = 25 },
			},
		},

		{
			category = "RandomWoolGloves",
			classes =
			{
				{ class = "WoolGlovesBlack", percent = 15 },
				{ class = "WoolGlovesBlue", percent = 20 },
				{ class = "WoolGlovesBrown", percent = 20 },
				{ class = "WoolGlovesGreen", percent = 10 },
				{ class = "WoolGlovesCamo1", percent = 5 },
				{ class = "WoolGlovesCamo2", percent = 5 },
				{ class = "WoolGlovesCamo3", percent = 5 },
				{ class = "WoolGlovesCamo4", percent = 5 },
				{ class = "WoolGlovesWhite", percent = 15 },
			},
		},


		-- Hat
		{
			category = "BandanaHat",
			classes =
			{
				{ class = "BandanaHat", percent = 20 },
				{ class = "BandanaHatCamo1", percent = 20 },
				{ class = "BandanaHatCamo2", percent = 20 },
				{ class = "BandanaHatCamo3", percent = 20 },
				{ class = "BandanaHatCamo4", percent = 20 },
			},
		},

		{
			category = "RandomCowboyHat",
			classes =
			{
				{ class = "CowboyHat", percent = 34 },
				{ class = "CowboyHatLeather", percent = 33 },
				{ class = "CowboyHatStraw", percent = 33 },
			},
		},

		{
			category = "RandomMilitaryHelmet",
			classes = 
			{
				{ class = "MilitaryHelmetGreen", percent = 8 },
				{ class = "MilitaryHelmetGreenCamo1", percent = 7 },
				{ class = "MilitaryHelmetGreenCamo2", percent = 7 },
				{ class = "MilitaryHelmetGreenCamo3", percent = 7 },
				{ class = "MilitaryHelmetGreenCamo4", percent = 7 },
				{ class = "MilitaryHelmetTan", percent = 8 },
				{ class = "MilitaryHelmetTanCamo1", percent = 7 },
				{ class = "MilitaryHelmetTanCamo2", percent = 7 },
				{ class = "MilitaryHelmetTanCamo3", percent = 7 },
				{ class = "MilitaryHelmetTanCamo4", percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo1", percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo2", percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo3", percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo4", percent = 7 },
			},
		},
		
		{
			category = "RandomArmorTier3",
			classes = 
			{
				{ class = "MilitaryHelmetGreen", percent = 6 },
				{ class = "MilitaryHelmetGreenCamo1", percent = 5 },
				{ class = "MilitaryHelmetGreenCamo2", percent = 6 },
				{ class = "MilitaryHelmetGreenCamo3", percent = 5 },
				{ class = "MilitaryHelmetGreenCamo4", percent = 6 },
				{ class = "MilitaryHelmetTan", percent = 6 },
				{ class = "MilitaryHelmetTanCamo1", percent = 5 },
				{ class = "MilitaryHelmetTanCamo2", percent = 6 },
				{ class = "MilitaryHelmetTanCamo3", percent = 6 },
				{ class = "MilitaryHelmetTanCamo4", percent = 5 },
				{ class = "MilitaryHelmetUrbanCamo1", percent = 6 },
				{ class = "MilitaryHelmetUrbanCamo2", percent = 5 },
				{ class = "MilitaryHelmetUrbanCamo3", percent = 6 },
				{ class = "MilitaryHelmetUrbanCamo4", percent = 5 },
				{ class = "FlakVestGreen", percent = 6 },
				{ class = "FlakVestGreenCamo1", percent = 5 },
				{ class = "FlakVestTan", percent = 6 },
				{ class = "FlakVestTanCamo1", percent = 5 },
			},
		},
		
		{
			category = "RandomArmorTier2",
			classes = 
			{
				{ class = "PoliceVestBlack", percent = 33 },
				{ class = "PoliceVestBlue", percent = 33 },
				{ class = "SwatHelmet", percent = 34 },
			},
		},
		
		{
			category = "RandomArmorTier1",
			classes = 
			{
				{ class = "FootballHelmet", percent = 2.5 },
				{ class = "FootballHelmetAmerica", percent = 2.5 },
				{ class = "FootballHelmetBlack", percent = 2.5 },
				{ class = "FootballHelmetBlue", percent = 2.5 },
				{ class = "FootballHelmetFabulous", percent = 2.5 },
				{ class = "FootballHelmetGold", percent = 2.5 },
				{ class = "FootballHelmetGreen", percent = 2.5 },
				{ class = "FootballHelmetRed", percent = 2.5 },
				{ class = "FootballHelmetStripedBlack", percent = 2.5 },
				{ class = "FootballHelmetStripedBlue", percent = 2.5 },
				{ class = "FootballHelmetStripedGreen", percent = 2.5 },
				{ class = "FootballHelmetStripedRed", percent = 2.5 },
				{ class = "FootballHelmetStripedTeal", percent = 2.5 },
				{ class = "FootballHelmetStripedYellow", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedBlack", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedBlue", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedGreen", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedRed", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedTeal", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedYellow", percent = 2.5 },
				{ class = "FootballHelmetYellow", percent = 2.5 },
				{ class = "MotorcycleHelmetCarbon", percent = 2.5 },
				{ class = "MotorcycleHelmetGold", percent = 2.5 },
				{ class = "MotorcycleHelmetWhite", percent = 2.5 },
				{ class = "FootballPads", percent = 2.5 },
				{ class = "TacticalVestBlack", percent = 2.5 },
				{ class = "TacticalVestGreen", percent = 2.5 },
				{ class = "TacticalVestGreenCamo1", percent = 2.5 },
				{ class = "TacticalVestGreenCamo2", percent = 2.5 },
				{ class = "TacticalVestGreenCamo3", percent = 2.5 },
				{ class = "TacticalVestGreenCamo4", percent = 2.5 },
				{ class = "TacticalVestTan", percent = 2.5 },
				{ class = "TacticalVestTanCamo1", percent = 2.5 },
				{ class = "TacticalVestTanCamo2", percent = 2.5 },
				{ class = "TacticalVestTanCamo3", percent = 2.5 },
				{ class = "TacticalVestTanCamo4", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo1", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo2", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo3", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo4", percent = 2.5 },
			},
		},
		
		{
			category = "RandomCivilianHelmet",
			classes = 
			{
				{ class = "FootballHelmet", percent = 3 },
				{ class = "FootballHelmetAmerica", percent = 3 },
				{ class = "FootballHelmetBlack", percent = 3 },
				{ class = "FootballHelmetBlue", percent = 4 },
				{ class = "FootballHelmetFabulous", percent = 3 },
				{ class = "FootballHelmetGold", percent = 3 },
				{ class = "FootballHelmetGreen", percent = 4 },
				{ class = "FootballHelmetRed", percent = 3 },
				{ class = "FootballHelmetStripedBlack", percent = 3 },
				{ class = "FootballHelmetStripedBlue", percent = 3 },
				{ class = "FootballHelmetStripedGreen", percent = 4 },
				{ class = "FootballHelmetStripedRed", percent = 3 },
				{ class = "FootballHelmetStripedTeal", percent = 3 },
				{ class = "FootballHelmetStripedYellow", percent = 4 },
				{ class = "FootballHelmetWhiteStripedBlack", percent = 3 },
				{ class = "FootballHelmetWhiteStripedBlue", percent = 3 },
				{ class = "FootballHelmetWhiteStripedGreen", percent = 3 },
				{ class = "FootballHelmetWhiteStripedRed", percent = 3 },
				{ class = "FootballHelmetWhiteStripedTeal", percent = 3 },
				{ class = "FootballHelmetWhiteStripedYellow", percent = 3 },
				{ class = "FootballHelmetYellow", percent = 3 },
				{ class = "BikeHelmetBlack", percent = 3 },
				{ class = "BikeHelmetBlue", percent = 3 },
				{ class = "BikeHelmetGreen", percent = 3 },
				{ class = "BikeHelmetPink", percent = 3 },
				{ class = "BikeHelmetPurple", percent = 3 },
				{ class = "BikeHelmetRed", percent = 3 },
				{ class = "BikeHelmetWhite", percent = 3 },
				{ class = "BikeHelmetYellow", percent = 3 },
				{ class = "MotorcycleHelmetCarbon", percent = 3 },
				{ class = "MotorcycleHelmetGold", percent = 3 },
				{ class = "MotorcycleHelmetWhite", percent = 3 },	
			},
		},

		-- Legs
		{
			category = "RandomBlueJeans2",
			classes =
			{
				{ class = "BlueJeans", contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2", contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2Brown", contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2Green", contents="RandomLegsContents", percent = 25 },
			},
		},

		{
			category = "RandomCargoPants",
			classes =
			{
				{ class = "CargoPantsBlack", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsCamo1", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsCamo2", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsCamo3", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsCamo4", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoPantsGreen", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsGreenCamo1", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsGreenCamo2", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsGreenCamo3", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsGreenCamo4", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoPantsTan", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsUrbanCamo1", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoPantsUrbanCamo2", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoPantsUrbanCamo3", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoPantsUrbanCamo4", contents="RandomLegsContents", percent = 6 },
			},
		},

		{
			category = "RandomCargoShorts",
			classes =
			{
				{ class = "CargoShortsBlack", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsBlue", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsBrightBlue", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsBrightGreen", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsBrightPink", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsBrightRed", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsBrown", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsCamo1", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoShortsCamo2", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoShortsCamo3", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsCamo4", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoShortsDarkGrey", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsGreen", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsGrey", contents="RandomLegsContents", percent = 7 },
				{ class = "CargoShortsTan", contents="RandomLegsContents", percent = 6 },
				{ class = "CargoShortsYellow", contents="RandomLegsContents", percent = 6 },
			},
		},

		{
			category = "RandomTrackPants",
			classes =
			{
				{ class = "TrackPantsBlack", percent = 20 },
				{ class = "TrackPantsBlue", percent = 20 },
				{ class = "TrackPantsGreen", percent = 20 },
				{ class = "TrackPantsOrange", percent = 20 },
				{ class = "TrackPantsPink", percent = 10 },
				{ class = "TrackPantsYellow", percent = 10 },
			},
		},

		{
			category = "RandomWandererPants",
			classes =
			{
				{ class = "WandererPantsBlack", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsBlue", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsBrown", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsGreen", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsRed", contents="RandomLegsContents", percent = 16 },
				{ class = "WandererPantsTan", contents="RandomLegsContents", percent = 16 },
			},
		},


		-- Torso
		{
			category = "RandomButtonUpShirt",
			classes = 
			{
				{ class = "ButtonUpShirtBlack", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackDots", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlue", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueDots", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueHawaiian", contents="RandomTorsoContents", percent = 4},
				{ class = "ButtonUpShirtBlueStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreenChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreenStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGrey", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyDots", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreen", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenHawaiian", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGrey", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreyChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreyStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPink", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPinkChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPinkStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurple", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleHawaiian", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRed", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedHawaiian", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedDots", contents="RandomTorsoContents", percent = 3},
			},
		},

		{
			category = "RandomCottonShirt",
			classes =
			{
				{ class = "CottonShirtBlue", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtBrown", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtGreen", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtGrey", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtRed", contents="RandomTorsoContents", percent = 16 },
				{ class = "CottonShirtTan", contents="RandomTorsoContents", percent = 16 },
			},
		},

		{
			category = "RandomHazmatSuit",
			classes = 
			{
				{class = "HazmatSuitBlue", percent = 9 },
				{class = "HazmatSuitGreen", percent = 9 },
				{class = "HazmatSuitPink", percent = 5 },
				{class = "HazmatSuitOrange", percent = 9 },
				{class = "HazmatSuitWhite", percent = 9 },
				{class = "HazmatSuitYellow", percent = 9 },
				{class = "HazmatMask", percent = 25 },
				{class = "GasCanisterPack", percent = 25 },
			}	
		},

		{
			category = "RandomHoodie",
			classes = 
			{
				{class = "Hoodie", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlackGreyDesign1", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlackWhiteDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlueBlackDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlueDesign2", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieBlueWhiteDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieCapitalMunch", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieEagle", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreenBlackDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieGreenDesign2", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreenWhiteDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieGrey", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreyDarkGreyDesign1", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieOrangeBlackDesign4", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePinkDesign2", contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixel", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelBlackGreyDesign5", contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixelBlueBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreenBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyBlueDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyDesign5", contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixelGreyGreenDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyOrangeDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyRedDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelOrangeBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelRedBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedBlackDesign4", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedDesign2", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedWhiteDesign4", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieSerk", contents="RandomTorsoContents", percent = 3},
			},
		},

		{
			category = "RandomLeatherJacket",
			classes =
			{
				{ class = "LeatherJacketBrown", contents="RandomTorsoContents", percent = 25},
				{ class = "LeatherJacketBlack", contents="RandomTorsoContents", percent = 25},
				{ class = "LeatherJacketYellow", contents="RandomTorsoContents", percent = 25},
				{ class = "LeatherJacketRed", contents="RandomTorsoContents", percent = 25},
			},
		},

		{
			category = "RandomMilitaryJacket",
			classes = 
			{
				{ class = "MilitaryJacketBlack", contents="RandomTorsoContents", percent = 6 },
				{ class = "MilitaryJacketGreen", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketGreenCamo1", contents="RandomTorsoContents", percent = 6 },
				{ class = "MilitaryJacketGreenCamo2", contents="RandomTorsoContents", percent = 6 },
				{ class = "MilitaryJacketGreenCamo3", contents="RandomTorsoContents", percent = 6 },
				{ class = "MilitaryJacketGreenCamo4", contents="RandomTorsoContents", percent = 6 },
				{ class = "MilitaryJacketTan", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketTanCamo1", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketTanCamo2", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketTanCamo3", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketTanCamo4", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo1", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo2", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo3", contents="RandomTorsoContents", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo4", contents="RandomTorsoContents", percent = 7 },
			},
		},

		{
			category = "RandomPuffyJacket",
			classes =
			{
				{ class = "PuffyJacketEaster", contents="RandomTorsoContents", percent = 0.5 },
				{ class = "PuffyJacketGold", contents="RandomTorsoContents", percent = 1.0 },
				{ class = "PuffyJacketSilver", contents="RandomTorsoContents", percent = 1 },
				{ class = "PuffyJacketAmerica", contents="RandomTorsoContents", percent = 1 },
				{ class = "PuffyJacketCanada", contents="RandomTorsoContents", percent = 1 },
				{ class = "PuffyJacketCamo1", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketCamo2", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketCamo3", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketWhiteCamo1", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketBlack", contents="RandomTorsoContents", percent = 4.5 },
				{ class = "PuffyJacketBlueWhite", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGreenWhite", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGrey", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGreyBlack", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGreyBlack2", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketKaki", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketOrangeGreen", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketOrangeTeal", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketOrangeWhite", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketPinkWhite", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketPurpleFushia", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketRedBlue", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketRedWhite", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketWhite", contents="RandomTorsoContents", percent = 6 },
			},
		},

		{
			category = "RandomRainJacket",
			classes =
			{
				{ class = "RainJacketBlack", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketBlue", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketBlueGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo1", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo2", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo3", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketDarkGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreen", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreenGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreyBlack", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketKaki", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketLightDarkGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketMarine", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketOrangeBlue", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketPinkPurple", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRed", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRedBlue", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRedGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketYellow", contents="RandomTorsoContents", percent = 5},
				
			},
		},

		-- Ghillie Suits

		{
			category = "RandomGhillieSuit",
			classes = 
			{
				{ category = "RandomGhillieSuitParts", percent=99.6 },
				{ category = "GhillieSuit1Full", percent=0.1 },
				{ category = "GhillieSuit2Full", percent=0.1 },
				{ category = "GhillieSuit3Full", percent=0.1 },
				{ category = "GhillieSuit4Full", percent=0.1 },
			},
		},

		{
			category = "RandomGhillieSuitParts",
			classes = 
			{
				{ class = "GhillieSuit1", percent= 12.5 },
				{ class = "GhillieHood1", percent= 12.5 },
				{ class = "GhillieSuit2", percent= 12.5 },
				{ class = "GhillieHood2", percent= 12.5 },
				{ class = "GhillieSuit3", percent= 12.5 },
				{ class = "GhillieHood3", percent= 12.5 },
				{ class = "GhillieSuit4", percent= 12.5 },
				{ class = "GhillieHood4", percent= 12.5 },
			},
		},

		{
			category = "GhillieSuit1Full",
			group =
			{
				{ class = "GhillieSuit1" },
				{ class = "GhillieHood1" },
			},
		},

		{
			category = "GhillieSuit2Full",
			group =
			{
				{ class = "GhillieSuit2" },
				{ class = "GhillieHood2" },
			},
		},

		{
			category = "GhillieSuit3Full",
			group =
			{
				{ class = "GhillieSuit3" },
				{ class = "GhillieHood3" },
			},
		},

		{
			category = "GhillieSuit4Full",
			group =
			{
				{ class = "GhillieSuit4" },
				{ class = "GhillieHood4" },
			},
		},

		{
			category = "RandomMilitaryBodyArmor",
			classes = 
			{
				{ class = "FlakVestTanCamo1", percent = 25 },
				{ class = "FlakVestGreen", percent = 25 },
				{ class = "FlakVestGreenCamo1", percent = 25 },
				{ class = "FlakVestTan", percent = 25 },
			},
		},

		{
			category = "RandomPolicebodyArmor",
			classes = 
			{
				{ class = "PoliceVestBlack", percent = 50 },
				{ class = "PoliceVestBlue", percent = 50 },
			},
		},

		{
			category = "RandomNoSleevesVest",
			classes = 
			{
				{ class = "NoSleevesVestBlack", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestBlue", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestBrown", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestGreen", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestRed", contents="RandomTorsoContents", percent = 16 },
				{ class = "NoSleevesVestTan", contents="RandomTorsoContents", percent = 16 },
			},
		},

		{
			category = "RandomSweater",
			classes = 
			{
				{ class = "Sweater", contents="RandomTorsoContents", percent = 10 },
				{ class = "SweaterBlack", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterBlue", contents="RandomTorsoContents", percent = 15 },
				-- disabled until christmas
				-- { class = "SweaterChristmasGreen", contents="RandomTorsoContents", percent = 3 },
				-- { class = "SweaterChristmasGreen2", contents="RandomTorsoContents", percent = 3 },
				-- { class = "SweaterChristmasRed", contents="RandomTorsoContents", percent = 3 },
				-- { class = "SweaterChristmasRed2", contents="RandomTorsoContents", percent = 3 },
				{ class = "SweaterGreen", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterOrange", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterPink", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterRed", contents="RandomTorsoContents", percent = 15 },
			}

		},

		{
			category = "RandomTacticalVest",
			classes = 
			{
				{ class = "TacticalVestBlack", contents="RandomTorsoContents", percent = 6 },
				{ class = "TacticalVestGreen", contents="RandomTorsoContents", percent = 6 },
				{ class = "TacticalVestGreenCamo1",contents="RandomTorsoContents", percent = 6 },
				{ class = "TacticalVestGreenCamo2",contents="RandomTorsoContents", percent = 6 },
				{ class = "TacticalVestGreenCamo3",contents="RandomTorsoContents", percent = 6 },
				{ class = "TacticalVestGreenCamo4",contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestTan", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestTanCamo1", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestTanCamo2", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestTanCamo3", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestTanCamo4", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestUrbanCamo1", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestUrbanCamo2", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestUrbanCamo3", contents="RandomTorsoContents", percent = 7 },
				{ class = "TacticalVestUrbanCamo4", contents="RandomTorsoContents", percent = 7 },
			},
		},

		{
			category = "RandomTshirt",
			classes =
			{
				{ class = "TshirtAmalgamatedGreen", percent = 1 },
				{ class = "TshirtAmalgamatedGrey", percent = 1 },
				{ class = "TshirtAmalgamatedPink", percent = 1 },
				{ class = "TshirtAmalgamatedRed", percent = 1 },
				{ class = "TshirtBBGBlack", percent = 1 },
				{ class = "TshirtBBGBlue", percent = 1 },
				{ class = "TshirtBBGGreen", percent = 1 },
				{ class = "TshirtBBGGrey", percent = 1 },
				{ class = "TshirtBBGPink", percent = 1 },
				{ class = "TshirtBBGRed", percent = 1 },
				{ class = "TshirtCamo1", percent = 1 },
				{ class = "TshirtCamo2", percent = 2 },
				{ class = "TshirtCamo3", percent = 1 },
				{ class = "TshirtCamo4", percent = 1 },
				{ class = "TshirtCatBlack", percent = 1 },
				{ class = "TshirtCatBlue", percent = 1 },
				{ class = "TshirtCatGreen", percent = 1 },
				{ class = "TshirtCatGrey", percent = 1 },
				{ class = "TshirtCatPink", percent = 1 },
				{ class = "TshirtCatRed", percent = 1 },
				{ class = "TshirtCryengineBlack", percent = 1 },
				{ class = "TshirtCryengineBlue", percent = 1 },
				{ class = "TshirtCryengineGreen", percent = 1 },
				{ class = "TshirtCryengineGrey", percent = 1 },
				{ class = "TshirtCryenginePink", percent = 1 },
				{ class = "TshirtCryengineRed", percent = 1 },
				{ class = "TshirtEntradaBlack", percent = 1 },
				{ class = "TshirtEntradaBlue", percent = 1 },
				{ class = "TshirtEntradaGreen", percent = 1 },
				{ class = "TshirtEntradaGrey", percent = 1 },
				{ class = "TshirtEntradaPink", percent = 1 },
				{ class = "TshirtEntradaRed", percent = 1 },
				{ class = "TshirtFirefighterBlack", percent = 1 },
				{ class = "TshirtFirefighterBlue", percent = 1 },
				{ class = "TshirtFlipflopBlack", percent = 1 },
				{ class = "TshirtFlipflopBlue", percent = 1 },
				{ class = "TshirtFlipflopGreen", percent = 1 },
				{ class = "TshirtFlipflopGrey", percent = 1 },
				{ class = "TshirtFlipflopPink", percent = 1 },
				{ class = "TshirtFlipflopRed", percent = 1 },
				{ class = "TshirtKstarBlack", percent = 1 },
				{ class = "TshirtKstarBlue", percent = 1 },
				{ class = "TshirtKstarGreen", percent = 1 },
				{ class = "TshirtKstarGrey", percent = 1 },
				{ class = "TshirtKstarPink", percent = 1 },
				{ class = "TshirtKstarRed", percent = 1 },
				{ class = "TshirtMaskBlack", percent = 1 },
				{ class = "TshirtMaskBlue", percent = 1 },
				{ class = "TshirtMaskGreen", percent = 1 },
				{ class = "TshirtMaskGrey", percent = 1 },
				{ class = "TshirtMaskPink", percent = 1 },
				{ class = "TshirtMaskRed", percent = 1 },
				{ class = "TshirtNoImageBlack", percent = 1 },
				{ class = "TshirtNoImageBlue", percent = 1 },
				{ class = "TshirtNoImageGreen", percent = 1 },
				{ class = "TshirtNoImageGrey", percent = 1 },
				{ class = "TshirtNoImagePink", percent = 1 },
				{ class = "TshirtNoImageRed", percent = 1 },
				{ class = "TshirtNuclearBlack", percent = 1 },
				{ class = "TshirtNuclearBlue", percent = 1 },
				{ class = "TshirtNuclearGreen", percent = 1 },
				{ class = "TshirtNuclearGrey", percent = 1 },
				{ class = "TshirtNuclearPink", percent = 1 },
				{ class = "TshirtNuclearRed", percent = 1 },
				{ class = "TshirtPlebsiBlack", percent = 1 },
				{ class = "TshirtPlebsiBlue", percent = 1 },
				{ class = "TshirtPlebsiGreen", percent = 1 },
				{ class = "TshirtPlebsiGrey", percent = 1 },
				{ class = "TshirtPlebsiPink", percent = 1 },
				{ class = "TshirtPlebsiRed", percent = 1 },
				{ class = "TshirtPoliceBlack", percent = 1 },
				{ class = "TshirtPoliceBlue", percent = 1 },
				{ class = "TshirtPolycountBlack", percent = 1 },
				{ class = "TshirtPolycountBlue", percent = 1 },
				{ class = "TshirtPolycountGreen", percent = 1 },
				{ class = "TshirtPolycountGrey", percent = 2 },
				{ class = "TshirtPolycountPink", percent = 1 },
				{ class = "TshirtPolycountRed", percent = 1 },
				{ class = "TshirtSecurityBlack", percent = 1 },
				{ class = "TshirtSecurityBlue", percent = 1 },
				{ class = "TshirtSuckersBlack", percent = 1 },
				{ class = "TshirtSuckersBlue", percent = 1 },
				{ class = "TshirtSuckersGreen", percent = 1 },
				{ class = "TshirtSuckersGrey", percent = 1 },
				{ class = "TshirtSuckersPink", percent = 1 },
				{ class = "TshirtSuckersRed", percent = 1 },
				{ class = "TshirtTargetBlack", percent = 2 },
				{ class = "TshirtTargetBlue", percent = 2 },
				{ class = "TshirtTargetGreen", percent = 2 },
				{ class = "TshirtTargetGrey", percent = 2 },
				{ class = "TshirtTargetPink", percent = 1 },
				{ class = "TshirtTargetRed", percent = 1 },
				{ class = "TshirtAmalgamatedBlack", percent = 1 },
				{ class = "TshirtAmalgamatedBlue", percent = 1 },
			}
		},

		-- Neck
		{
			category = "RandomScarf",
			classes =
			{
				{ class = "ScarfBlack", percent = 10 },
				{ class = "ScarfCamo1", percent = 15 },
				{ class = "ScarfCamo2", percent = 10 },
				{ class = "ScarfCamo3", percent = 10 },
				{ class = "ScarfCamo4", percent = 10 },
				{ class = "ScarfGray", percent = 10 },
				{ class = "ScarfOrange", percent = 10 },
				{ class = "ScarfRed", percent = 10 },
				{ class = "ScarfShemagh", percent = 15 },
			}
		},

		-- --------------------------------------------------------------------
		-- RECIPE GUIDES
		-- --------------------------------------------------------------------

		{
			category = "RandomCraftingGuide",
			classes =
			{
				-- generic (18)
				{ class = "guide_medical_bandages", percent = 5 },
				{ class = "guide_weapons_melee", percent = 4 },
				{ class = "guide_structures_tire_stacks", percent = 4 },
				{ class = "guide_structures_wood_storage", percent = 5 },

				-- basic (37)
				{ class = "guide_structures_wood_bridges_1", percent = 3 },
				{ class = "guide_structures_wood_ramps_1", percent = 3 },
				{ class = "guide_structures_wood_stairs_1", percent = 3 },
				{ class = "guide_structures_wood_traps_1", percent = 3 },
				{ class = "guide_structures_wood_walkways_1", percent = 3 },
				{ class = "guide_structures_wood_walls_1", percent = 4 },
				{ class = "guide_structures_wood_roofs", percent = 4 },
				{ class = "guide_powered_parts_1", percent = 4 },
				{ class = "guide_traps_1", percent = 3 },
				{ class = "guide_explosives_1", percent = 3 },
				{ class = "guide_weapons_ranged_1", percent = 4 },

				-- advanced (37)
				{ class = "guide_structures_wood_bridges_2", percent = 3 },
				{ class = "guide_structures_wood_ramps_2", percent = 4 },
				{ class = "guide_structures_wood_stairs_2", percent = 3 },
				{ class = "guide_structures_wood_traps_2", percent = 3 },
				{ class = "guide_structures_wood_walkways_2", percent = 5 },
				{ class = "guide_structures_wood_walls_2", percent = 7 },
				{ class = "guide_traps_2", percent = 3 },
				{ class = "guide_explosives_2", percent = 3 },
				{ class = "guide_weapons_ranged_2", percent = 3 },
				{ class = "guide_weapons_ranged_3", percent = 3 },

				-- specialized (8)
				{ class = "guide_structures_wood_curves", percent = 2 },
				{ class = "guide_structures_wood_gallows", percent = 2 },
				{ class = "guide_structures_wood_watchtower", percent = 2 },
				{ class = "guide_structures_wood_gatehouse", percent = 2 },
			},
		},

		-- --------------------------------------------------------------------
		-- CONSUMABLES
		-- --------------------------------------------------------------------

		-- Refillables

		-- Drinks

		-- Food
		{
			category = "Egg",
			classes =
			{
				{ class = "EggChicken", percent = 100 },
			},
		},

		{
			category = "SaltAndPepper", -- basically cooking ingredients
			classes =
			{
				-- only salt for now pepper has no use
				-- Add more smaller spices and stuff like ketchup etc here

				{ class = "Salt", percent = 100 },
				-- { class = "Pepper", percent = 1 },
			},
		},

		-- --------------------------------------------------------------------
		-- CRAFTING
		-- --------------------------------------------------------------------
         
		-- --------------------------------------------------------------------
		-- EQUIPMENT
		-- --------------------------------------------------------------------

		{
			category = "RandomFireStarter",
			classes =
			{
				{ class = "Matches", percent = 90 },
				{ class = "Lighter", percent = 10 },
			},
		},

		{
			category = "StickPileOrThatch",
			classes =
			{
				{ class = "StickPile", percent = 30 },
				{ class = "Thatch", percent = 70 },
			},
		},

		{
			category = "RandomMaintenance",
			classes =
			{
				{ class = "CarBattery", percent = 20 },
				{ class = "TowCable", percent = 10 },
				{ class = "DriveBelt", percent = 25 },
				{ class = "DuctTape", percent = 10 },
				{ class = "ElectricalParts", percent = 2 },
				{ class = "Oil", percent = 7 },
				{ class = "SparkPlugs", percent = 25 },
				{ class = "WorkLight", percent = 1 },
			},
		},

		{
			category = "Wheel",
			classes =
			{
				{ class = "Wheel", percent = 100 },
			},
		},

		-- --------------------------------------------------------------------
		-- MEDICAL
		-- --------------------------------------------------------------------

		-- ====================================================================
		-- ADVANCED CATEGORIES
		-- ====================================================================

		-- contains all the parts needed to craft a backpack
		{
			category = "BackpackComponents",
			classes =
			{
				{ class = "Rope", percent = 40 },
				{ class = "Rags", percent = 60 },
			},
		},


		-- Back
		{
			category = "RandomBackpack",
			classes =
			{
				{ category = "BackpackComponents", percent = 35 },
				{ category = "RandomDuffelBag", percent = 3 },
				{ category = "RandomStowPack", percent = 40 },
				{ category = "RuggedPack", percent = 15 },
				{ category = "RandomRuckSack", percent = 7 },
			},
		},


		-- Eyes
		{
			category = "RandomEyes",
			classes =
			{
				{ class = "Aviators", percent = 15 },
				{ class = "EyepatchLeft", percent = 15 },
				{ class = "EyepatchRight", percent = 15 },
				{ class = "SunglassesABlack", percent = 7 },
				{ class = "SunglassesAGold", percent = 12 },
				{ class = "SunglassesASilver", percent = 7 },
				{ class = "SunglassesBBlack", percent = 15 },
				{ class = "SunglassesBMaroon", percent = 7 },
				{ class = "SunglassesBSilver", percent = 7 },
			},
		},


		-- Face
		{
			category = "RandomFace",
			classes =
			{
				{ category = "RandomBalaclava", percent = 16 },
				{ category = "RandomBandana", percent = 34 },
				{ class = "GasMask", percent = 4 },
				{ class = "DustMask", percent = 15 },
				{ class = "HeadSack", percent = 12 },
				{ class = "HockeyMask", percent = 13 },
				{ class = "HockeyMaskDp", percent = 6 },
			},
		},


		-- Feet
		{
			category = "RandomShoes",
			classes =
			{
				{ category = "RandomCombatBoots", percent = 30 },
				{ category = "RandomHitops", percent = 15 },
				{ category = "RandomSneakers", percent = 15 },
				{ category = "RandomSteeltoedBoots", percent = 25 },
				{ class = "CanvasShoes", percent = 5 },
				{ class = "FlipFlops", percent = 5 },
				{ class = "TennisShoes", percent = 5 },
			},
		},

		{
			category = "RandomMilitaryShoes",
			classes =
			{
				{ category = "RandomCombatBoots", percent = 50 },
				{ category = "RandomSteeltoedBoots", percent = 50 },
			},
		},

		{
			category = "RandomFeet",
			classes =
			{
				{ category = "RandomShoes", percent = 100 },
			},
		},


		-- Hands
		{
			category = "RandomHands",
			classes =
			{
				{ category = "RandomCamoGloves", percent = 20 },
				{ category = "RandomWoolGloves", percent = 80 },
			},
		},


		-- Hat
		{
			category = "RandomBeanie",
			classes =
			{
				{ class = "BeanieBrown", percent = 5 },
				{ class = "BeanieBrownWhite", percent = 20 },
				{ class = "BeanieGreenGreen", percent = 25 },
				{ class = "BeanieOrangeYellow", percent = 25 },
				{ class = "BeaniePinkPink", percent = 5 },
				{ class = "BeanieWhite", percent = 20 },
			},
		},

		{
			category = "RandomBeret",
			classes =
			{
				{ class = "BeretBlack", percent = 2 },
				{ class = "BeretBlackFlagAu", percent = 2 },
				{ class = "BeretBlackFlagBelgium", percent = 2 },
				{ class = "BeretBlackFlagCanada", percent = 2 },
				{ class = "BeretBlackFlagGermany", percent = 2 },
				{ class = "BeretBlackFlagIsrael", percent = 2 },
				{ class = "BeretBlackFlagUk", percent = 2 },
				{ class = "BeretBlackFlagUsa", percent = 2 },
				{ class = "BeretBlue", percent = 2 },
				{ class = "BeretBlueFlagAu", percent = 2 },
				{ class = "BeretBlueFlagBelgium", percent = 2 },
				{ class = "BeretBlueFlagCanada", percent = 2 },
				{ class = "BeretBlueFlagGermany", percent = 2 },
				{ class = "BeretBlueFlagIsrael", percent = 2 },
				{ class = "BeretBlueFlagUk", percent = 2 },
				{ class = "BeretBlueFlagUsa", percent = 2 },
				{ class = "BeretBrown", percent = 2 },
				{ class = "BeretBrownFlagAu", percent = 2 },
				{ class = "BeretBrownFlagBelgium", percent = 2 },
				{ class = "BeretBrownFlagCanada", percent = 2 },
				{ class = "BeretBrownFlagGermany", percent = 2 },
				{ class = "BeretBrownFlagIsrael", percent = 2 },
				{ class = "BeretBrownFlagUk", percent = 2 },
				{ class = "BeretBrownFlagUsa", percent = 2 },
				{ class = "BeretGreen", percent = 2 },
				{ class = "BeretGreenFlagAu", percent = 2 },
				{ class = "BeretGreenFlagBelgium", percent = 2 },
				{ class = "BeretGreenFlagCanada", percent = 2 },
				{ class = "BeretGreenFlagGermany", percent = 2 },
				{ class = "BeretGreenFlagIsrael", percent = 4 },
				{ class = "BeretGreenFlagUk", percent = 2 },
				{ class = "BeretGreenFlagUsa", percent = 2 },
				{ class = "BeretRed", percent = 2 },
				{ class = "BeretRedFlagAu", percent = 2 },
				{ class = "BeretRedFlagBelgium", percent = 2 },
				{ class = "BeretRedFlagCanada", percent = 2 },
				{ class = "BeretRedFlagGermany", percent = 2 },
				{ class = "BeretRedFlagIsrael", percent = 2 },
				{ class = "BeretRedFlagUk", percent = 2 },
				{ class = "BeretRedFlagUsa", percent = 2 },
				{ class = "BeretSkyBlue", percent = 2 },
				{ class = "BeretSkyBlueFlagAu", percent = 2 },
				{ class = "BeretSkyBlueFlagBelgium", percent = 2 },
				{ class = "BeretSkyBlueFlagCanada", percent = 2 },
				{ class = "BeretSkyBlueFlagGermany", percent = 2 },
				{ class = "BeretSkyBlueFlagIsrael", percent = 2 },
				{ class = "BeretSkyBlueFlagUk", percent = 2 },
				{ class = "BeretSkyBlueFlagUsa", percent = 4 },
			},
		},


		{
			category = "RandomBikeHelmet",
			classes =
			{
				{ class = "BikeHelmetBlack", percent = 10 },
				{ class = "BikeHelmetBlue", percent = 10 },
				{ class = "BikeHelmetGreen", percent = 10 },
				{ class = "BikeHelmetPink", percent = 10 },
				{ class = "BikeHelmetPurple", percent = 10 },
				{ class = "BikeHelmetRed", percent = 10 },
				{ class = "BikeHelmetWhite", percent = 20 },
				{ class = "BikeHelmetYellow", percent = 20 },
			},
		},

		{
			category = "RandomFlexCap",
			classes =
			{
				{ class = "flexcap_acfrontback_black", percent = 2 },
				{ class = "flexcap_acfrontback_blue", percent = 2 },
				{ class = "flexcap_acfrontback_camo1", percent = 2 },
				{ class = "flexcap_acfrontback_camo2", percent = 2 },
				{ class = "flexcap_acfrontback_camo3", percent = 2 },
				{ class = "flexcap_acfrontback_camo4", percent = 2 },
				{ class = "flexcap_aclogofrontacback_black", percent = 1 },
				{ class = "flexcap_aclogofrontacback_blue", percent = 2 },
				{ class = "flexcap_aclogofrontacback_camo1", percent = 1 },
				{ class = "flexcap_aclogofrontacback_camo2", percent = 1 },
				{ class = "flexcap_aclogofrontacback_camo3", percent = 1 },
				{ class = "flexcap_aclogofrontacback_camo4", percent = 1 },
				{ class = "flexcap_crytekfront_black", percent = 2 },
				{ class = "flexcap_crytekfront_brown", percent = 2 },
				{ class = "flexcap_crytekfront_camo1", percent = 1 },
				{ class = "flexcap_crytekfront_camo2", percent = 1 },
				{ class = "flexcap_crytekfront_camo3", percent = 1 },
				{ class = "flexcap_crytekfront_camo4", percent = 1 },
				{ class = "flexcap_dopefishfront_black", percent = 2 },
				{ class = "flexcap_dopefishfront_blue", percent = 2 },
				{ class = "flexcap_dopefishfront_green", percent = 2 },
				{ class = "flexcap_dopefishfront_orange", percent = 2 },
				{ class = "flexcap_dopefishfront_pink", percent = 2 },
				{ class = "flexcap_dopefishfront_red", percent = 2 },
				{ class = "flexcap_eilogo_black", percent = 2 },
				{ class = "flexcap_eilogo_blue", percent = 2 },
				{ class = "flexcap_eilogo_khaki", percent = 2 },
				{ class = "flexcap_eilogo_pink", percent = 2 },
				{ class = "flexcap_firefrontback_black", percent = 1 },
				{ class = "flexcap_firefrontback_blue", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo1", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo2", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo3", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo4", percent = 2 },
				{ class = "flexcap_nobranding_black", percent = 2 },
				{ class = "flexcap_nobranding_blue", percent = 2 },
				{ class = "flexcap_nobranding_green", percent = 2 },
				{ class = "flexcap_nobranding_orange", percent = 2 },
				{ class = "flexcap_nobranding_pink", percent = 2 },
				{ class = "flexcap_nobranding_red", percent = 2 },
				{ class = "flexcap_policefrontback_black", percent = 2 },
				{ class = "flexcap_policefrontback_blue", percent = 2 },
				{ class = "flexcap_policefrontback_camo1", percent = 2 },
				{ class = "flexcap_policefrontback_camo2", percent = 2 },
				{ class = "flexcap_policefrontback_camo3", percent = 2 },
				{ class = "flexcap_policefrontback_camo4", percent = 2 },
				{ class = "flexcap_polycountfront_black", percent = 2 },
				{ class = "flexcap_polycountfront_blue", percent = 2 },
				{ class = "flexcap_polycountfront_pink", percent = 1 },
				{ class = "flexcap_usfrontback_black", percent = 1 },
				{ class = "flexcap_usfrontback_blue", percent = 1 },
				{ class = "flexcap_usfrontback_green", percent = 1 },
				{ class = "flexcap_usfrontback_orange", percent = 1 },
				{ class = "flexcap_usfrontback_pink", percent = 1 },
				{ class = "flexcap_usfrontback_red", percent = 1 },
				{ class = "flexcap_ausfront_camo4", percent = 1 },
				{ class = "flexcap_usfront_camo4", percent = 1 },
				{ class = "flexcap_gerfront_camo4", percent = 1 },
				{ class = "flexcap_belfront_camo4", percent = 1 },
				{ class = "flexcap_isrealfront_camo4", percent = 1 },
				{ class = "flexcap_canadafront_camo4", percent = 1 },
				{ class = "flexcap_gbfront_camo4", percent = 1 },
			 },
		},

		{
			category = "RandomFootballHelmet",
			classes =
			{
				{ class = "FootballHelmetFabulous", percent = 0.25 },
				{ class = "FootballHelmetAmerica", percent = 0.25 },
				{ class = "FootballHelmetGold", percent = 2 },
				{ class = "FootballHelmet", percent = 2 },
				{ class = "FootballHelmetBlack", percent = 7.5 },
				{ class = "FootballHelmetBlue", percent = 5 },
				{ class = "FootballHelmetRed", percent = 5 },
				{ class = "FootballHelmetStripedBlack", percent = 5 },
				{ class = "FootballHelmetStripedBlue", percent = 5 },
				{ class = "FootballHelmetStripedGreen", percent = 5 },
				{ class = "FootballHelmetStripedRed", percent = 5 },
				{ class = "FootballHelmetStripedTeal", percent = 5 },
				{ class = "FootballHelmetStripedYellow", percent = 5 },
				{ class = "FootballHelmetTeal", percent = 5 },
				{ class = "FootballHelmetWhiteStripedBlack", percent = 5 },
				{ class = "FootballHelmetWhiteStripedBlue", percent = 5 },
				{ class = "FootballHelmetWhiteStripedGreen", percent = 5 },
				{ class = "FootballHelmetWhiteStripedRed", percent = 5 },
				{ class = "FootballHelmetWhiteStripedTeal", percent = 5 },
				{ class = "FootballHelmetWhiteStripedYellow", percent = 5 },
				{ class = "FootballHelmetYellow", percent = 5 },
				{ class = "FootballHelmetGreen", percent = 8 },
			},
		},

		{
			category = "RandomFootballPads",
			classes =
			{
				{ class = "FootballPads", percent = 100 },
			},
		},

		{
			category = "RandomHeadband",
			classes =
			{
				{ class = "HeadbandBlack", percent = 34 },
				{ class = "HeadbandRed", percent = 33 },
				{ class = "HeadbandWhite", percent = 33 },
			},
		},

		{
			category = "RandomMotorcycleHelmet",
			classes =
			{
				{ class = "MotorcycleHelmetCarbon", percent = 45 },
				{ class = "MotorcycleHelmetGold", percent = 45 },
				{ class = "MotorcycleHelmetWhite", percent = 10 },
			},
		},

		{
			category = "RandomHat",
			classes =
			{
				{ category = "RandomBeanie", percent = 8 },
				{ category = "RandomBeret", percent = 10 },
				{ category = "RandomBikeHelmet", percent = 10 },
				{ category = "RandomCowboyHat", percent = 11 },
				{ category = "RandomFlexCap", percent = 8 },
				{ category = "RandomHeadband", percent = 11 },
				{ category = "RandomMotorcycleHelmet", percent = 6 },
				{ category = "RandomFootballHelmet", percent = 6 },
				{ class = "BandanaHat", percent = 6 },
				{ class = "BaseballCap", percent = 7 },
				-- { class = "ChristmasHat", percent = 2 }, -- disabled until christmas
				{ class = "DorfmanPacific", percent = 10 },
				{ class = "WeldersMask", percent = 7 },
			},
		},


		-- Legs
		{
			category = "RandomLegs",
			classes =
			{
				{ category = "RandomBlueJeans2", percent = 10 },
				{ category = "RandomCargoPants", percent = 25 },
				{ category = "RandomCargoShorts", percent = 25 },
				{ category = "RandomTrackPants", percent = 15 },
				{ category = "RandomWandererPants", percent = 25 },
			},
		},


		-- Neck
		{
			category = "RandomNeck",
			classes =
			{
				{ category = "RandomScarf", percent = 45 },
				{ class = "NecklaceCrossChrome", percent = 10 },
				{ class = "ShoulderPadOneSide", percent = 10 },
				{ class = "ShoulderPadOneSideLeft", percent = 10 },
				{ class = "NecklaceCrossGold", percent = 10 },
				{ class = "NecklaceCrossSilver", percent = 15 },
			},
		},


		-- Torso
		{
			category = "RandomTorso",
			classes =
			{
				{ category = "RandomButtonUpShirt", percent = 8 },
				{ category = "RandomSweater", percent = 7 },
				{ category = "RandomCottonShirt", percent = 10 },
				{ category = "RandomHoodie", percent = 15 },
				{ category = "RandomFootballPads", percent = 5 },
				{ category = "RandomLeatherJacket", percent = 15 },
				{ category = "RandomNoSleevesVest", percent = 10 },
				{ category = "RandomTacticalVest", percent = 5 },
				{ category = "RandomTshirt", percent = 15 },
				{ category = "RandomRainJacket", percent = 5 },
				{ category = "RandomPuffyJacket", percent = 5 },
			},
		},

		-- Waist
		{
			category = "RandomWaist",
			classes =
			{
				{ class = "FannyPackBlack", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackBlueOrange", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackCamo1", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackCamo2", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackCamo3", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackGray", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackGreenGray", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackMaroonGray", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackPurplePink", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackRed", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackRedBlue", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackYellow", contents="RandomWaistContents", percent = 8 },
			},
		},


		-- Clothes
		{
			category = "RandomClothes",
			classes =
			{
				{ category = "RandomCraftingGuide", percent = 9 },
				--{ category = "RandomChristmasPresent", percent = 2 },-- Christmas event
				--{ category = "halloweenBagCommon", percent = 2 },-- halloween
				{ category = "RandomEyes", percent = 7 },
				{ category = "RandomEggs", percent = 2 },
				{ category = "RandomFace", percent = 7 },
				{ category = "RandomHands", percent = 12 },
				{ category = "RandomHat", percent = 12 },
				{ category = "RandomLegs", percent = 15 },
				{ category = "RandomNeck", percent = 7 },
				{ category = "RandomShoes", percent = 10 },
				{ category = "RandomTorso", percent = 13 },
				{ category = "RandomWaist", percent = 4 },
			},
		},

		{
			category = "RandomCamoFace",
			classes =
			{
				{ class = "BandanaCamo1", percent = 25 },
				{ class = "BandanaCamo2", percent = 25 },
				{ class = "BandanaCamo3", percent = 25 },
				{ class = "BandanaCamo4", percent = 25 },
			},
		},

		{
			category = "RandomCamoHats",
			classes =
			{
				{ class = "BandanaHatCamo1", percent = 25 },
				{ class = "BandanaHatCamo2", percent = 25 },
				{ class = "BandanaHatCamo3", percent = 25 },
				{ class = "BandanaHatCamo4", percent = 25 },
			},
		},

		{
			category = "RandomCamoPants",
			classes =
			{
				{ class = "CargoPantsCamo1", contents="RandomLegsContents", percent = 25 },
				{ class = "CargoPantsCamo2", contents="RandomLegsContents", percent = 25 },
				{ class = "CargoPantsCamo3", contents="RandomLegsContents", percent = 25 },
				{ class = "CargoPantsCamo4", contents="RandomLegsContents", percent = 25 },
			},
		},

		{
			category = "RandomCamoShirts",
			classes =
			{
				{ class = "MilitaryJacketTanCamo1", contents="RandomTorsoContents", percent = 15 },
				{ class = "MilitaryJacketTanCamo2", contents="RandomTorsoContents", percent = 15 },
				{ class = "MilitaryJacketTanCamo3", contents="RandomTorsoContents", percent = 15 },
				{ class = "MilitaryJacketTanCamo4", contents="RandomTorsoContents", percent = 15 },
				{ class = "TshirtCamo1", percent = 15 },
				{ class = "TshirtCamo2", percent = 15 },
				{ class = "TshirtCamo3", percent = 5 },
				{ class = "TshirtCamo4", percent = 5 },
			},
		},

		{
			category = "RandomCamoGloves",
			classes =
			{
				{ class = "WoolGlovesCamo1", percent = 25 },
				{ class = "WoolGlovesCamo2", percent = 25 },
				{ class = "WoolGlovesCamo3", percent = 25 },
				{ class = "WoolGlovesCamo4", percent = 25 },
			},
		},

		{
			category = "RandomCamoClothes",
			classes =
			{
				{ category = "RandomCamoFace", percent = 20 },
				{ category = "RandomCamoGloves", percent = 20 },
				{ category = "RandomCamoHats", percent = 20 },
				{ category = "RandomCamoPants", percent = 20 },
				{ category = "RandomCamoShirts", percent = 20 },
			},
		},


		-- Magazines/Rounds (with varying capacity/type)
		{
			category = "12GaugeAA12Mags",
			classes =
			{
				{ class = "12Gaugex8_Beanbag_AA12", percent = 15 },
				{ class = "12Gaugex8_Pellet_AA12", percent = 55 },
				{ class = "12Gaugex8_Slug_AA12", percent = 30 },
			},
		},

		{
			category = "12GaugeShells",
			classes =
			{
				{ class = "Pile_12GaugePellet", percent = 75 },
				{ class = "Pile_12GaugeSlug", percent = 25 },
			},
		},

		{
			category = "12GaugeShellsPolice",
			classes =
			{
				{ class = "Pile_12GaugeBeanbag", percent = 35 },
				{ class = "Pile_12GaugePellet", percent = 45 },
				{ class = "Pile_12GaugeSlug", percent = 20 },
			},
		},

		{
			category = "9mmMagazine",
			classes =
			{
				{ class = "9mmx10", percent = 89 },
				{ class = "9mmx19", percent = 10 },
				{ class = "9mmx33", percent = 1 },
			},
		},


		-- Weapons with Magazines/Rounds
		{
			category = "AA12WithMagazines",
			group =
			{
				{ category = "12GaugeAA12Mags" },
				{ class = "AA12" },
			},
		},
		
		{
			category = "AK74UWithMagazines",
			group =
			{
				{ class = "AK74U" },
				{ class = "545x30" },
			},
		},

		{
			category = "AKMWithMagazines",
			group =
			{
				{ class = "AKM" },
				{ class = "762x30" },
			},
		},

		{
			category = "AKMGoldWithMagazines",
			group =
			{
				{ class = "AKMGold" },
				{ class = "762x30" },
			},
		},

		{
			category = "AP85WithMagazines",
			group =
			{
				{ class = "AP85" },
				{ class = "9mmx19_ap85" },
			},
		},

		{
			category = "AT15WithMagazines",
			group =
			{
				{ class = "AT15" },
				{ class = "STANAGx30" },
				{ class = "IronsightKit" },
			},
		},

		{
			category = "BulldogWithMagazines",
			group =
			{
				{ class = "Bulldog" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "ColtPytonWithRounds",
			group =
			{
				{ class = "ColtPython" },
				{ class = "Pile_357" },
			},
		},

		{
			category = "ColtPythonGrimeyRickWithRounds",
			group =
			{
				{ class = "ColtPythonGrimeyRick" },
				{ class = "Pile_357" },
			},
		},

		{
			category = "CraftedBowWithMagazines",
			group =
			{
				{ class = "CraftedBow" },
				{ class = "Arrowx8" },
			},
		},

		{
			category = "CraftedPistolWithMagazines",
			group =
			{
				{ category = "9mmMagazine" },
				{ class = "CraftedPistol" },
			},
		},

		{
			category = "CraftedSMGWithMagazines",
			group =
			{
				{ category = "9mmMagazine" },
				{ class = "CraftedSMG" },
			},
		},

		{
			category = "CraftedRifleWithMagazines",
			group =
			{
				{ class = "CraftedRifleLong" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "CrossbowWithMagazines",
			group =
			{
				{ class = "Crossbow" },
				{ class = "Boltx5_0000" },
			},
		},

		{
			category = "FlareGunWithRounds",
			group =
			{
				{ class = "FlareGun" },
				{ class = "Pile_Flare" },
			},
		},

		{
			category = "G18PistolWithMagazines",
			group =
			{
				{ category = "9mmMagazine" },
				{ class = "G18Pistol" },
			},
		},

		{
			category = "HK45WithMagazines",
			group =
			{
				{ class = "hk45" },
				{ class = "acp_45x10_hk" },
			},
		},

		{
			category = "M16WithMagazines",
			group =
			{
				{ class = "M16" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "M1911WithMagazines",
			group =
			{
				{ class = "m1911a1" },
				{ class = "acp_45x7" },
			},
		},

		{
			category = "M40A5WithMagazines",
			group =
			{
				{ class = "M40A5" },
				{ class = "M40x5" },
			},
		},

		{
			category = "Mk18WithMagazines",
			group =
			{
				{ class = "Mk18" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "Mk18ReaverWithMagazines",
			group =
			{
				{ class = "Mk18Reaver" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "Model70WithRounds",
			group =
			{
				{ class = "Model70" },
				{ class = "Pile_223" },
			},
		},

		{
			category = "P350WithMagazines",
			group =
			{
				{ class = "P350" },
				{ class = "357x14" },
			},
		},

		{
			category = "PX4WithMagazines",
			group =
			{
				{ class = "PX4" },
				{ class = "acp_45x10_hk" },
			},
		},
		
		{
			category = "R90WithMagazines",
			group =
			{
				{ class = "R90" },
				{ class = "57x50" },
			},
		},
		
		{
			category = "CX4StormWithMagazines",
			group =
			{
				{ class = "CX4Storm" },
				{ class = "acp_45x20" },
			},
		},
		
		{
			category = "AUMP45WithMagazines",
			group =
			{
				{ class = "AUMP45" },
				{ class = "acp_45x30" },
			},
		},
		
		{
			category = "AkValWithMagazines",
			group =
			{
				{ class = "AKVal" },
				{ class = "762x20_Akval" },
			},
		},
		
		{
			category = "AK5DWithMagazines",
			group =
			{
				{ class = "AK5D" },
				{ class = "556x30_ak5d" },
			},
		},
		
		{
			category = "SAS12WithRounds",
			group =
			{
				{ class = "SAS12" },
				{ class = "Pile_12GaugePellet" },
			},
		},
		
		{
			category = "MAK10WithRounds",
			group =
			{
				{ class = "MAK10" },
				{ class = "9x19_mac10" },
			},
		},
		
		{
			category = "M97WithRounds",
			group =
			{
				{ class = "M97" },
				{ class = "Pile_40mmGrenade" },
			},
		},


		{
			category = "RecurveBowWithMagazines",
			group =
			{
				{ class = "RecurveBow" },
				{ class = "Arrowx8" },
			},
		},

		{
			category = "Rem700WithRounds",
			group =
			{
				{ class = "Rem700" },
				{ class = "Pile_308" },
			},
		},

		{
			category = "Rem870WithRounds",
			group =
			{
				{ category = "12GaugeShells" },
				{ class = "Rem870" },
			},
		},

		{
			category = "Ruger22WithMagazines",
			group =
			{
				{ class = "ruger22" },
				{ class = "22x10_ruger" },
			},
		},

		{
			category = "Sako85WithRounds",
			group =
			{
				{ class = "Sako_85" },
				{ class = "Pile_308" },
			},
		},

		{
			category = "Shotgun870TacticalWithMagazines",
			group =
			{
				{ category = "12GaugeShellsPolice" },
				{ class = "Shotgun870Tactical" },
				{ class = "IronsightKit" },
			},
		},

		{
			category = "Wasteland22WithRounds",
			group =
			{
				{ class = "Wasteland22" },
				{ class = "Pile_22" },
			},
		},

		{
			category = "TranquilizerGunWithDarts",
			group =
			{
				{ class = "TranquilizerGun" },
				{ class = "Pile_TranquilizerDart" },
			},
		},

		{
			category = "M249WithMagazines",
			group =
			{
				{ class = "M249" },
				{ class = "556x100" },
			},
		},

		{
			category = "MP5WithMagazines",
			group =
			{
				{ class = "MP5" },
				{ class = "10mmx30" },
			},
		},

		{
			category = "KrissVWithMagazines",
			group =
			{
				{ class = "KrissV" },
				{ class = "10mmx15" },
			},
		},

		-- Throwables
		{
			category = "RandomChemlight",
			classes =
			{
				{ class = "ChemlightBluePickup", percent = 20 },
				{ class = "ChemlightGreenPickup", percent = 20 },
				{ class = "ChemlightRedPickup", percent = 20 },
				{ class = "ChemlightWhitePickup", percent = 20 },
				{ class = "ChemlightYellowPickup", percent = 20 },
			},
		},

		{
			category = "RandomSmokeGrenade",
			classes =
			{
				{ class = "GrenadeGasSleepPickup", percent = 10 },
				{ class = "GrenadeSmokeGreenPickup", percent = 15 },
				{ class = "GrenadeSmokeMagentaPickup", percent = 15 },
				{ class = "GrenadeSmokeRedPickup", percent = 15 },
				{ class = "GrenadeSmokeWhitePickup", percent = 30 },
				{ class = "GrenadeSmokeYellowPickup", percent = 15 },
				
			},
		},

		{
			category = "RandomMilitaryGrenade",
			classes =
			{
				{ class = "FlashbangPickup", percent = 26 },
				{ class = "GrenadeGasNervePickup", percent = 12 },
				{ class = "GrenadeGasSleepPickup", percent = 20 },
				{ class = "GrenadeGasTearPickup", percent = 20 },
				{ class = "GrenadePickup", percent = 20 },
				{ class = "TrapLandminePacked", percent = 2 },
			},
		},

		-- Consumables
		{
			category = "RandomDrink",
			classes =
			{
				-- To reduce food/water in the world these only add up to 50%
				{ category = "RandomRottenVeggie", percent = 9 }, 
				{ category = "RandomSeeds", percent = 2 }, 
				{ category = "RandomAlcohol", percent = 2},
				{ class = "WaterPurificationTablets", percent = 1 },
				{ class = "CivCanteen01", percent = 2 },
				{ class = "CokeCan", percent = 5 },
				{ class = "DrPepperCan", percent = 4 },
				{ class = "EnergyDrinkCan", percent = 2 },
				{ class = "MilitaryCanteenPlastic", percent = 2 },
				{ class = "MilitaryCanteenMetal", percent = 2 },
				{ class = "PepsiCan", percent = 5 },
				{ class = "SpriteCan", percent = 5 },
				{ class = "TomatoJuiceCan", percent = 2 },
				{ class = "WaterBottle", percent = 7 },
			},
		},

		{
			category = "RandomAlcohol",
			classes =
			{
				{ class = "BeerCan", percent = 25 },
				{ class = "MiniBottleGin", percent = 25 },
				{ class = "MiniBottleVodka", percent = 25 },
				{ class = "MiniBottleWhiskey", percent = 25 },
			},
		},

		{
			category = "RandomFood",
			classes =
			{
				-- To reduce food/water in the world these only add up to 50%
				{ category = "RandomRottenVeggie", percent = 17.5 }, 
				{ category = "RandomSeeds", percent = 3 }, 
				{ category = "SaltAndPepper", percent = 1 },
				{ class = "BeefStew", percent = 1 },
				{ class = "CannedMeat", percent = 2 },
				{ class = "CerealBox", percent = 1 },
				{ class = "CornCan", percent = 1 },
				{ class = "DogFoodCan", percent = 2 },
				{ class = "HersheysBar", percent = 2 },
				{ class = "MRE", percent = 0.5 },
				{ class = "NutSpread", percent = 1 },
				{ class = "PeachesCan", percent = 2 },
				{ class = "PearsCan", percent = 1 },
				{ class = "PeasCan", percent = 1 },
				{ class = "RavioliCan", percent = 2 },
				{ class = "SoupCan", percent = 1 },
				{ class = "TunaCan", percent = 1 },
				{ category = "RandomEggs", percent = 3 },
				--{ class = "ChocolateBox", percent = 3 }, vday
				--{ class = "Champagne", percent = 3 }, vday
				--{ class = "heart_balloon", percent = 3 }, vday
				--{ category = "halloweenBagCommon", percent = 1 },-- halloween
				--{ category = "RandomChristmasPresent", percent = 1 },-- Christmas event
			},
		},

		{
			category = "RandomVeggie",
			classes =
			{
				{ class = "Beets", percent = 1 },
				{ class = "BrushPeas", percent = 8 },
				{ class = "Pumpkin", percent = 16 },
				{ class = "Carrots", percent = 8 },
				{ class = "Potatoes", percent = 16 },
				{ class = "Radishes", percent = 19 },
				{ class = "SnapPeas", percent = 16 },
				{ class = "Tomatoes", percent = 16 },
			},
		},

		{
			category = "RandomRottenVeggie", 
			classes = 
			{
				{class = "BeetsRotten", percent = 6}, 
				{class = "AppleRotten", percent = 6}, 
				{class = "PumpkinRotten", percent = 13},
				{class = "BrushPeasRotten", percent = 13}, 
				{class = "CarrotsRotten", percent = 12}, 
				{class = "PotatoesRotten", percent = 12}, 
				{class = "RadishesRotten", percent = 13}, 
				{class = "SnapPeasRotten", percent = 13}, 
				{class = "TomatoesRotten", percent = 12}, 
			}, 
		}, 

		{
			category = "RandomConsumable", 
			classes = 
			{
				{category = "RandomDrink", percent = 30}, 
				{category = "RandomFood", percent = 30}, 
				{category = "RandomRottenVeggie", percent = 30}, 
				{category = "RandomVeggie", percent = 3},
				{category = "RandomSeeds", percent = 7}, 
			}, 
		}, 

		{
			category = "RandomRottenMeat", 
			classes = 
			{
				{class = "BearMeatRotten", percent = 10}, 
				{class = "ChickenRotten", percent = 40},
				{class = "DeerMeatSteakRotten", percent = 20}, 
				{class = "HamRotten", percent = 20}, 
				{class = "WolfMeatSteakRotten", percent = 10}, 
			}, 
		}, 

		{
			category = "RandomBurnedMeat", 
			classes = 
			{
				{class = "BearMeatBurned", percent = 10}, 
				{class = "ChickenBurned", percent = 40},
				{class = "DeerMeatSteakBurned", percent = 20}, 
				{class = "HamBurned", percent = 20}, 
				{class = "WolfMeatSteakBurned", percent = 10}, 
			}, 
		}, 


		-- Random Mushrooms in Caves
		{
			category = "RandomMushroom",
			classes =
			{
				{ class = "MushroomAntiRad", percent = 30 },
				{ class = "MushroomFood", percent = 35 },
				{ class = "MushroomHeal", percent = 35 },
			},
		},


		-- Medical
		{
			category = "RandomMedical",
			classes =
			{
				{ class = "AdrenalineSyringe", percent = 4 },
				{ class = "AntiradiationPills", percent = 12 },
				{ class = "PotassiumIodidePills", percent = 11 },
				{ class = "Antibiotics", percent = 20 },
				{ class = "Aspirin", percent = 8 },
				{ class = "Bandage", percent = 15 },
				{ class = "HeatPack", percent = 10 },
				{ class = "WaterPurificationTablets", percent = 7 },
				{ class = "Rags", percent = 2 },
				{ class = "RubbingAlcohol", percent = 8 },
				{ class = "Salt", percent = 3 },
			},
		},


		-- Tents
		{
			category = "RandomTent",
			classes =
			{
				{ category = "RandomCampingTent", percent = 20 },
				{ category = "RandomEasyCampTent", percent = 20 },
				{ category = "RandomPupTent", percent = 20 },
				{ category = "RandomTrekkingTent", percent = 20 },
				{ category = "RandomTwoPersonTent", percent = 20 },
			},
		},

		{
			category = "RandomPupTent",
			classes =
			{
				{ class = "PackedPupTentBlue", percent = 15 },
				{ class = "PackedPupTentBrown", percent = 25 },
				{ class = "PackedPupTentGreen", percent = 25 },
				{ class = "PackedPupTentRed", percent = 10 },
				{ class = "PackedPupTentTan", percent = 25 },
			},
		},

		{
			category = "RandomCampingTent",
			classes =
			{
				{ class = "PackedCampingTentBlue", percent = 14 },
				{ class = "PackedCampingTentBrown", percent = 14 },
				{ class = "PackedCampingTentGreen", percent = 14 },
				{ class = "PackedCampingTentOrange", percent = 14 },
				{ class = "PackedCampingTentPurple", percent = 14 },
				{ class = "PackedCampingTentRed", percent = 15 },
				{ class = "PackedCampingTentYellow", percent = 15 },
			},
		},

		{
			category = "RandomEasyCampTent",
			classes =
			{
				{ class = "PackedEasyCampTentBlue", percent = 15 },
				{ class = "PackedEasyCampTentBrown", percent = 15 },
				{ class = "PackedEasyCampTentGreen", percent = 14 },
				{ class = "PackedEasyCampTentOrange", percent = 14 },
				{ class = "PackedEasyCampTentPurple", percent = 14 },
				{ class = "PackedEasyCampTentRed", percent = 14 },
				{ class = "PackedEasyCampTentYellow", percent = 14 },
			},
		},

		{
			category = "RandomTrekkingTent",
			classes =
			{
				{ class = "PackedTrekkingTentBlue", percent = 14 },
				{ class = "PackedTrekkingTentBrown", percent = 14 },
				{ class = "PackedTrekkingTentGreen", percent = 14 },
				{ class = "PackedTrekkingTentOrange", percent = 14 },
				{ class = "PackedTrekkingTentPurple", percent = 14 },
				{ class = "PackedTrekkingTentRed", percent = 15 },
				{ class = "PackedTrekkingTentYellow", percent = 15 },
			},
		},

		{
			category = "RandomTwoPersonTent",
			classes =
			{
				{ class = "PackedTwoPersonTentBlue", percent = 14 },
				{ class = "PackedTwoPersonTentBrown", percent = 14 },
				{ class = "PackedTwoPersonTentGreen", percent = 14 },
				{ class = "PackedTwoPersonTentOrange", percent = 14 },
				{ class = "PackedTwoPersonTentPurple", percent = 14 },
				{ class = "PackedTwoPersonTentRed", percent = 15 },
				{ class = "PackedTwoPersonTentYellow", percent = 15 },
			},
		},


		-- Incapacitation
		{
			category = "HandcuffsWithKey",
			group =
			{
				{ class = "PoliceHandcuffs" },
				{ class = "PoliceHandcuffKey" },
			},
		},

		{
			category = "RandomIncapacition",
			classes =
			{
				{ category = "HandcuffsWithKey", percent = 34 },
				{ class = "DuctTape", percent = 33 },
				{ class = "Rope", percent = 20 },
				{ class = "HeadSack", percent = 13 },
			},
		},


		-- Crafting
		{
			category = "RandomCrafting",
			classes =
			{
				--{ category = "RandomChristmasPresent", percent = 2 },-- Christmas event
				--{ category = "halloweenBagCommon", percent = 2 },-- halloween
				--{ class = "CupidArrowx8", percent = 3 },--
				--{ class = "flower_vase", percent = 3 },--
				--{ class = "heart_candle", percent = 3 },-- Vday items
				--{ class = "heart_balloon", percent = 2 },--
				{ category = "RandomEggs", percent = 2 },
				{ category = "RandomIncapacition", percent = 4 },
				{ category = "RandomPaintCan", percent = 3 },
				{ category = "RandomFireStarter", percent = 4 },
				{ class = "Amalgaduino", percent = 0.1 },
				{ class = "BarbedWireCoil", percent = 5 },
				{ class = "CamoNetting", percent = 5 },
				{ class = "DuctTape", percent = 6.9 },
				{ class = "ElectricalParts", percent = 6 },
				{ class = "EmptyBottle", percent = 6 },
				{ class = "Nails", percent = 7 },
				{ class = "PipeMetal", percent = 6 },
				{ class = "Rags", percent = 5 },
				{ class = "PropaneHeaterTop", percent = 8 },
				{ class = "Rope", percent = 6 },
				{ class = "SawBlade", percent = 5 },
				-- Waiting on https://entrada.atlassian.net/browse/MIS-3150
				-- { class = "SolarPanelPiece", percent = 4 },
				{ class = "TargetPaper", percent = 4 },
				{ class = "Tarp", percent = 5 },
				{ class = "WorkLight", percent = 5 },
				{ class = "Hacksaw", percent = 7},
			},
		},

		{
			category = "RandomPaintCan",
			classes =
			{
				{ class = "PaintCan_Aqua", percent = 8 },
				{ class = "PaintCan_Black", percent = 8 },
				{ class = "PaintCan_Blue", percent = 8 },
				{ class = "PaintCan_Brown", percent = 8 },
				{ class = "PaintCan_Gold", percent = 6 },
				{ class = "PaintCan_Green", percent = 8 },
				{ class = "PaintCan_Orange", percent = 8 },
				{ class = "PaintCan_Pink", percent = 8 },
				{ class = "PaintCan_Purple", percent = 8 },
				{ class = "PaintCan_Red", percent = 8 },
				{ class = "PaintCan_Silver", percent = 6 },
				{ class = "PaintCan_White", percent = 8 },
				{ class = "PaintCan_Yellow", percent = 8 },
			},
		},


		-- Forest stuff (that isnt actionable, so no sticks/rocks as those are now handled through awm)
		{
			category = "RandomForest",
			classes =
			{
				{ category = "RandomMushroom", percent = 100 },
			},
		},


		-- Fuel
		{
			category = "RandomFuel",
			classes =
			{
				{ class = "JerryCanDiesel", percent = 90 },
				{ class = "PropaneTank", percent = 8 },
				{ class = "small_generator", percent = 2 },
			},
		},


		-- Lubricant
		{
			category = "RandomLubricant",
			classes =
			{
				{ class = "Oil", percent = 100 },
			},
		},


		-- Gnomes
		{
			category = "RandomGnome",
			classes =
			{
				{ class = "gnome_bronze", percent = 2 },
				{ class = "gnome_creep", percent = 10 },
				{ class = "gnome_gold", percent = 1 },
				{ class = "gnome_silver", percent = 2 },
				{ class = "gnome_standard_a", percent = 4 },
				{ class = "gnome_standard_b", percent = 4 },
				{ class = "gnome_standard_c", percent = 4 },
				{ class = "jerry", percent = 6 },
				{ class = "painting_landscape_01", percent = 4 },
				{ class = "painting_landscape_02", percent = 3 },
				{ class = "painting_landscape_03", percent = 3 },
				{ class = "painting_landscape_04", percent = 3 },
				{ class = "painting_landscape_05", percent = 3 },
				{ class = "painting_landscape_06", percent = 3 },
				{ class = "painting_landscape_07", percent = 3 },
				{ class = "painting_landscape_08", percent = 3 },
				{ class = "painting_landscape_09", percent = 3 },
				{ class = "painting_landscape_10", percent = 3 },
				{ class = "painting_square_01", percent = 4 },
				{ class = "painting_square_02", percent = 3 },
				{ class = "painting_vertical_landscape_01", percent = 3 },
				{ class = "painting_vertical_landscape_02", percent = 3 },
				{ class = "painting_vertical_landscape_03", percent = 3 },
				{ class = "painting_vertical_landscape_04", percent = 3 },
				{ class = "painting_vertical_landscape_05", percent = 3 },
				{ class = "painting_map_canyonlands", percent = 3 },
				{ class = "poster_vertical_01", percent = 3 },
				{ class = "painting_map", percent = 5 },
				{ category = "RandomEggs", percent = 3 },
				--{ class = "CupidArrowx8", percent = 3 }, --
				--{ class = "flower_vase", percent = 3 }, -- Vday Items
				--{ class = "heart_candle", percent = 3 }, --
				--{ class = "heart_balloon", percent = 3 }, --
				--{ category = "halloweenBagCommon", percent = 2 },-- halloween
				--{ category = "RandomChristmasPresent", percent = 2 },-- Christmas event
			},
		},

		-- Basebuilding Items
		{
			category = "RandomBPart", 
			classes =
			{
				{ category = "RandomCampingBPart", percent = 99 },
				{ category = "RandomGnome", percent = 1 },
			},
		},

		-- Camping basebuilding Items
		
		{
			category = "RandomCampingBPart", 
			classes =
			{
				{ class = "camping_chair", percent = 20 },
				{ class = "propane_heater", percent = 5 },
				{ class = "camping_lantern", percent = 10 },
				{ class = "HeatPack", percent = 20 },
				{ class = "camping_pop_up_canopy", percent = 15 },
				{ class = "camping_table", percent = 15 },
				{ class = "camping_water_jug", percent = 15 },
			},
		},

		-- ====================================================================
		-- MORE ADVANCED CATEGORIES
		-- ====================================================================

		{
			category = "RandomExplosiveBarrel",
			classes =
			{
				{ class = "ExplosiveOilBarrel", percent = 100 },
			},
		},

		{
			category = "RandomExplosivePropaneTank",
			classes =
			{
				{ class = "PropaneTank", percent = 100 },
			},
		},

		{
			category = "RandomMelee",
			classes =
			{
				{ category = "RandomCamoClothes", percent = 6 },
				{ category = "RandomFlashlight", percent = 5 },
				{ class = "Axe", percent = 7.9 },
				{ class = "AxePatrick", percent = 0.1 },
				{ class = "BaseballBat", percent = 6.5 },
				{ class = "BaseballBatNails", percent = 1 },
				{ class = "BaseballBatSawBlade", percent = 1 },
				{ class = "BaseballBatSawBladeNails", percent = 1 },
				{ class = "BaseballBatScrapNails", percent = 1 },
				{ class = "BaseballBatHerMajesty", percent = 0.5 },
				{ class = "Cleaver", percent = 2 },
				{ class = "Crowbar", percent = 3 },
				{ class = "Guitar", percent = 2 },
				{ class = "Hammer", percent = 9 },
				{ class = "Hatchet", percent = 10 },
				{ class = "HuntingKnife", percent = 7 },
				{ class = "Katana", percent = 0.9 },
				{ class = "KatanaBlackWidow", percent = 0.1 },
				{ class = "LugWrench", percent = 8 },
				{ class = "Machete", percent = 6 },
				{ class = "StunBaton", percent = 2 },
				{ class = "MannequinArm", percent = 1 },
				{ class = "Pickaxe", percent = 8 },
				{ class = "PipeWrench", percent = 1 },
				{ class = "PoliceBaton", percent = 5 },
				{ class = "SurvivalKnife", percent = 4.5 },
				{ class = "TrapBearTrapPacked", percent = 0.5 },
			},
		},

		{
			category = "RandomSqueegee",
			classes =
			{
				{ class = "Squeegee", percent = 100 },
			},
		},

		-- largly based on random ranged weapon, rest from crafted
		{
			category = "RandomWeaponRepairKit",
			classes =
			{
				{ class = "RK_AA12", percent = 0.1 },
				{ class = "RK_ACAW", percent = 1 },
				{ class = "RK_AK74U", percent = 1 },
				{ class = "RK_AKM", percent = 1.01 },
				{ class = "RK_AP85", percent = 1 },
				{ class = "RK_AT15", percent = 2 },
				{ class = "RK_AUMP45", percent = 1.5 },
				{ class = "RK_Bulldog", percent = 1 },
				{ class = "RK_ColtPython", percent = 9 },
				{ class = "RK_Crossbow", percent = 4 },
				{ class = "RK_CX4Storm", percent = 1 },
				--{ class = "RK_DT12", percent = 1 },
				{ class = "RK_FlareGun", percent = 3 },
				{ class = "RK_G18Pistol", percent = 4 },
				{ class = "RK_hk45", percent = 6 },
				{ class = "RK_KrissV", percent = 1 },
				{ class = "RK_M16", percent = 1.5 },
				{ class = "RK_m1911a1", percent = 7 },
				{ class = "RK_M249", percent = 0.01 },
				{ class = "RK_M40A5", percent = 0.48 },
				{ class = "RK_M9A1", percent = 1 },
				{ class = "RK_Makarov", percent = 1 },
				{ class = "RK_MeleePrimary", percent = 5 },
				{ class = "RK_MeleeSecondary", percent = 5 },
				{ class = "RK_Mk18", percent = 1.5 },
				{ class = "RK_Model70", percent = 4 },
				{ class = "RK_MP5", percent = 1 },
				{ class = "RK_P350", percent = 1.5 },
				{ class = "RK_PX4", percent = 1.5 },
				{ class = "RK_R90", percent = 1 },
				{ class = "RK_RecurveBow", percent = 3 },
				{ class = "RK_Rem700", percent = 2.5 },
				{ class = "RK_Rem870", percent = 4 },
				{ class = "RK_ruger22", percent = 5 },
				{ class = "RK_Sako_85", percent = 2 },
				{ class = "RK_Shotgun870Tactical", percent = 5.5 },
				{ class = "RK_TranquilizerGun", percent = 5 },
				{ class = "RK_Wasteland22", percent = 4.9 },
			},
		},

		{
			category = "RandomNormalRepairKit",
			classes =
			{
				{ class = "RK_Canvas", percent = 20 },
				{ class = "RK_Cloth", percent = 38 },
				{ class = "RK_ClothingHelmet", percent = 10 },
				{ class = "RK_ClothingHelmetBallistic", percent = 2 },
				{ class = "RK_Equipment", percent = 10 },
				{ class = "RK_Leather", percent = 15 },
				{ class = "RK_Teflon", percent = 5 },
			},
		},

		{
			category = "RandomCraftedWeaponPure",
			classes = 
			{
				{ class = "CraftedBow", percent = 17 },
				{ class = "CraftedPistol", percent = 17 },
				{ class = "CraftedRifleLong", percent = 10 },
				{ class = "CraftedSMG", percent = 5 },
				{ class = "CraftedLongPistol", percent = 12 },
				{ class = "CraftedPistol556", percent = 9 },
				{ class = "CraftedRifle9mm", percent = 5 },
				{ class = "CraftedShortRifle556", percent = 5 },
				{ class = "CraftedShortShotgun", percent = 10 },
				{ class = "CraftedShotgun", percent = 10 },
			},
		},
		
		{
			category = "RandomDesertItems",
			classes = 
			{
				{ class = "Model1873", percent = 9 },
				{ class = "Peacemaker", percent = 10 },
				{ class = "ScavengerPants", percent = 40 },
				{ class = "ScavengerShirt", percent = 40 },
				{ class = "ScavengerHelmet", percent = 1 },
			},
		},

		{
			category = "RandomRangedPure",
			classes =
			{
				-- { category = "RandomCraftedWeaponPure", percent= 8 },
				{ class = "AA12", percent = 0.1 },
				{ class = "ACAW", percent = 0.5 },
				{ class = "AK74U", percent = 1 },
				{ class = "AKM", percent = 0.5 },
				{ class = "AKMGold", percent = 0.01 },
				{ class = "AP85", percent = 1 },
				{ class = "AT15", percent = 2 },
				{ class = "AUMP45", percent = 1.9 },
				{ class = "Bulldog", percent = 1 },
				{ class = "ColtPython", percent = 8.9 },
				{ class = "ColtPythonGrimeyRick", percent = 0.1 },
				{ class = "CraftedBow", percent = 0.5 },
				{ class = "CraftedPistol", percent = 0.5 },
				{ class = "CraftedRifleLong", percent = 0.5 },
				{ class = "CraftedSMG", percent = 0.5 },
				{ class = "CraftedLongPistol", percent = 1 },
				{ class = "CraftedPistol556", percent = 1 },
				{ class = "CraftedRifle9mm", percent = 1 },
				{ class = "CraftedShortRifle556", percent = 1 },
				{ class = "CraftedShortShotgun", percent = 1 },
				{ class = "CraftedShotgun", percent = 1 },
				{ class = "Crossbow", percent = 2 },
				{ class = "CX4Storm", percent = 0.8 },
				{ class = "FlareGun", percent = 2 },
				{ class = "G18Pistol", percent = 2 },
				{ class = "hk45", percent = 2 },
				{ class = "KrissV", percent = 1 },
				{ class = "M16", percent = 1.5 },
				{ class = "m1911a1", percent = 7 },
				{ class = "M249", percent = 0.01 },
				{ class = "M40A5", percent = 0.48 },
				{ class = "M9A1", percent = 0.5 },
				{ class = "Makarov", percent = 0.5 },
				{ class = "Mk18", percent = 2.48 },
				{ class = "Mk18Reaver", percent = 0.02 },
				{ class = "Model70", percent = 2.7 },
				{ class = "MP5", percent = 3 },
				{ class = "P350", percent = 2 },
				{ class = "PX4", percent = 2 },
				{ class = "R90", percent = 2.6 },
				{ class = "RecurveBow", percent = 2 },
				{ class = "Rem700", percent = 3.5 },
				{ class = "Rem870", percent = 5 },
				{ class = "ruger22", percent = 4 },
				{ class = "Sako_85", percent = 2 },
				{ class = "Shotgun870Tactical", percent = 3 },
				{ class = "TranquilizerGun", percent = 3 },
				{ class = "Wasteland22", percent = 4.9 },
				{ class = "AKVal", percent = 3 },
				{ class = "SAS12", percent = 3 },
				{ class = "MAK10", percent = 3 },
				{ class = "AK5D", percent = 3 },
				{ class = "M97", percent = 1 },
			},
		},
		
		{
			category = "RandomRangedCivilianPure",
			classes =
			{
				{ class = "AT15", percent = 7 },
				{ class = "Crossbow", percent = 7 },
				{ class = "CX4Storm", percent = 8 },
				{ class = "Model70", percent = 8 },
				{ class = "RecurveBow", percent = 9 },
				{ class = "Rem700", percent = 8 },
				{ class = "Rem870", percent = 8 },
				{ class = "Sako_85", percent = 9 },
				{ class = "Shotgun870Tactical", percent = 7 },
				{ class = "Wasteland22", percent = 8 },
				{ class = "AA12", percent = 2 },
				{ class = "SAS12", percent = 5 },
				{ class = "AK5D", percent = 5 },
				{ class = "MAK10", percent = 3 },
				{ category = "RandomAccessory", percent = 3 },
			},
		},
		
		{
		    category = "RandomRangedMilitaryPure",
			classes =
			{
				{ class = "AA12", percent = 4 },
				{ class = "ACAW", percent = 3 },
				{ class = "AK74U", percent = 6 },
				{ class = "AKM", percent = 3 },
				{ class = "AT15", percent = 4 },
				{ class = "AUMP45", percent = 4 },
				{ class = "Bulldog", percent = 4 },
				{ class = "CX4Storm", percent = 4 },
				{ class = "KrissV", percent = 4 },
				{ class = "M16", percent = 4 },
				{ class = "M249", percent = 5 },
				{ class = "M40A5", percent = 4 },
				{ class = "Mk18", percent = 4 },
				{ class = "MP5", percent = 4 },
				{ class = "R90", percent = 6 },
				{ class = "Shotgun870Tactical", percent = 4 },
				{ class = "AKMGold", percent = 1 },
				{ class = "ColtPythonGrimeyRick", percent = 1 },
				{ class = "Mk18Reaver", percent = 1 },
				{ class = "AKVal", percent = 5 },
				{ class = "SAS12", percent = 6 },
				{ class = "AK5D", percent = 6 },
				{ class = "MAK10", percent = 5 },
				{ class = "M97", percent = 1 },
				{ category = "RandomAccessory", percent = 3 },
			},
		},
		
		{
		    category = "RandomRangedPolicePure",
			classes =
			{
				{ class = "ACAW", percent = 8 },
				{ class = "AT15", percent = 7 },
				{ class = "AUMP45", percent = 8 },
				{ class = "CX4Storm", percent = 8 },
				{ class = "MP5", percent = 8 },
				{ class = "R90", percent = 14 },
				{ class = "Shotgun870Tactical", percent = 6 },
				{ class = "AKMGold", percent = 1 },
				{ class = "ColtPythonGrimeyRick", percent = 1 },
				{ class = "Mk18Reaver", percent = 1 },
				{ class = "AKVal", percent = 7 },
				{ class = "SAS12", percent = 7 },
				{ class = "AK5D", percent = 10 },
				{ class = "MAK10", percent = 6 },
				{ class = "M97", percent = 1 },
				{ category = "RandomAccessory", percent = 3 },
			},
		},
		
		{
		    category = "RandomMilitaryArmor",
			classes =
			{
				{ class = "FlakVestGreen", percent = 25 },
				{ class = "FlakVestGreenCamo1", percent = 25 },
				{ class = "FlakVestTan", percent = 25 },
				{ class = "FlakVestTanCamo1", percent = 25 },
			},
		},
		
		{
		    category = "RandomPoliceArmor",
			classes =
			{
				{ class = "PoliceVestBlack", percent = 33 },
				{ class = "PoliceVestBlue", percent = 33 },
				{ class = "SwatHelmet", percent = 34 },
				
			},
		},

		{
			category = "RandomRanged",
			classes =
			{
				{ category = "RandomRangedPure", percent = 86 },
				{ category = "RandomWeaponRepairKit", percent = 10 },
				{ category = "RandomCamoClothes", percent = 4 },
			},
		},

		{
			category = "RandomPistol",
			classes =
			{
				{ class = "ColtPython", percent = 9.9 },
				{ class = "ColtPythonGrimeyRick", percent = 0.1 },
				{ class = "FlareGun", percent = 9 },
				{ class = "G18Pistol", percent = 9 },
				{ class = "hk45", percent = 9 },
				{ class = "ruger22", percent = 9 },
				{ class = "Makarov", percent = 9 },
				{ class = "M9A1", percent = 9 },
				{ class = "m1911a1", percent = 9 },
				{ class = "PX4", percent = 9 },
				{ class = "P350", percent = 9 },
				{ class = "AP85", percent = 9 },
			},
		},

		{
			category = "RandomAccessory",
			classes =
			{
				{ class = "HuntingScope", percent = 5 },
				{ class = "LaserSight", percent = 9 },
				{ class = "LaserSightGreen", percent = 4 },
				{ class = "LaserSightBlue", percent = 4 },
				{ class = "OpticScope", percent = 9 },
				{ class = "OpticScopeBow", percent = 4 },
				{ class = "PistolSilencer", percent = 2 },
				{ class = "ReflexSight", percent = 8 },
				{ class = "T1Micro", percent = 8 },
				{ class = "ReflexSightBow", percent = 4 },
				{ class = "RifleSilencer", percent = 2 },
				{ class = "ForegripVertical", percent = 4 },
				{ class = "BayonetRifle", percent = 5 },
				{ class = "IronsightKit", percent = 5 },
				{ class = "ReddotSight", percent = 10 },
				{ class = "FlashlightMounted", percent = 7 },
			},
		},
		
		{
			category = "RandomEggs",
			classes =
			{
				{ class = "EggBlue", percent = 43, min = 1, max = 5 },
				{ class = "EggGreen", percent = 33, min = 1, max = 5 },
				{ class = "EggPink", percent = 24, min = 1, max = 5 },
			},
		},

		{
			category = "RandomAmmo",
			classes =
			{
				{ category = "12GaugeAA12Mags", percent = 1 },
				{ category = "12GaugeShells", percent = 4 },
				{ category = "9mmMagazine", percent = 2 },
				{ category = "RandomAccessory", percent = 3 },
				{ category = "RandomChemlight", percent = 2 },
				{ category = "RandomSmokeGrenade", percent = 2 },
				{ class = "545x30", percent = 2 },
				{ class = "57x50", percent = 2 },
				{ class = "762x5", percent = 2 },
				{ class = "9mmx10_makarov", percent = 2 },
				{ class = "9mmx15_m9a1", percent = 2 },
				{ class = "9mmx19_ap85", percent = 1 },
				{ class = "acp_45x20", percent = 2 },
				{ class = "acp_45x30", percent = 2 },
				{ class = "10mmx15", percent = 2 },
				{ class = "10mmx30", percent = 2 },
				{ class = "22x10_ruger", percent = 2 },
				{ class = "acp_45x10_hk", percent = 2 },
				{ class = "acp_45x7", percent = 3 },
				{ class = "762x30", percent = 3 },
				{ class = "Arrowx8", percent = 2.5 },
				--{ class = "CupidArrowx8", percent = 2.5 }, vday
				{ class = "Boltx5_0000", percent = 2 },
				{ class = "M40x5", percent = 0.99 },
				{ class = "556x100", percent = 0.01 },
				{ class = "Pile_10mm", percent = 2 },
				{ class = "Pile_22", percent = 2 },
				{ class = "Pile_545x39", percent = 2 },
				{ class = "Pile_57x28", percent = 2 },
				{ class = "Pile_223", percent = 3 },
				{ class = "Pile_308", percent = 3 },
				{ class = "Pile_357", percent = 3 },
				{ class = "Pile_45ACP", percent = 3 },
				{ class = "Pile_556x45", percent = 3 },
				{ class = "Pile_762x39", percent = 2 },
				{ class = "Pile_762x51", percent = 2 },
				{ class = "Pile_9mm", percent = 3.5 },
				{ class = "Pile_Flare", percent = 3.5 },
				{ class = "Pile_TranquilizerDart", percent = 3 },
				{ class = "STANAGx30", percent = 2 },
				{ class = "556x30_ak5d", percent = 2 },
				{ class = "762x20_Akval", percent = 2 },
				{ class = "9x19_mac10", percent = 2 },
				{ class = "Pile_40mmGrenade", percent = 0.3 },
			},
		},

		{
			category = "RandomWeaponWithMagsPure",
			classes =
			{
				{ category = "AA12WithMagazines", percent = 0.15 },
				{ category = "AKMWithMagazines", percent = 0.4 },
				{ category = "AK74UWithMagazines", percent = 1.6 },
				{ category = "AP85WithMagazines", percent = 1 },
				{ category = "AT15WithMagazines", percent = 2 },
				{ category = "BulldogWithMagazines", percent = 1 },
				{ category = "ColtPytonWithRounds", percent = 5 },
				{ category = "CraftedPistolWithMagazines", percent = 3 },
				{ category = "CraftedSMGWithMagazines", percent = 1 },
				{ category = "CraftedBowWithMagazines", percent = 3 },
				{ category = "CraftedRifleWithMagazines", percent = 2 },
				{ category = "CrossbowWithMagazines", percent = 3 },
				{ category = "FlareGunWithRounds", percent = 3 },
				{ category = "G18PistolWithMagazines", percent = 3 },
				{ category = "HK45WithMagazines", percent = 3 },
				{ category = "KrissVWithMagazines", percent = 0.5 },
				{ category = "M16WithMagazines", percent = 1 },
				{ category = "M1911WithMagazines", percent = 4 },
				{ category = "M249WithMagazines", percent = 0.05 },
				{ category = "M40A5WithMagazines", percent = 0.5 },
				{ category = "Mk18WithMagazines", percent = 2 },
				{ category = "Model70WithRounds", percent = 3 },
				{ category = "MP5WithMagazines", percent = 1 },
				{ category = "P350WithMagazines", percent = 1 },
				{ category = "PX4WithMagazines", percent = 1 },
				{ category = "RecurveBowWithMagazines", percent = 3 },
				{ category = "Rem700WithRounds", percent = 3 },
				{ category = "Rem870WithRounds", percent = 4.8 },
				{ category = "Ruger22WithMagazines", percent = 4.5 },
				{ category = "Sako85WithRounds", percent = 2.5 },
				{ category = "Shotgun870TacticalWithMagazines", percent = 5 },
				{ category = "TranquilizerGunWithDarts", percent = 5 },
				{ category = "Wasteland22WithRounds", percent = 5 },
				{ category = "AkValWithMagazines", percent = 5 },
				{ category = "SAS12WithRounds", percent = 5 },
				{ category = "AK5DWithMagazines", percent = 5 },
				{ category = "MAK10WithRounds", percent = 4 },
				{ category = "M97WithRounds", percent = 2 },
			},
		},

		{
			category = "RandomAmmoBox",
			classes =
			{
				{ class = "AmmoBox_10mm", percent = 8, min = 30, max = 60 },
				{ class = "AmmoBox_22", percent = 8, min = 30, max = 60 },
				{ class = "AmmoBox_308", percent = 8, min = 30, max = 60 },
				{ class = "AmmoBox_357", percent = 8, min = 30, max = 60 },
				{ class = "AmmoBox_223", percent = 9, min = 30, max = 60 },
				{ class = "AmmoBox_5_45x39", percent = 8, min = 30, max = 60 },
				{ class = "AmmoBox_5_56x45", percent = 9, min = 30, max = 60 },
				{ class = "AmmoBox_5_70x28", percent = 8, min = 30, max = 60 },
				{ class = "AmmoBox_7_62x39", percent = 9, min = 30, max = 60 },
				{ class = "AmmoBox_7_62x51", percent = 8, min = 30, max = 60 },
				{ class = "AmmoBox_9mm", percent = 9, min = 30, max = 60 },
				{ class = "AmmoBox_acp_45", percent = 8, min = 30, max = 60 },
			},
		},

		{
			category = "RandomWeaponWithMags",
			classes =
			{
				{ category = "RandomWeaponWithMagsPure", percent = 85 },
				{ category = "RandomWeaponRepairKit", percent = 15 },
			},
		},

		{
			category = "RandomWeapon",
			classes =
			{
				{ category = "RandomMelee", percent = 65 },
				{ category = "RandomRanged", percent = 20 },
				{ category = "RandomWeaponWithMags", percent = 15 },
			},
		},

		{
			category = "RandomSeeds",
			classes =
			{
				{ class = "SeedsBeets", percent = 12 },
				{ class = "SeedsBrushPeas", percent = 13 },
				{ class = "SeedsCarrots", percent = 12 },
				{ class = "SeedsPotatoes", percent = 11 },
				{ class = "SeedsWatermelons", percent = 6 },
				{ class = "SeedsPumpkins", percent = 11 },
				{ class = "SeedsRadishes", percent = 12 },
				{ class = "SeedsSnapPeas", percent = 12 },
				{ class = "SeedsTomatoes", percent = 11 },
			},
		},

		-- Actionable contents (note that the actual chance of something being present is controlled in ActionableWorldManager.lua)

		{
			category = "RandomAppleTreeContent",
			classes =
			{
				{ class = "AppleFresh", percent = 85 },
				{ class = "AppleRotten", percent = 15 },
			},
		},
		
		{
			category = "RandomCactiContent",
			classes =
			{
				{ class = "PricklyPear", percent = 60 },
				{ class = "PricklyPearRotten", percent = 40 },
			},
		},

		{
			category = "RandomBeehiveContent",
			classes =
			{
				{ class = "Honeycomb", percent = 100 },
				-- { class = "QueenBee", percent = 5 },
			},
		},

		{
			category = "RandomCouchContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 5 },
				{ category = "RandomAmmo", percent = 45 },
				{ category = "RandomMedical", percent = 20 },
				{ class = "Rags", percent = 15 },
				{ class = "HersheysBar", percent = 14 },
				{ class = "MagliteSmall", percent = 1 },
			},
		},

		{
			category = "CheckoutContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 100 },
			},
		},

		{
			category = "SmallHidingPlaceContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 10 },
				{ category = "RandomTrashContent", percent = 30 },
				{ category = "RandomAccessory", percent = 20 },
				{ category = "RandomCraftingGuide", percent = 40 },
			},
		},

		{
			category = "MediumHidingPlaceContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 10 },
				{ category = "RandomAmmo", percent = 10 },
				{ category = "RandomCraftingGuide", percent = 30 },
				{ category = "RandomAccessory", percent = 40 },
				{ category = "RandomPistol", percent = 10 },
			},
		},

		{
			category = "RandomToolboxContent",
			classes =
			{
				{ category = "RandomWeaponRepairKit", percent = 4 },
				{ category = "RandomToolRepairKit", percent = 6 },
				{ class = "Nails", percent = 53 },
				{ class = "DuctTape", percent = 10 },
				{ class = "PipeMetal", percent = 5 },
				{ class = "Hammer", percent = 10 },
				{ class = "LugWrench", percent = 10 },
				{ class = "Sledgehammer", percent = 0.3 },
				{ class = "RK_Sledgehammer", percent = 0.3 },

				
			},
		},
		
		{
			category = "RandomToolRepairKit",
			classes =
			{
				{ class = "RK_MeleePrimary", percent = 49 },
				{ class = "RK_MeleeSecondary", percent = 50 },
				
			},
		},

		{
			category = "RandomDrinkVendingMachineContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ class = "CokeCan", percent = 28 },
				{ class = "DrPepperCan", percent = 10 },
				{ class = "EnergyDrinkCan", percent = 10 },
				{ class = "PepsiCan", percent = 20 },
				{ class = "SpriteCan", percent = 10 },
				{ class = "WaterBottle", percent = 20 },
			},
		},

		{
			category = "RandomStoveContent",
			classes =
			{
				{ category = "RandomRottenMeat", percent = 50 },
				{ category = "RandomBurnedMeat", percent = 50 },
			},
		},

		{
			category = "RandomFridgeContent",
			classes =
			{
				{ category = "RandomConsumable", percent = 40 },
				{ category = "RandomRottenVeggie", percent = 20 },
				{ category = "RandomRottenMeat", percent = 40 },
			},
		},

		{
			category = "RandomTrashContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomCraftingGuide", percent = 5 },
				{ category = "RandomRottenVeggie", percent = 6 },
				{ category = "RandomRottenMeat", percent = 6 },
				{ category = "RandomBurnedMeat", percent = 3 },
				{ class = "EmptyBottle", percent = 26 },
				{ class = "Rags", percent = 5 },
				{ class = "BalaclavaBlack", percent = 5 },
				{ class = "Rope", percent = 10 },
				{ class = "DuctTape", percent = 17 },
				{ class = "PipeMetal", percent = 5 },
				{ category = "RandomSeeds", percent = 10 },
			},
		},

		{
			category = "RandomCommercialCrateContent",
			classes =
			{
				{ category = "RandomMaintenance", percent = 10 },
				{ category = "RandomSeeds", percent = 5 },
				{ category = "RandomCampingBPart", percent = 15 },
				{ category = "RandomNormalRepairKit", percent = 5 },
				{ category = "RandomWeaponRepairKit", percent = 5 },
				{ category = "RandomFuel", percent = 15 },
				{ class = "small_generator", percent = 8 },
				{ class = "powered_generator_small", percent = 2 },
				{ class = "Wheel", percent = 20 },
				{ class = "WorkLight", percent = 15 },
			},
		},

		{
			category = "RandomMilitaryFootlockerContent",
			classes =
			{
				--{ category = "RandomChristmasPresent", percent = 2 },-- Christmas event
				--{ category = "halloweenBagCommon", percent = 2 },--
				{ category = "RandomEggs", percent = 2 },
				{ category = "RandomMilitaryClothing", percent = 6 },
				{ category = "RandomWeaponRepairKit", percent = 5 },
				{ category = "RandomMedical", percent = 5 },
				{ category = "RandomHospitalBandage", percent = 1 },
				{ category = "RandomMilitaryGrenade", percent = 3 },
				{ category = "RandomAccessory", percent = 5 },
				{ category = "RandomCraftingGuide", percent = 4 },
				{ class = "AmcoinLedger", percent = 3 },
				{ class = "Amalgaduino", percent = 2 },
				{ class = "MilitaryCanteenPlastic", percent = 3 },
				{ class = "GasMask", percent = 2 },
				{ class = "MilitaryCanteenMetal", percent = 2 },
				{ class = "MagliteSmall", percent = 2 },
				{ class = "Maglite", percent = 5 },
				{ class = "MRE", percent = 8 },
				{ class = "Cb_radio", percent = 5 },
				{ category = "GridMap_level", percent = 5 },
				{ class = "Binoculars", percent = 2 },
				{ class = "SurvivalKnife", percent = 3 },
				{ class = "HeatPack", percent = 5 },
				{ class = "WaterPurificationTablets", percent = 1 },
			},
		},

		{
			category = "RandomMilitaryFootlockerIronSonsContent",
			classes =
			{
				{ category = "RandomArmorTier3", percent = 2 },
				{ category = "RandomArmorTier2", percent = 5 },
				{ category = "RandomArmorTier1", percent = 8 },
				{ category = "RandomAmmo", percent = 9 },
				{ category = "RandomEggs", percent = 2 },
				--{ category = "RandomChristmasPresent", percent = 3 },-- Christmas event
				--{ category = "halloweenBagCommon", percent = 3 },-- halloween
				{ category = "RandomRangedPure", percent = 24 },
				{ category = "RandomAmmoBox", percent = 6 },
				{ category = "RandomAccessory", percent = 5 },
				{ category = "RandomMilitaryFootlockerContent", percent = 14 },
			},
		},

		{
			category = "RandomMilitaryDeskContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 3 },
				{ class = "Amalgaduino", percent = 2 },
				{ category = "RandomAccessory", percent = 10 },
				{ category = "RandomCraftingGuide", percent = 5 },
				{ category = "RandomMedical", percent = 10 },
				{ category = "RandomHospitalBandage", percent = 1 },
				{ category = "RandomAmmo", percent = 14 },
				{ class = "Cb_radio", percent = 10 },
				{ class = "MagliteSmall", percent = 10 },
				{ category = "GridMap_level", percent = 19 },
				{ class = "WaterPurificationTablets", percent = 1 },
			},
		},

		{
			category = "RandomSwitchboardContent",
			classes =
			{
				{ category = "RandomElectronicsContent", percent = 15 },
				{ class = "Amalgaduino", percent = 25 },
				{ class = "Cb_radio", percent = 10 },
				{ class = "MagliteSmall", percent = 20 },
				{ class = "DuctTape", percent = 5 },
				{ class = "PipeMetal", percent = 5 },
				{ category = "RandomEyes", percent = 5 },
				{ category = "RandomTrashContent", percent = 15 },
			},
		},

		{
			category = "RandomLockerContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomClothes", percent = 67 },
				{ category = "RandomFireStarter", percent = 5 },
				{ category = "RandomNormalRepairKit", percent = 5 },
				{ category = "RandomWeaponRepairKit", percent = 5 },
				{ category = "RandomMedical", percent = 5 },
				{ category = "RandomTrashContent", percent = 5 },
				{ category = "RandomPistol", percent = 5 },
				{ class = "WaterPurificationTablets", percent = 1 },
			},
		},

		{
			category = "RandomSinkContent",
			classes =
			{
				{ category = "RandomNormalRepairKit", percent = 25 },
				{ category = "RandomMedical", percent = 15 },
				{ category = "RandomFireStarter", percent = 5 },
				{ category = "RandomTrashContent", percent = 5 },
				{ class = "PipeMetal", percent = 5 },
				{ category = "RandomCraftingGuide", percent = 3 },
				{ category = "RandomFlashlight", percent = 5 },
				{ class = "HeatPack", percent = 7 },
				{ class = "Rope", percent = 5 },
				{ class = "RubbingAlcohol", percent = 10 },
				{ class = "Oil", percent = 5 },
				{ class = "DuctTape", percent = 5 },
				{ class = "DogFoodCan", percent = 2.5 },
				--{ class = "CupidArrowx8", percent = 2.5 }, vday
			},
		},

		{
			category = "RandomDeskContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomCraftingGuide", percent = 2 },
				{ class = "Amalgaduino", percent = 1 },
				{ class = "HeatPack", percent = 5 },
				{ category = "RandomFireStarter", percent = 12 },
				{ class = "AppleRotten", percent = 5 },
				{ class = "HersheysBar", percent = 5 },
				{ category = "Map", percent = 5 },
				{ category = "RandomHands", percent = 10 },
				{ category = "RandomEyes", percent = 5 },
				{ category = "RandomAccessory", percent = 10 },
				{ category = "RandomMedical", percent = 10 },
				{ category = "RandomAmmo", percent = 5 },
				{ category = "RandomSeeds", percent = 5 },
				{ class = "WaterPurificationTablets", percent = 1 },
				--{ class = "CupidArrowx8", percent = 2 }, vday
			},
		},

		{
			category = "RandomKitchenContent",
			classes =
			{
				{ class = "HeatPack", percent = 8 },
				{ category = "RandomMedical", percent = 10 },
				{ category = "RandomWoolGloves", percent = 5 },
				{ category = "BandanaHat", percent = 2 },
				{ category = "RandomCraftingGuide", percent = 1 },
				{ category = "RandomAmmo", percent = 1 },
				{ class = "AmcoinLedger", percent = 1 },
				{ category = "RandomFood", percent = 12 },
				{ category = "RandomSeeds", percent = 10 },
				{ category = "RandomFireStarter", percent = 25 },
				{ category = "SaltAndPepper", percent = 25 },
			},
		},

		{
			category = "RandomHospitalClothesSmall",
			classes =
			{
				{ class = "DustMask", percent = 15 },
				{ class = "HazmatMask", percent = 20 },
				{ class = "GasMask", percent = 5 },
				{ category = "RandomEyes", percent = 5 },
				{ class = "FannyPackGray", percent = 5 },
				{ class = "FannyPackRed", percent = 10 },
				{ class = "FannyPackRedBlue", percent = 5 },
				{ class = "TshirtAmalgamatedBlue", percent = 10 },
				{ class = "SneakersWhite", percent = 10 },
				{ class = "HitopsBlue", percent = 5 },
				{ class = "WoolGlovesBlue", percent = 5 },
				{ class = "WoolGlovesWhite", percent = 5 },
			},
		},

		{
			category = "RandomHospitalClothes",
			classes =
			{
				{ category = "RandomHospitalClothesSmall", percent = 25 },
				{ category = "RandomClothes", percent = 10 },
				{ class = "HazmatSuitWhite", percent = 10 },
				{ class = "HazmatSuitBlue", percent = 10 },
				{ class = "GasCanisterPack", percent = 10 },
				{ class = "RainJacketOrangeBlue", percent = 5},
				{ class = "RainJacketYellow", percent = 5},
				{ class = "RainJacketRed", percent = 5},
				{ class = "ButtonUpShirtBlue", percent = 5},
				{ class = "ButtonUpShirtGrey", percent = 5},
				{ class = "CottonShirtBlue", percent = 5 },
				{ class = "CottonShirtTan", percent = 5 },
			},
		},

		{
			category = "RandomHospitalBandage",
			classes =
			{
				{ class = "Bandage", percent = 20 },
				{ class = "AntibioticBandage", percent = 30 },
				{ class = "AdvancedBandage", percent = 50 },
			},
		},

		{
			category = "RandomHospitalMedical",
			classes =
			{
				{ category = "RandomMedical", percent = 79 },
				{ category = "RandomHospitalBandage", percent = 20 },
				{ class = "guide_medical_bandages", percent = 1 },
			},
		},

		{
			category = "RandomHospitalContentSmall",
			classes =
			{
				{ category = "RandomHospitalMedical", percent = 51 },
				{ category = "RandomHospitalClothesSmall", percent = 30 },
				{ category = "RandomConsumable", percent = 5 },
				{ category = "RandomChemlight", percent = 2 },
				{ category = "RandomFireStarter", percent = 2 },
				{ class = "Cb_radio", percent = 5 },
				{ class = "MagliteSmall", percent = 2 },
				{ class = "Headlamp", percent = 2 },
				{ class = "HeadlampRed", percent = 1 },
			},
		},

		{
			category = "RandomHospitalContentMedium",
			classes =
			{
				{ category = "RandomHospitalContentSmall", percent = 50 },
				{ category = "RandomHospitalClothes", percent = 25 },
				{ class = "WaterBottle", percent = 10 },
				{ class = "camping_lantern", percent = 2 },
				{ class = "camping_water_jug", percent = 3 },
				{ class = "Hammer", percent = 3 },
				{ class = "Hatchet", percent = 2 },
				{ class = "StunBaton", percent = 3 },
				{ class = "SurvivalKnife", percent = 2 },
			},
		},

		{
			category = "RandomHospitalContentBig",
			classes =
			{
				{ category = "RandomHospitalContentMedium", percent = 65 },
				{ category = "RandomHospitalClothes", percent = 20 },
				{ class = "JerryCanDiesel", percent = 5 },
				{ class = "PropaneTank", percent = 5 },
				{ class = "WorkLight", percent = 3 },
				{ class = "small_generator", percent = 1.75 },
				{ class = "powered_generator_small", percent = 0.25 },
			},
		},

		{
			category = "RandomLivingAreaContent",
			classes =
			{
				{ category = "RandomAmmo", percent = 2 },
				{ category = "RandomPistol", percent = 2 },
				{ class = "AmcoinLedger", percent = 1 },
				{ category = "RandomCraftingGuide", percent = 1 },
				{ category = "RandomClothes", percent = 79 },
				{ category = "RandomNormalRepairKit", percent = 15 },
			},
		},

		{
			category = "RandomOfficeContent",
			classes =
			{
				{ category = "RandomAmmo", percent = 2 },
				{ category = "RandomPistol", percent = 2 },
				{ class = "AmcoinLedger", percent = 1 },
				{ category = "RandomTrashContent", percent = 95 },
			},
		},

		{
			category = "RandomSuitcaseContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomEyes", percent = 10 },
				{ category = "RandomTorso", percent = 38 },
				{ category = "RandomLegs", percent = 50 },
			},
		},

		{
			category = "RandomWashingContent",
			classes =
			{
				{ category = "RandomTorso", percent = 50 },
				{ category = "RandomLegs", percent = 50 },
			},
		},

		{
			category = "RandomFoodBoxContent",
			classes =
			{
				{ category = "RandomConsumable", percent = 100 },
			},
		},

		{
			category = "RandomElectronicsContent",
			classes =
			{
				{ class = "ElectricalParts", percent = 75 },
				{ class = "Amalgaduino", percent = 23 },
				{ class = "AmcoinLedger", percent = 2 },

			},
		},

		-- Air Drops
		{
			-- The cargo drop crate has 20 slots
			category = "RandomAirDropCrate",
			classes =
			{
				{ category = "RandomAirDropCratePolice", percent = 17 },
				{ category = "RandomAirDropCrateMilitary", percent = 16 },
				{ category = "RandomAirDropCrateCivilian", percent = 29 },
				{ category = "RandomAirDropCrateExplosives", percent = 4 },
				{ category = "RandomAirDropCrateBaseBuilding", percent = 17 },
				{ category = "RandomAirDropCrateRadiation", percent = 17 },
			},
		},
		
		{
			category = "AirDropSantaCrate",
			group =
			{
				{ category = "RandomChristmasClothing", percent = 100 },
				{ class = "ChristmasPresentCommon1", percent = 100 },
				{ class = "ChristmasPresentCommon1", percent = 100 },
				{ class = "ChristmasPresentCommon2", percent = 100 },
				{ class = "ChristmasPresentCommon2", percent = 100 },
				{ class = "ChristmasPresentRare", percent = 100 },
				{ class = "ChristmasPresentRare", percent = 100 },
				{ class = "ChristmasHat", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ class = "AmmoBox_357", percent = 100 },
				{ class = "ScavengerHelmet", percent = 100 },
				{ class = "Peacemaker", percent = 100 },
				{ class = "EggNog", percent = 100 },
				{ class = "EggNog", percent = 100 },
				{ class = "GingerBreadMan", percent = 100, min = 2, max = 5 },
				{ class = "GingerBreadMan", percent = 100, min = 2, max = 5 },
			},
		},
		
		{
			category = "RandomAirDropCrateMilitary",
			group =
			{
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ class = "M16", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "M9A1", percent = 100 },
				{ class = "9mmx15_m9a1", percent = 100 },
				{ class = "9mmx15_m9a1", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ category = "RandomMilitaryArmor", percent = 100 },
				{ category = "RandomMilitaryHelmet", percent = 100 },
				{ category = "RandomMilitaryJacket", percent = 100 },
				{ category = "RandomCargoPants", percent = 100 },
				--{ class = "GrenadePickup", percent = 100 },--
				--{ class = "GrenadeGasSleepPickup", percent = 100 },-- disabled for easter event
				--{ class = "MRE", percent = 100 },--
				{ class = "EggBlue", percent = 100, min = 1, max = 5 },
				{ class = "EggGreen", percent = 100, min = 1, max = 5 },
				{ class = "EggPink", percent = 100, min = 1, max = 5 },
				{ class = "C4TimedPickup", percent = 100, min = 1, max = 2 },
				{ class = "Bandage", percent = 100, min = 5, max = 5 },
				{ class = "DuffelBagGreen", percent = 100 },
			},
		},
		
		{
			category = "RandomAirDropCrateRadiation",
			group =
			{
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ class = "AUMP45", percent = 100 },
				{ class = "acp_45x30", percent = 100 },
				{ class = "acp_45x30", percent = 100 },
				{ class = "Pile_45ACP", percent = 100, min = 30, max = 30 },
				{ class = "Pile_45ACP", percent = 100, min = 30, max = 30 },
				{ class = "HazmatMask", percent = 100 },
				{ class = "HazmatSuitOrange", percent = 100 },
				{ class = "GasCanisterPack", percent = 100 },
				{ class = "AntiradiationPills", percent = 100, min = 3, max = 3 },
				{ class = "AntiradiationPills", percent = 100, min = 3, max = 3 },
				{ class = "MushroomAntiRad", percent = 100, min = 5, max = 5 },
				{ class = "PotassiumIodidePills", percent = 100, min = 3, max = 3 },
				{ class = "PotassiumIodidePills", percent = 100, min = 3, max = 3 },
				{ class = "WaterPurificationTablets", percent = 100, min = 3, max = 3 },
				--{ class = "MRE", percent = 100 },--
				--{ class = "MRE", percent = 100 },-- disabled for easter event
				--{ class = "MRE", percent = 100 },--
				{ class = "EggBlue", percent = 100, min = 1, max = 5 },
				{ class = "EggGreen", percent = 100, min = 1, max = 5 },
				{ class = "EggPink", percent = 100, min = 1, max = 5 },
				{ class = "MRE", percent = 100 },
				{ class = "MRE", percent = 100 },
			},
		},
		
		{
			category = "RandomAirDropCrateBaseBuilding",
			group =
			{
				{ class = "SheetMetal", percent = 100, min = 64, max = 64 },
				{ class = "SheetMetal", percent = 100, min = 64, max = 64 },
				{ class = "SheetMetal", percent = 100, min = 64, max = 64 },
				{ class = "SheetMetal", percent = 100, min = 64, max = 64 },
				{ class = "plated_wall_3m_4m", percent = 100, min = 5, max = 5 },
				{ class = "plated_wall_3m_4m", percent = 100, min = 5, max = 5 },
				{ class = "plated_walkway_3m_4m_4m", percent = 100, min = 5, max = 5 },
				{ class = "plated_walkway_3m_4m_4m", percent = 100, min = 5, max = 5 },
				{ class = "plated_door_lockable_1m_2m", percent = 100 },
				{ class = "plated_wall_door_3m_4m", percent = 100 },
				{ class = "plated_gate_lockable_3m_4m", percent = 100 },
				{ class = "plated_gatehouse", percent = 100 },
				{ class = "powered_generator_small", percent = 100 },
				{ class = "RuggedPack", percent = 100 },
				{ class = "guide_structures_wood_watchtower", percent = 100 },
				{ class = "guide_structures_wood_stairs_2", percent = 100 },
				{ class = "guide_structures_wood_walls_2", percent = 100 },
				{ class = "guide_structures_wood_walkways_2", percent = 100 },
				{ class = "guide_structures_wood_ramps_2", percent = 100 },
				{ class = "guide_structures_wood_bridges_2", percent = 100 },
			},
		},
		
		{
			category = "RandomAirDropCratePolice",
			group =
			{
				{ category = "RandomRangedPolicePure", percent = 100 },
				{ class = "AT15", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "PX4", percent = 100 },
				{ class = "acp_45x10_hk", percent = 100 },
				{ class = "acp_45x10_hk", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ category = "RandomPoliceArmor", percent = 100 },
				{ class = "SwatHelmet", percent = 100 },
				{ class = "TshirtPoliceBlue", percent = 100 },
				{ class = "CargoPantsBlack", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "GrenadeGasTearPickup", percent = 100 },
				--{ class = "MRE", percent = 100 },--
				--{ class = "MRE", percent = 100 },-- disabled for easter event
				--{ class = "Bandage", percent = 100, min = 5, max = 5 },--
				{ class = "EggBlue", percent = 100, min = 1, max = 5 },
				{ class = "EggGreen", percent = 100, min = 1, max = 5 },
				{ class = "EggPink", percent = 100, min = 1, max = 5 },
				{ class = "DuffelBagBlack", percent = 100 },
			},
		},
		
		{
			category = "RandomAirDropCrateCivilian",
			group =
			{
				{ category = "RandomRangedCivilianPure", percent = 100 },
				{ class = "CX4Storm", percent = 100 },
				{ class = "acp_45x20", percent = 100 },
				{ class = "acp_45x20", percent = 100 },
				{ class = "Makarov", percent = 100 },
				{ class = "9mmx10_makarov", percent = 100 },
				{ class = "9mmx10_makarov", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ class = "FootballPads", percent = 100 },
				{ category = "RandomCivilianHelmet", percent = 100 },
				{ category = "RandomRainJacket", percent = 100 },
				{ class = "RuckSack", percent = 100 },
				--{ class = "GrenadeMolotovPickup", percent = 100 },--
				{ class = "Gunpowder", percent = 100, min = 64, max = 64 },
				{ class = "Gunpowder", percent = 100, min = 64, max = 64 },
				--{ class = "AppleFresh", percent = 100, min = 5, max = 5 },--
				{ class = "PipebombPickup", percent = 100 },
				{ class = "EggBlue", percent = 100, min = 1, max = 5 },
				{ class = "EggGreen", percent = 100, min = 1, max = 5 },
				{ class = "EggPink", percent = 100, min = 1, max = 5 },
				--{ class = "Bandage", percent = 100, min = 5, max = 5 },--
			},
		},
		
		{
			category = "RandomAirDropCrateExplosives",
			group =
			{
				{ class = "C4Bricks", percent = 100, min = 5, max = 10 },
				{ class = "C4Bricks", percent = 100, min = 5, max = 10 },
				{ class = "Sulphur", percent = 100, min = 64, max = 64 },
				{ class = "Sulphur", percent = 100, min = 64, max = 64 },
				{ class = "GrenadeMolotovPickup", percent = 100 },
				{ class = "GrenadeMolotovPickup", percent = 100 },
				{ class = "ElectricalParts", percent = 100, min = 5, max = 10 },
				{ class = "Amalgaduino", percent = 100, min = 5, max = 10 },
				{ class = "guide_explosives_1", percent = 100 },
				{ class = "guide_explosives_2", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "PipebombPickup", percent = 100, min = 3, max = 3 },
				{ class = "C4TimedPickup", percent = 100, min = 2, max = 2 },
				{ class = "Gunpowder", percent = 100, min = 64, max = 64 },
				{ class = "Gunpowder", percent = 100, min = 64, max = 64 },
				{ class = "Gunpowder", percent = 100, min = 64, max = 64 },
				{ class = "Gunpowder", percent = 100, min = 64, max = 64 },
				{ class = "BioFuel", percent = 100, min = 64, max = 64 },
				{ class = "BioFuel", percent = 100, min = 64, max = 64 },
			},
		},

		{
			category = "RandomAirDropCrateSalt",
			group =
			{
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
				{ class = "Salt", percent = 100 },
			},
		},

		{
			category = "RandomAirDropCrateBandage",
			group =
			{
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
				{ class = "Bandage", percent = 100 },
			},
		},

		-- Air Plane Crash
		{
			category = "AirPlaneCrashBackpack",
			classes =
			{
				-- no stowpacks - only better backpacks
				{ category = "RandomRuggedPackAirPlane", percent = 40 },
				{ category = "RandomDuffelBagAirPlane", percent = 30 },
				{ category = "RandomRuckSackAirPlane", percent = 30 },
			},
		},

		{
			category = "AirPlaneCrashCrate",
			classes =
			{
				{ class = "WoodCrate", contents="RandomCrateAirPlaneContents", percent = 100 },
			},
		},
		
		{
			category = "UFOCrashCrate",
			classes =
			{
				{ class = "UFOCrate", contents="RandomUFOContents", percent = 100 },
			},
		},

		{
			category = "RandomBackpackAirPlaneContents",
			group =
			{
				-- Only up to 15 slots - civilian focused, no primary weapons
				{ category = "Map", percent = 100 },
				{ category = "RandomFlashlight", percent = 100 },
				{ category = "RandomConsumable", percent = 100 },
				{ category = "RandomMedical", percent = 100 },
				{ category = "RandomCraftingGuide", percent = 100 },
				{ category = "RandomClothes", percent = 100 },
				{ category = "RandomCrafting", percent = 100 },
				{ category = "RandomMaintenance", percent = 100 },
				{ category = "RandomAmmo", percent = 100 },
				{ category = "RandomPistol", percent = 100 },
			},
		},

		{
			category = "RandomCrateAirPlaneContents",
			group =
			{
				-- Only 10 slots in the crate - all military focused
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ category = "RandomMilitaryClothing", percent = 100 },
				{ category = "RandomMilitaryClothing", percent = 100 },
				{ category = "RandomMilitaryClothing", percent = 100 },
				{ category = "RandomMilitaryClothing", percent = 100 },
				{ class = "MRE", percent = 100 },
			},
		},
		
		{
			category = "RandomUFOContents",
			group =
			{
				-- Only 10 slots in the crate - EVENT BASED
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ class = "AmmoBox_357", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ class = "SpaceHelmet", percent = 100 },
				{ class = "ScavengerPants", percent = 100 },
				{ class= "ScavengerShirt", percent = 100 },
				{ class = "Model1873", percent = 100 },
				{ class = "SkullMaskGold", percent = 100 },
			},
		},

		-- recursion testing (start at Rec3 and work back to Rec1)
		{
			category = "Rec1",
			classes =
			{
				{ class = "HersheysBar", percent = 0.001 }, -- this is an *extremely* rare candy bar!!
				{ class = "PepsiCan", percent = 99.999 },
			},
		},
		
		{
            category = "RocksAndPyrite",
            classes =
            {
                { class = "Rocks", percent = 100 },
            },
        },
		
		{
            category = "IronAndRocks",
            classes =
            {
                { class = "Rocks", percent = 10 },
                { class = "IronOre", percent = 90 },
            },
        },
		
		{
            category = "CoalAndRocks",
            classes =
            {
                { class = "Rocks", percent = 10 },
                { class = "Charcoal", percent = 90 },
            },
        },
		
		{
            category = "PyriteAndRocks",
            classes =
            {
                { class = "Rocks", percent = 10 },
                { class = "Pyrite", percent = 90 },
            },
        },
		
		{
			category = "Rec2",
			classes =
			{
				{ category = "Rec1", percent = 100 },
			},
		},
		{
			category = "Rec3",
			classes =
			{
				{ category = "Rec2", percent = 100 },
			},
		},

		-- really rare testing (start at Rare3 and work back to Rare1)
		{
			category = "Rare1",
			classes =
			{
				{ class = "HersheysBar", percent = 0.001 }, -- this is an *extremely* rare candy bar (1 in 1,000,000,000)!! Golden ticket inside?
			},
		},
		{
			category = "Rare2",
			classes =
			{
				{ category = "Rare1", percent = 0.001 }, -- 1 in 1,000
			},
		},
		{
			category = "Rare3",
			classes =
			{
				{ category = "Rare2", percent = 0.001 }, -- 1 in 1,000
			},
		},
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function ItemSpawnerManager:OnInit()
	--Log("ItemSpawnerManager:OnInit");
	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function ItemSpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function ItemSpawnerManager:OnReset()
	--Log("ItemSpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function ItemSpawnerManager:OnSpawn()
	self:Reset();
end

function ItemSpawnerManager:Reset()
	--Log("ItemSpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/ism_mods", true, true)