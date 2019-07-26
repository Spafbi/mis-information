Script.ReloadScript("scripts/gamerules/GameRulesUtils.lua");

BattleRoyale= {};

GameRulesSetStandardFuncs(BattleRoyale);

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