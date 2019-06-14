-- The follow are some example chat commands
-- If you want to use them, please copy them into their own lua file and then upload them as a mod
-- For example: mirror.lua, spawn.lua, and give.lua

-- !mirror <message>
-- Sends the message <message> back to the invoking player's chat window
-- The 4 below sends to the chat message window, using 0 it will appear at the top of the player's screen
-- Replace playerId with a 0 to send to all clients
ChatCommands["!mirror"] = function(playerId, command)
	Log(">> !mirror - %s", command)

	g_gameRules.game:SendTextMessage(4, playerId, command);
end

--[[ -- uncomment this block comment and copy to a new chat command mod to enable

-- !spawn <item_name>
-- Spawns the <item_name> 2m in front of the player at their feet level
-- <item_name> can be any valid item name in the game -ex. AT15
ChatCommands["!spawn"] = function(playerId, command)
	Log(">> !spawn - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561198082291600" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		local vForwardOffset = {x=0,y=0,z=0}
		FastScaleVector(vForwardOffset, player:GetDirectionVector(), 2.0)

		local vSpawnPos = {x=0,y=0,z=0}
		FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())

		ISM.SpawnItem(command, vSpawnPos)
	end
end

-- !give <item_name>
-- Gives the <item_name> to the invoking player and it will appear in their inventory
-- <item_name> can be any valid item name in the game -ex. AT15
ChatCommands["!give"] = function(playerId, command)
	Log(">> !give - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561198082291600" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		local weaponId = ISM.GiveItem(playerId, command, true)
	end
end

-- !joinf <factionno>
-- Joins the faction if its enabled and possible (forced: without requiring server restart)
-- <factionno> 0-7 (1,2 invalid)
ChatCommands["!joinf"] = function(playerId, command)
  Log(">> !joinf - %s", command)

  local player = System.GetEntity(playerId)
  
  player.actor:SetFaction( tonumber(command), true ) -- param is factionno, forced (forced meaning, player can switch faction at any point without server restart)
end

-- !weather
-- Starts any of the weather pattern on the server (by number or name)
ChatCommands["!weather"] = function(playerId, command)
	Log(">> !weather - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561198082291600" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		System.ExecuteCommand("wm_startPattern " .. command)
	end
end

-- !rcon 
-- Execute console command on server
ChatCommands["!rcon"] = function(playerId, command)
	Log(">> !rcon - %s", command)

	local player = System.GetEntity(playerId)
  
  -- Only allow the following SteamId to invoke the command 
  local steamid = player.player:GetSteam64Id()
  local allowCommand = steamid == "76561198082291600" -- change this to some valid admin's Steam64 id
  
  -- or through faction restrictions
  -- allowCommand = allowCommand or nil ~= string.match(System.GetCVar("g_gameRules_faction4_steamids"), steamid)
  
  -- or through actual current faction
  -- allowCommand = allowCommand or 4 == player.actor:GetFaction() -- faction 0 to 7 (same numbering as cvars)
  
	if allowCommand then
		System.ExecuteCommand(command)
	end
end
]]--

-- For debugging
--dump(ChatCommands)