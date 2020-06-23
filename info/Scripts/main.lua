-- EI: At this point all of the common scripts/systems should be loaded
function OnInitPreLoaded()

	if CryAction.IsDedicatedServer() then
		Log("OnInitPreLoaded DedicatedServer")
	elseif CryAction.IsClient() then
		Log("OnInitPreLoaded Client")
	end
end

-- EI: At this point all of the level and systems are loaded and callbacks could be registered without being overwritten (however also means stuff has been instanced already and instances potentially arent effected by indirect changes)
function OnInitAllLoaded()

	if CryAction.IsDedicatedServer() then
		Log("OnInitAllLoaded DedicatedServer")
	elseif CryAction.IsClient() then
		Log("OnInitAllLoaded Client")
	end
end

-- This is called before entities, game rules, map etc exist
function OnInit()
	Script.ReloadScript("scripts/common.lua");

	Log('OnInit - Reloading scripts/mods')

	-- EI: Inside of scripts/mods you can make use of:
	--   registerCallback(_G, "OnInitPreLoaded", .........) -- to execute additional code right after (possibly to register RMIs etc)
	--   registerCallback(_G, "OnInitAllLoaded", .........) -- to execute additional code after loading map (all stuff should exist then)
	Script.LoadScriptFolder('scripts/mods', true, true)

	OnInitPreLoaded()
end

function OnShutdown()
end
