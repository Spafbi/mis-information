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
				{ class = "PupTentBlue", contents = "RandomTentContents" },
				{ class = "PupTentBrown", contents = "RandomTentContents" },
				{ class = "PupTentGreen", contents = "RandomTentContents" },
				{ class = "PupTentRed", contents = "RandomTentContents" },
				{ class = "PupTentTan", contents = "RandomTentContents" },
				{ class = "CampingTentRed", contents = "RandomTentContents" },
				{ class = "CampingTentYellow", contents = "RandomTentContents" },
				{ class = "CampingTentOrange", contents = "RandomTentContents" },
				{ class = "CampingTentGreen", contents = "RandomTentContents" },
				{ class = "CampingTentPurple", contents = "RandomTentContents" },
				{ class = "CampingTentBrown", contents = "RandomTentContents" },
				{ class = "CampingTentBlue", contents = "RandomTentContents" },
				{ class = "TrekkingTentRed", contents = "RandomTentContents" },
				{ class = "EasyCampTentBlue", contents = "RandomTentContents" },
				{ class = "EasyCampTentBrown", contents = "RandomTentContents" },
				{ class = "EasyCampTentGreen", contents = "RandomTentContents" },
				{ class = "EasyCampTentOrange", contents = "RandomTentContents" },
				{ class = "EasyCampTentPurple", contents = "RandomTentContents" },
				{ class = "EasyCampTentRed", contents = "RandomTentContents" },
				{ class = "EasyCampTentYellow", contents = "RandomTentContents" },
				{ class = "TrekkingTentYellow", contents = "RandomTentContents" },
				{ class = "TrekkingTentOrange", contents = "RandomTentContents" },
				{ class = "TrekkingTentGreen", contents = "RandomTentContents" },
				{ class = "TrekkingTentPurple", contents = "RandomTentContents" },
				{ class = "TrekkingTentBrown", contents = "RandomTentContents" },
				{ class = "TrekkingTentBlue", contents = "RandomTentContents" },
				{ class = "TwoPersonTentRed", contents = "RandomTentContents" },
				{ class = "TwoPersonTentYellow", contents = "RandomTentContents" },
				{ class = "TwoPersonTentOrange", contents = "RandomTentContents" },
				{ class = "TwoPersonTentGreen", contents = "RandomTentContents" },
				{ class = "TwoPersonTentPurple", contents = "RandomTentContents" },
				{ class = "TwoPersonTentBrown", contents = "RandomTentContents" },
				{ class = "TwoPersonTentBlue", contents = "RandomTentContents" }
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