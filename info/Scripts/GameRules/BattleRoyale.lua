Script.ReloadScript("scripts/gamerules/GameRulesUtils.lua");

BattleRoyale = {
	Properties = {
		WorldEvent = {
			fMinTime = 3600, -- min time to spawn an event (in seconds)
			fMaxTime = 7200, -- max time to spawn an event (in seconds)
		}
	}
}

GameRulesSetStandardFuncs(BattleRoyale);

function BattleRoyale.Server:OnInit()
	self:CreateWorldEventTimer()
end

----------------------------------------------------------------------------------------------------
-- Support for the world events to spawn
----------------------------------------------------------------------------------------------------

function BattleRoyale:CreateWorldEventTimer()
	--Log("BattleRoyale.CreateWorldEventTimer")
	Script.SetTimerForFunction(randomF(self.Properties.WorldEvent.fMinTime*1000, self.Properties.WorldEvent.fMaxTime*1000), "SpawnWorldEvent", self)
end

SpawnWorldEvent = function(self)
    local holiday  = HolidayManager.GetActiveHoliday()
    local rnd      = random(1, 10)
    local eventName

    if holiday == "halloween" then
        eventName = (rnd <= 7) and "AirPlaneCrash" or "UFOCrash"
    elseif holiday == "christmas" then
        eventName = (rnd <= 5) and "AirDropChristmas" or "AirPlaneCrash"
    else
        eventName = (rnd <= 5) and "AirDropPlane" or "AirPlaneCrash"
    end

    local spawnParams = { class = eventName, name = eventName }
    if not System.SpawnEntity(spawnParams) then
        Log("BattleRoyale:SpawnWorldEvent - entity could not be spawned")
    end

    self:CreateWorldEventTimer()
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
function BattleRoyale:ChatCommand(playerId, command)
	--Log(">> BattleRoyale:ChatCommand");

	-- player is an entity
	local player = System.GetEntity(playerId)

	if not player.actor then
		Log("BattleRoyale:ChatCommand - playerId is not a valid player")
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

-- Initialize the player
-- Use this to initialize the player before the server respawns the player
-- Any change to the player's position and rotation would have to be done here
function BattleRoyale:InitPlayer(playerId)
	Log(">> BattleRoyale:InitPlayer");

	-- player is an entity
	local player = System.GetEntity(playerId);

	if (player and player.player) then
		Log(">> BattleRoyale:InitPlayer - Name: %s", player:GetName());
		Log(">> BattleRoyale:InitPlayer - Steam64ID: %s", player.player:GetSteam64Id());

		Log(">> BattleRoyale:InitPlayer - Moving player's location to 5, 5, 20");

		g_Vectors.temp_v1.x = 5;
		g_Vectors.temp_v1.y = 5;
		g_Vectors.temp_v1.z = 20;

		player:SetWorldPos(g_Vectors.temp_v1);
	end
end

-- This is called when the character is being revived by the server
-- Set player stats here - only default CryEngine stats are currently exposed, like health
function BattleRoyale:RevivePlayer(playerId)
	Log(">> BattleRoyale:RevivePlayer");

	-- player is an entity
	local player = System.GetEntity(playerId);

	if (player and player.player) then
		Log(">> BattleRoyale:RevivePlayer - Setting player's health to 50");

		player.player:SetHealth(50.0);
	end
end

-- This is called after the player starts the spawning process
-- Add any custom equipment or other finalizing touches here
function BattleRoyale:EquipPlayer(playerId)
	Log(">> BattleRoyale:EquipPlayer");

	-- player is an entity
	local player = System.GetEntity(playerId);

	if (player and player.player) then

		-- Default weapons
		local weapon = ISM.GiveItem(playerId, "Flashlight");

		--local rifle = ISM.GiveItem(playerId, "AT15", true);
		--local accessory = ISM.GiveItem(playerId, "STANAGx30", false, rifle.id, "stanag_mag00");

		-- Default clothes
		local rnd = random(1, 3);

		-- Feet
		if (rnd == 1) then
			ISM.GiveItem(playerId, "TennisShoes");
		elseif (rnd == 2) then
			ISM.GiveItem(playerId, "Sneakers");
		else
			ISM.GiveItem(playerId, "CanvasShoes");
		end

		-- Legs
		rnd = random(1, 4);

		if (rnd == 1) then
			ISM.GiveItem(playerId, "BlueJeans");
		elseif (rnd == 2) then
			ISM.GiveItem(playerId, "BlueJeans2");
		elseif (rnd == 3) then
			ISM.GiveItem(playerId, "BlueJeans2Brown");
		else
			ISM.GiveItem(playerId, "BlueJeans2Green");
		end

		-- Torso
		rnd = random(1, 6);

		if (rnd == 1) then
			ISM.GiveItem(playerId, "TshirtNoImageBlack");
		elseif (rnd == 2) then
			ISM.GiveItem(playerId, "TshirtNoImageBlue");
		elseif (rnd == 3) then
			ISM.GiveItem(playerId, "TshirtNoImageGreen");
		elseif (rnd == 4) then
			ISM.GiveItem(playerId, "TshirtNoImageGrey");
		elseif (rnd == 5) then
			ISM.GiveItem(playerId, "TshirtNoImagePink");
		else
			ISM.GiveItem(playerId, "TshirtNoImageRed");
		end

	end
end