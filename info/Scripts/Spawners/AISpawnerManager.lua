--Script.ReloadScript( "SCRIPTS/Entities/actor/BasicActor.lua");

AISpawnerManager = {

	aiCategories =
	{
		-- --------------------------------------------------------------------
		-- SINGLE AI
		-- Some of these are hard-coded in the AISpawnerManager
		-- Add mutants here with model variations and then reference them
		-- --------------------------------------------------------------------

		{
			category = "BruteMutantArmored",
			classes =
			{
				{
					class = "BruteMutant", percent = 100,
					models =
					{
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_armored.cdf", percent = 70.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_armored_dark.cdf", percent = 30.0 },
					},
				},
			},
		},

		{
			category = "BruteMutantSingle",
			classes =
			{
				{
					class = "BruteMutant", percent = 100,
					models =
					{
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_clothed_01.cdf", percent = 20.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_clothed_02.cdf", percent = 20.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_dark.cdf", percent = 10.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_clothed_01_dark.cdf", percent = 10.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_clothed_02_dark.cdf", percent = 10.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant.cdf", percent = 24.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_armored.cdf", percent = 3.0 },
						{ name = "objects/characters/mutants/brutemutant/brute_mutant_armored_dark.cdf", percent = 3.0 },
					},
				},
			},
		},

		{
			category = "HumanZombieSingle",
			classes =
			{
				{
					class = "HumanZombie", percent = 100,
					models =
					{
						{ name = "objects/characters/mutants/humanzombie/humanzombie.cdf", percent = 10.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_01.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_02.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_03.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_04.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_05.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_dark.cdf", percent = 10.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_01_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_02_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_03_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_04_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/mutants/humanzombie/humanzombie_clothed_05_dark.cdf", percent = 8.0 },
					},
				},
			},
		},

		{
			category = "SpikerSingle",
			classes =
			{
				{
					class = "Spiker", percent = 100,
					models =
					{
						{ name = "objects/characters/bandits/spiker/spiker.cdf", percent = 10.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_01.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_02.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_03.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_04.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_05.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_dark.cdf", percent = 10.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_01_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_02_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_03_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_04_dark.cdf", percent = 8.0 },
						{ name = "objects/characters/bandits/spiker/spiker_clothed_05_dark.cdf", percent = 8.0 },
					},
				},
			},
		},

		{
			category = "CrazySingle",
			classes =
			{
				-- add model variations
				{ class = "Crazy", percent = 100,
					models =
					{
						{ name = "objects/characters/bandits/crazy/crazy.cdf", percent = 25.0 },
						{ name = "objects/characters/bandits/crazy/crazy_prison.cdf", percent = 25.0 },
						{ name = "objects/characters/bandits/crazy/crazy_dark.cdf", percent = 25.0 },
						{ name = "objects/characters/bandits/crazy/crazy_prison_dark.cdf", percent = 25.0 },
					},
				},
			},
		},

		{
			category = "DeerSingle",
			classes =
			{
				{
					class = "Deer", percent = 100,
					models =
					{
						{ name = "objects/characters/animals/deer/deer.cdf", percent = 50.0 },
						{ name = "objects/characters/animals/deer/deer_female.cdf", percent = 50.0 },
					},
				},
			},
		},

		{
			category = "HumanSpiderSingle",
			classes =
			{
				{
					class = "HumanSpider", percent = 100,
					models =
					{
						{ name = "objects/characters/mutants/human_spider/human_spider.cdf", percent = 50.0 },
						{ name = "objects/characters/mutants/human_spider/human_spider_dark.cdf", percent = 50.0 },
					},
				},
			},
		},

		-- ====================================================================
		-- ANIMALS
		-- ====================================================================

		{
			category = "BabySpiderSingle",
			classes =
			{
				{
					class = "BabySpider", percent = 100,
					models =
					{
						{ name = "objects/characters/animals/spider_large/spider_large.cdf", percent = 50.0 },
						{ name = "objects/characters/animals/spider_large/spider_large_dark.cdf", percent = 50.0 },
					},
				},
			},
		},

		{
			category = "GiantRoachSingle",
			classes =
			{
				{
					class = "GiantRoach", percent = 100,
					models =
					{
						{ name = "objects/characters/animals/giant_roach/giant_roach.cdf", percent = 50.0 },
						{ name = "objects/characters/animals/giant_roach/giant_roach_dark.cdf", percent = 50.0 },
					},
				},
			},
		},

		{
			category = "Bear",
			classes =
			{
				{ class = "Bear", percent = 100 },
			},
		},

		{
			category = "lone_wolf",
			classes = 
			{
				{ class = "GreyWolf", percent = 100 },
			},
		},

		{
			category = "wolf_pack",
			pack = true, min = 3, max = 5,
			classes =
			{
				{ 
					class = "GreyWolf", percent = 100,
					models =
					{
						{ 
							-- Hack in SpawnAIInSector to spawn the rest of the pack as regular wolves models
							name = "objects/characters/animals/greywolf/alphawolf.cdf", percent = 100.0 
						},
					},					
				},
			},
		},

		{
			category = "wolf_pack_large",
			pack = true, min = 6, max = 8,
			classes =
			{
				{ 
					class = "GreyWolf", percent = 100,
					models =
					{
						{ 
							-- Hack in SpawnAIInSector to spawn the rest of the pack as regular wolves models
							name = "objects/characters/animals/greywolf/alphawolf.cdf", percent = 100.0 
						},
					},					
				},
			},
		},

		-- --------------------------------------------------------------------
		-- MUTANTS
		-- --------------------------------------------------------------------

		{
			category = "Spiker",
			classes =
			{
				{ category = "CrazySingle", percent = 45 },
				{ category = "SpikerSingle", percent = 30 },
				{ category = "HumanZombieSingle", percent = 20 },
				{ category = "BruteMutantSingle", percent = 5 },
			},
		},

		{
			category = "HumanSpider",
			classes =
			{
				{ category = "HumanSpiderSingle", percent = 100 },
			},
		},

		{
			category = "RandomDeer",
			classes =
			{
				{ category = "DeerSingle", percent = 100 }
			},
		},

		{
			category = "brute",
			classes =
			{
				{ category = "BruteMutantSingle", percent = 100 },
			},
		},
		
		{
			category = "brute_armored",
			classes =
			{
				{ category = "BruteMutantArmored", percent = 100 },
			},
		},
		
		{
			category = "twoheaddog",
			classes =
			{
				{ class = "TwoHeadDog", percent = 100 },
			},
		},

		{
			category = "spiker_pack",
			pack = true, min = 2, max = 3,
			classes =
			{
				-- Hack in CAISpawnerManager::SpawnAIInSector() will make first ai be a Spiker,
				-- and subsequent ones will be humanzombie, then 50% chance to be crazy
				{ category = "SpikerSingle", percent = 100 },
			},
		},

		{
			category = "brute_pack",
			pack = true, min = 3, max = 4,
			classes =
			{
				-- Hack in CAISpawnerManager::SpawnAIInSector() will make first ai be a brute,
				-- and subsequent ones will be Spiker, then humanzombie, then 50% chance to be crazy
				{ category = "BruteMutantSingle", percent = 100 },
			},
		},

		{
			category = "brute_hunting_pack",
			pack = true, min = 3, max = 4,
			classes =
			{
				-- Hack in CAISpawnerManager::SpawnAIInSector() will make first ai be a brute,
				-- and all subsequent ones will be TwoHeadDogs
				{ category = "BruteMutantSingle", percent = 100 },
			},
		},

		{
			category = "horde",
			min = 6, max = 11,
			classes =
			{
				-- Hack in CAISpawnerManager::SpawnHorde() to spawn at least 1 brute per horde as a psuedo leader
				{ class = "Crazy", percent = 45 },
				{ class = "Spiker", percent = 30 },
				{ class = "HumanZombie", percent = 20 },
				{ class = "BruteMutant", percent = 5 },
			},
		},

		-- --------------------------------------------------------------------
		-- ACTIONABLE WORLD MANAGER
		-- --------------------------------------------------------------------

		{
			category = "ai_actionable_roach",
			classes = 
			{
				{ category = "GiantRoachSingle", percent = 100 },
			},
		},
		{
			category = "ai_actionable_spider",
			classes = 
			{
				{ category = "BabySpiderSingle", percent = 100 },
			},
		},
		{
			category = "ai_actionable_critter",
			classes = 
			{
				{ category = "BabySpiderSingle", percent = 50 },
				{ category = "GiantRoachSingle", percent = 50 },
			},
		},

		-- --------------------------------------------------------------------
		-- ROUNDROBIN SPAWNER MANAGER
		-- --------------------------------------------------------------------

		-- {
			-- category = "RRAI_HumanZombie",
			-- classes =
			-- {
				-- { category = "HumanZombieSingle", percent = 100	},
			-- },
		-- },
		-- {
			-- category = "RRAI_TwoHeadDog",
			-- classes =
			-- {
				-- { category = "twoheaddog", percent = 100 },
			-- },
		-- },
		-- {
			-- category = "RRAI_Bear",
			-- classes =
			-- {
				-- { category = "Bear", percent = 100	},
			-- },
		-- },
		-- {
			-- category = "RRAI_HumanSpider",
			-- classes =
			-- {
				-- { category = "HumanSpiderSingle", percent = 100 ),
			-- },
		-- },
		-- {
			-- category = "RRAI_Brute",
			-- classes =
			-- {
				-- { category = "BruteMutantSingle", percent = 100 ),
			-- },
		-- },
		-- {
			-- category = "RRAI_BruteArmored",
			-- classes =
			-- {
				-- { category = "BruteMutantArmored", percent = 100 ),
			-- },
		-- },
		-- {
			-- category = "RRAI_Crazy",
			-- classes =
			-- {
				-- { category = "CrazySingle", percent = 100 ),
			-- },
		-- },
		-- {
			-- category = "RRAI_Spiker",
			-- classes =
			-- {
				-- { category = "SpikerSingle", percent = 100 ),
			-- },
		-- },
		-- --------------------------------------------------------------------
		-- TEST SPAWNERS
		-- --------------------------------------------------------------------

		{
			category = "test_spiker",
			classes =
			{
				{ class = "Spiker", percent = 100 },
			},
		},
		{
			category = "test_humanzombie",
			classes =
			{
				{ class = "HumanZombie", percent = 100 },
			},
		},
		{
			category = "test_crazy",
			classes =
			{
				{ class = "Crazy", percent = 100 },
			},
		},
		{
			-- This should create a pack of one alpha only
			category = "test_wolf",
			pack = true, min = 1, max = 1,
			classes =
			{
				{ class = "GreyWolf", percent = 100 },
			},
		},
		{
			category = "test_deer",
			classes =
			{
				{ class = "Deer", percent = 100 },
			},
		},
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function AISpawnerManager:OnInit()
	--Log("AISpawnerManager:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function AISpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function AISpawnerManager:OnReset()
	--Log("AISpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function AISpawnerManager:OnSpawn()
	self:Reset();
end

function AISpawnerManager:Reset()
	--Log("AISpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/aism_mods", true, true)