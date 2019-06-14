Script.ReloadScript("scripts/gamerules/GameRulesUtils.lua");

Miscreated = {
	Properties = {
		AirDrop = {
			fMinTime = 3600, -- min time to spawn a plane (in seconds)
			fMaxTime = 7200, -- max time to spawn a plane (in seconds)
		}
	}
}

GameRulesSetStandardFuncs(Miscreated);

function Miscreated.Server:OnInit()
	self:CreateAirDropPlaneTimer()
end

----------------------------------------------------------------------------------------------------
-- Support for the air drop planes to spawn
----------------------------------------------------------------------------------------------------

function Miscreated:CreateAirDropPlaneTimer()
	--Log("Miscreated.CreateAirDropPlaneTimer")
	Script.SetTimerForFunction(randomF(self.Properties.AirDrop.fMinTime*1000, self.Properties.AirDrop.fMaxTime*1000), "SpawnAirDropPlane", self)
end

SpawnAirDropPlane = function(self)
	--Log("Miscreated:SpawnAirDropPlane")

	local spawnParams = {}
	spawnParams.class = "AirDropPlane"
	spawnParams.name = spawnParams.class

	Log("Miscreated:SpawnAirDropPlane - Spawning AirDropPlane")
	local spawnedEntity = System.SpawnEntity(spawnParams)

	if not spawnedEntity then
		Log("Miscreated:SpawnAirDropPlane - AirDropPlane could not be spawned")
	end

	-- set timer up for the next plane
	self:CreateAirDropPlaneTimer()
end

----------------------------------------------------------------------------------------------------
-- Support for custom chat command mods
----------------------------------------------------------------------------------------------------

-- Table for custom chat commands to use
ChatCommands = { }

-- Load custom chat commands (mods)
Script.LoadScriptFolder("Scripts/GameRules/ChatCommands", true, true)

-- Receives all unhandled, by the core game, chat commands
-- Do not add custom chat commands directly here
-- Add new chat commands to a file in the Scripts/GameRules/ChatCommands folder,
-- so they can be uploaded as mods to Steam
function Miscreated:ChatCommand(playerId, command)
	--Log(">> Miscreated:ChatCommand");

	-- player is an entity
	local player = System.GetEntity(playerId)

	if not player.actor then
		Log("Miscreated:ChatCommand - playerId is not a valid player")
		return
	end

	-- Find the requested chat command and execute it
	local index = string.find(command, " ")

	if not index then
		if ChatCommands[command] then
			ChatCommands[command](playerId, "")
		end
	else
		local cmd = string.sub(command, 1, index - 1)
		if ChatCommands[cmd] then
			ChatCommands[cmd](playerId, string.sub(command, index + 1))
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Support for custom player spawns
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