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

	if (player and player.actor) then
		Log(">> BattleRoyale:InitPlayer - Name: %s", player:GetName());
		Log(">> BattleRoyale:InitPlayer - Steam64ID: %s", player.actor:GetSteam64Id());

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

	if (player and player.actor) then
		Log(">> BattleRoyale:RevivePlayer - Setting player's health to 50");

		player.actor:SetHealth(50.0);
	end
end

-- This is called after the player starts the spawning process
-- Add any custom equipment or other finalizing touches here
function BattleRoyale:EquipPlayer(playerId)
	Log(">> BattleRoyale:EquipPlayer");

	-- player is an entity
	local player = System.GetEntity(playerId);

	if (player and player.actor) then

		-- Default weapons
		local weaponId = ItemSystem.GiveItem(playerId, "Flashlight");

		--local rifleId = ItemSystem.GiveItem(playerId, "AT15", true);
		--local accessoryId = ItemSystem.GiveItem(playerId, "STANAGx30", false, rifleId, "stanag_mag00");

		-- Default clothes
		local rnd = random(1, 3);

		-- Feet
		if (rnd == 1) then
			ItemSystem.GiveItem(playerId, "TennisShoes");
		elseif (rnd == 2) then
			ItemSystem.GiveItem(playerId, "Sneakers");
		else
			ItemSystem.GiveItem(playerId, "CanvasShoes");
		end

		-- Legs
		rnd = random(1, 4);

		if (rnd == 1) then
			ItemSystem.GiveItem(playerId, "BlueJeans");
		elseif (rnd == 2) then
			ItemSystem.GiveItem(playerId, "BlueJeans2");
		elseif (rnd == 3) then
			ItemSystem.GiveItem(playerId, "BlueJeans2Brown");
		else
			ItemSystem.GiveItem(playerId, "BlueJeans2Green");
		end

		-- Torso
		rnd = random(1, 6);

		if (rnd == 1) then
			ItemSystem.GiveItem(playerId, "TshirtNoImageBlack");
		elseif (rnd == 2) then
			ItemSystem.GiveItem(playerId, "TshirtNoImageBlue");
		elseif (rnd == 3) then
			ItemSystem.GiveItem(playerId, "TshirtNoImageGreen");
		elseif (rnd == 4) then
			ItemSystem.GiveItem(playerId, "TshirtNoImageGrey");
		elseif (rnd == 5) then
			ItemSystem.GiveItem(playerId, "TshirtNoImagePink");
		else
			ItemSystem.GiveItem(playerId, "TshirtNoImageRed");
		end

	end
end