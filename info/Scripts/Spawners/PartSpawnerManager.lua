PartSpawnerManager = {

--[[
	We should make the spawn percents match about what would be used on a real base:
	Walls being very common, doors not as much, gatehouse rare (only used once or twice per base)
--]]

	categories =
	{
		{
			category = "metal_part",
			classes =
			{
				-- doors (7)
				{ class = "metal_door_lockable_1m_2m", percent = 7 },

				-- walls (58.99)
				{ class = "metal_aframe_3m_4m", percent = 5 },
				{ class = "metal_wall_1_3m_2m", percent = 5 },
				{ class = "metal_wall_1_3m_4m", percent = 5 }, 
				{ class = "metal_wall_2m_2m", percent = 5 },
				{ class = "metal_wall_2m_4m", percent = 10 },
				{ class = "metal_wall_3m_2m", percent = 5 },
				{ class = "metal_wall_3m_4m", percent = 16.99 },

				-- special walls (20)
				{ class = "metal_wall_door_3m_4m", percent = 6 }, 
				{ class = "metal_wall_window_3m_2m", percent = 5 },
				{ class = "metal_wall_window_3m_4m", percent = 10 },

				-- gatehouse (9)
				{ class = "metal_gatehouse_4m_8m", percent = 4 },
				{ class = "metal_gate_lockable_3m_5_4m", percent = 5 },

				-- misc (4.01)
				{ class = "metal_steam_stand", percent = 7 },
				{ class = "gnome_giant_c", percent = 0.01 },
				{ class = "arcade_cabinet", percent = 4 },
				--{ class = "christmas_tree", percent = 11 }, -- disabled until christmas
			},
		},
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function PartSpawnerManager:OnInit()
	--Log("PartSpawnerManager:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function PartSpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function PartSpawnerManager:OnReset()
	--Log("PartSpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function PartSpawnerManager:OnSpawn()
	self:Reset();
end

function PartSpawnerManager:Reset()
	--Log("PartSpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/part_mods", true, true)