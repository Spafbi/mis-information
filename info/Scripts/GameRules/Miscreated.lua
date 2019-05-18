Script.ReloadScript("scripts/gamerules/GameRulesUtils.lua");

Miscreated= {};

GameRulesSetStandardFuncs(Miscreated);

----------------------------------------------------------------------------------------------------

--[[
-- Initialize the player
-- Use this to initialize the player before the server respawns the player
-- Any change to the player's position and rotation would have to be done here
function Miscreated:InitPlayer(playerId)
	--Log(">> Miscreated:InitPlayer");
end
]]

--[[
-- This is called when the character is being revived by the server
-- Set player stats here - only default CryEngine stats are currently exposed, like health
function Miscreated:RevivePlayer(playerId)
	--Log(">> Miscreated:RevivePlayer");
end
]]

-- If this method is defined, then Miscreated will ONLY spawn items for a new or respawned
-- player based on the code below.
-- This is called after the player starts the spawning process
-- Add any custom equipment or other finalizing touches here
--[[
function Miscreated:EquipPlayer(playerId)
	--Log(">> Miscreated:EquipPlayer");
	
	-- Get the entity for the player
	local player = System.GetEntity(playerId);

	-- Verify the player is of type "actor" - sanity check
	if (player and player.actor) then

		-- Give an AT15 to playerId into whatever slot is available and have the player select it
		local weaponId = ItemSystem.GiveItem(playerId, "AT15", true);

		-- Add a STANAGx30 to playerId into the stanag_mag00 slot of the AT15
		-- Slot names can be found in the item XML files and they start at index 00 and increment up from there
		local accessoryId = ItemSystem.GiveItem(playerId, "STANAGx30", false, weaponId, "stanag_mag00");
	end
end
]]