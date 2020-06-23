--Script.ReloadScript( "SCRIPTS/Entities/actor/BasicActor.lua");

AIRoundRobinManager = {

	rraiSpawnGroups = 
	{
		islands = 
		{
			--------------------------------------------------------------------------
			-- Global spawn groups
			--------------------------------------------------------------------------
			{
				name = "RRAIGlobal_Spider",
				spawnCategory = "ai_actionable_spider",
				weight = 1.0,
				encounterType = "OnPoint",
				interceptSpeed = 0.0,
			},
			{
				name = "RRAIGlobal_Roach",
				spawnCategory = "ai_actionable_roach",
				weight = 2.0,
				encounterType = "OnPoint",
				interceptSpeed = 0.0, 
			},
			{
				name = "RRAIGlobal_Deer",
				spawnCategory = "DeerSingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 6.2, -- sprint speed
			},

			--------------------------------------------------------------------------
			-- Zone Spawn Groups
			--------------------------------------------------------------------------
			
			{	
				name = "RRAIZone_Wolf",
				spawnCategory = "lone_wolf",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 13.0, 
			},
			{	
				name = "RRAIZone_HumanZombie",
				spawnCategory = "HumanZombieSingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 4.5,
			},
			{	
				name = "RRAIZone_TwoHeadDog",
				spawnCategory = "twoheaddog",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 13.0,
			},
			{	
				name = "RRAIZone_Bear", 
				spawnCategory = "Bear",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 7.5,
			},
			{	
				name = "RRAIZone_HumanSpider", 
				spawnCategory = "HumanSpiderSingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 12.0,
			},
			{	
				name = "RRAIZone_Brute", 
				spawnCategory = "BruteMutantSingle", --has chance to spawn armoured, TODO: not
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 5.5,
			},
			{	
				name = "RRAIZone_BruteArmored", 
				spawnCategory = "BruteMutantArmored",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 5.5,
			},
			{	
				name = "RRAIZone_Crazy", 
				spawnCategory = "CrazySingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 6.0,
			},
			{	
				name = "RRAIZone_Spiker", 
				spawnCategory = "SpikerSingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 4.5,
			},
		},
		canyonlands =
		{
			--------------------------------------------------------------------------
			-- Global spawn groups
			--------------------------------------------------------------------------
			{
				name = "RRAIGlobal_Spider",
				spawnCategory = "ai_actionable_spider",
				weight = 3.0,
				encounterType = "OnPoint",
				interceptSpeed = 0.0,
			},
			{
				name = "RRAIGlobal_Roach",
				spawnCategory = "ai_actionable_roach",
				weight = 2.0,
				encounterType = "OnPoint",
				interceptSpeed = 0.0, 
			},
			{
				name = "RRAIGlobal_Ram",
				spawnCategory = "Ram",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 6.2, -- sprint speed
			},
			{
				name = "RRAIGlobal_GiantScorpion",
				spawnCategory = "GiantScorpion",
				weight = 3.0,
				encounterType = "Intercept",
				interceptSpeed = 3.0, -- sprint speed
			},
			{
				name = "RRAIGlobal_Donkey",
				spawnCategory = "Donkey",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 6.2, -- sprint speed
			},

			--------------------------------------------------------------------------
			-- Zone Spawn Groups
			--------------------------------------------------------------------------
			
			{	
				name = "RRAIZone_Wolf",
				spawnCategory = "lone_wolf",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 13.0, 
			},
			{	
				name = "RRAIZone_HumanZombie",
				spawnCategory = "HumanZombieSingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 4.5,
			},
			{	
				name = "RRAIZone_TwoHeadDog",
				spawnCategory = "twoheaddog",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 13.0,
			},
			{	
				name = "RRAIZone_Bear", 
				spawnCategory = "Bear",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 7.5,
			},
			{	
				name = "RRAIZone_Donkey", 
				spawnCategory = "Donkey",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 6.2,
			},
			{	
				name = "RRAIZone_Ram", 
				spawnCategory = "Ram",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 6.2,
			},
			{	
				name = "RRAIZone_GiantScorpion", 
				spawnCategory = "GiantScorpion",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 7.5,
			},
			{	
				name = "RRAIZone_HumanSpider", 
				spawnCategory = "HumanSpiderSingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 12.0,
			},
			{	
				name = "RRAIZone_Brute", 
				spawnCategory = "BruteMutantSingle", --has chance to spawn armoured, TODO: not
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 5.5,
			},
			{	
				name = "RRAIZone_BruteArmored", 
				spawnCategory = "BruteMutantArmored",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 5.5,
			},
			{	
				name = "RRAIZone_Crazy", 
				spawnCategory = "CrazySingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 6.0,
			},
			{	
				name = "RRAIZone_Spiker", 
				spawnCategory = "SpikerSingle",
				weight = 1.0,
				encounterType = "Intercept",
				interceptSpeed = 4.5,
			},

		},
	},
}
	
--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function AIRoundRobinManager:OnInit()
	--Log("AIRoundRobinManager:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function AIRoundRobinManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function AIRoundRobinManager:OnReset()
	--Log("AIRoundRobinManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function AIRoundRobinManager:OnSpawn()
	self:Reset();
end

function AIRoundRobinManager:Reset()
	--Log("AIRoundRobinManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/rrai_mods", true, true)