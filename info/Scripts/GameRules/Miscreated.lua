Script.ReloadScript("scripts/gamerules/GameRulesUtils.lua");

Miscreated= {};

GameRulesSetStandardFuncs(Miscreated);

----------------------------------------------------------------------------------------------------

-- See BattleRoyale.lua for a more complete example of the following 3 methods

--[[
-- Initialize the player
-- Use this to initialize the player before the server respawns the player
-- Any change to the player's position and rotation would have to be done here
function Miscreated:InitPlayer(playerId)
	--Log(">> Miscreated:InitPlayer");
end
--]]

--[[
-- This is called when the character is being revived by the server
-- Set player stats here - only default CryEngine stats are currently exposed, like health
function Miscreated:RevivePlayer(playerId)
	--Log(">> Miscreated:RevivePlayer");
end
--]]

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
		local weaponId = ISM.GiveItem(playerId, "AT15", true);

		-- Add a STANAGx30 to playerId into the stanag_mag00 slot of the AT15
		-- Slot names can be found in the item XML files and they start at index 00 and increment up from there
		local accessoryId = ISM.GiveItem(playerId, "STANAGx30", false, weaponId, "stanag_mag00");
	end
end
--]]

-- Receives all unhandled, by the core game, chat commands
function Miscreated:ChatCommand(playerId, command)
	--Log(">> Miscreated:ChatCommand");

	-- player is an entity
	local player = System.GetEntity(playerId);

	-- Add any custom chat commands you want here

	-- Mirrors the chat command string back to the player who entered it
	-- Usage: !mirror I'm sexy and I know it
	-- The 4 below sends to the chat message window, 0 appears at the top of the player's screen
	-- Replace playerId with a 0 to send to all clients
	if (string.sub(command, 1, 8) == "!mirror ") then
--[[ Commented out, but left as an example for modders to use
		self.game:SendTextMessage(4, playerId, string.sub(command, 9));
--]]
	-- Spawn an item 2m in front of the player at their foot level
	elseif (string.sub(command, 1, 7) == "!spawn ") then
--[[ Commented out, but left as an example for modders to use
		-- Only allow the following SteamId to invoke the command
		if (player.actor:GetSteam64Id() == "76561198082291600") then
			local vForwardOffset = {x=0,y=0,z=0};
			FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0);

			local vSpawnPos = {x=0,y=0,z=0};
			FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos());

			ISM.SpawnItem(string.sub(command, 8), vSpawnPos);
		end
--]]
	-- Give an item to the player
	elseif (string.sub(command, 1, 6) == "!give ") then
--[[ Commented out, but left as an example for modders to use
		-- Only allow the following SteamId to invoke the command
		if (player.actor:GetSteam64Id() == "76561198082291600") then
			local weaponId = ISM.GiveItem(playerId, string.sub(command, 7), true);
		end
--]]
	end
end