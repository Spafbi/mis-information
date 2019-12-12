-- [[
-- Each category can only have one class defined in it
-- max is the maximum number of those animals that can exist anywhere on the
-- map at the same time - including those picked up and dropped by players
-- ]]

AnimalSpawnerManager = {

	categories =
	{
		-- --------------------------------------------------------------------
		-- ANIMALS
		-- --------------------------------------------------------------------

		{
			class = "Rooster",
			max = 15,
		},

		{
			class = "Pig",
			max = 15,
		},

		{
			class = "Boar",
			max = 15,
		},
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function AnimalSpawnerManager:OnInit()
	--Log("AnimalSpawnerManager:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function AnimalSpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function AnimalSpawnerManager:OnReset()
	--Log("AnimalSpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function AnimalSpawnerManager:OnSpawn()
	self:Reset();
end

function AnimalSpawnerManager:Reset()
	--Log("AnimalSpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/animal_mods", true, true)