StructureSpawnerManager = {

--[[
	Property descriptions:
	initialMinStructures - the minimum number of Structures from this category that will exist on system startup
	abandonedTimer -- how long until an abandoned Structure will be removed from gameplay (in seconds)
	abandonedRespawnTimer -- how long until an abandoned Structure will respawn (in seconds)
	destroyedTimer -- how long until an destroyed Structure will be removed from gameplay (in seconds)
	destroyedRespawnTimer -- how long until a destroyed Structure will respawn (in seconds)
]]--

	StructureCategories =
	{
		-- ====================================================================
		-- BASIC CATEGORIES
		-- ====================================================================

		-- 
		-- A class can ONLY exist in one category! Do not reuse a "class" name
		-- anywhere within this file
		-- 

		{   -- Do NOT touch this category. It has to stay as is or bad things will happen.
			category = "plotsign",
			classes =
			{
				{ class = "PlotSign" },
			},
			initialMinStructures = 0,
			abandonedTimer = 0,
			abandonedRespawnTimer = 0,
			destroyedTimer = 0,
			destroyedRespawnTimer = 0,
		},

		{
			category = "tent",
			classes =
			{
				{ class = "PupTentBlue" },
				{ class = "PupTentBrown" },
				{ class = "PupTentGreen" },
				{ class = "PupTentRed" },
				{ class = "PupTentTan" },
				{ class = "CampingTentRed" },
				{ class = "CampingTentYellow" },
				{ class = "CampingTentOrange" },
				{ class = "CampingTentGreen" },
				{ class = "CampingTentPurple" },
				{ class = "CampingTentBrown" },
				{ class = "CampingTentBlue" },
				{ class = "TrekkingTentRed" },
				{ class = "EasyCampTentBlue" },
				{ class = "EasyCampTentBrown" },
				{ class = "EasyCampTentGreen" },
				{ class = "EasyCampTentOrange" },
				{ class = "EasyCampTentPurple" },
				{ class = "EasyCampTentRed" },
				{ class = "EasyCampTentYellow" },
				{ class = "TrekkingTentYellow" },
				{ class = "TrekkingTentOrange" },
				{ class = "TrekkingTentGreen" },
				{ class = "TrekkingTentPurple" },
				{ class = "TrekkingTentBrown" },
				{ class = "TrekkingTentBlue" },
				{ class = "TwoPersonTentRed" },
				{ class = "TwoPersonTentYellow" },
				{ class = "TwoPersonTentOrange" },
				{ class = "TwoPersonTentGreen" },
				{ class = "TwoPersonTentPurple" },
				{ class = "TwoPersonTentBrown" },
				{ class = "TwoPersonTentBlue" }
			},
			initialMinStructures = 20,
			abandonedTimer = 604800,  -- seven days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 10,
			destroyedRespawnTimer = 7200, -- two hours
		},
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function StructureSpawnerManager:OnInit()
	--Log("StructureSpawnerManager:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function StructureSpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function StructureSpawnerManager:OnReset()
	--Log("StructureSpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function StructureSpawnerManager:OnSpawn()
	self:Reset();
end

function StructureSpawnerManager:Reset()
	--Log("StructureSpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/ssm_mods", true, true)