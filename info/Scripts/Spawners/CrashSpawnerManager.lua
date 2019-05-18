CrashSpawner = 
{
	type = "CrashSpawner",

	Editor =
	{
		Icon="Trigger.bmp",
		DisplayArrow=1,
		IsScalable = false;
	},

	Server = {},
	Client = {},

	Properties = 
	{
		bEnabled = 1,
		bRandomRotation = 1,
		bUseTrigger = 1,
		fTriggerRadius = 350,
		EntitiesTable = "",
	},

	HMMWVCrash = 
	{
		{
			class = "HMMWV",
			destroyVehicle = true;
			properties =
			{
			},
		},
		{
			class = "ItemSpawner",
			properties =
			{
				ItemCategory = "All",
				fSpawnRadius = 5,
				nMinItems = 5,
				nMaxItems = 10,
				bRespawn = 0,
				nTimer = 1,
				bEnabled = 1,
			},
			position =
			{
				x = 0, y = 0, z = 3,
			},
		},
		{
			class = "ParticleEffect",
			properties =
			{
				ParticleEffect = "smoke_and_fire.black_smoke.harbor_postattack",
				bActive = 1,
			},
			position =
			{
				x = 0, y = 0, z = .5,
			},
		},
	},

	BlackhawkCrash = 
	{
		{
			class = "MH60_Blackhawk",
			destroyVehicle = true;
			properties =
			{
			},
		},
		{
			class = "ItemSpawner",
			properties =
			{
				ItemCategory = "All",
				fSpawnRadius = 5,
				nMinItems = 5,
				nMaxItems = 10,
				bRespawn = 0,
				nTimer = 1,
				bEnabled = 1,
			},
			position =
			{
				x = 0, y = 0, z = 3,
			},
		},
		{
			class = "ParticleEffect",
			properties =
			{
				ParticleEffect = "smoke_and_fire.black_smoke.harbor_postattack",
				bActive = 1,
			},
			position =
			{
				x = 0, y = -3, z = 1,
			},
		},
	},

	AbramsCrash = 
	{
		{
			class = "Abrams",
			destroyVehicle = true;
			properties =
			{
			},
		},
		{
			class = "ItemSpawner",
			properties =
			{
				ItemCategory = "All",
				fSpawnRadius = 5,
				nMinItems = 5,
				nMaxItems = 10,
				bRespawn = 0,
				nTimer = 1,
				bEnabled = 1,
			},
			position =
			{
				x = 0, y = 0, z = 3,
			},
		},
		{
			class = "ParticleEffect",
			properties =
			{
				ParticleEffect = "smoke_and_fire.black_smoke.harbor_postattack",
				bActive = 1,
			},
			position =
			{
				x = 0, y = 0, z = .5,
			},
		},
	},

	ConvoyCrash = 
	{
		{
			class = "HMMWV",
			destroyVehicle = true;
			properties =
			{
			},
			position =
			{
				x = -10, y = 13, z = 0,
			},
		},
		{
			class = "ParticleEffect",
			properties =
			{
				ParticleEffect = "smoke_and_fire.black_smoke.harbor_postattack",
				bActive = 1,
			},
			position =
			{
				x = -10, y = 13, z = .5,
			},
		},

		{
			class = "HMMWV",
			destroyVehicle = true;
			properties =
			{
			},
			position =
			{
				x = 10, y = 20, z = 0,
			},
		},
		{
			class = "ParticleEffect",
			properties =
			{
				ParticleEffect = "smoke_and_fire.black_smoke.harbor_postattack",
				bActive = 1,
			},
			position =
			{
				x = 10, y = 20, z = .5,
			},
		},

		{
			class = "HMMWV",
			properties =
			{
			},
		},

		{
			class = "Abrams",
			destroyVehicle = true;
			properties =
			{
			},
			position =
			{
				x = 0, y = -20, z = 0,
			},
		},
		{
			class = "ParticleEffect",
			properties =
			{
				ParticleEffect = "smoke_and_fire.black_smoke.harbor_postattack",
				bActive = 1,
			},
			position =
			{
				x = 0, y = -20, z = .5,
			},
		},

		{
			class = "MH60_Blackhawk",
			destroyVehicle = true;
			properties =
			{
			},
			position =
			{
				x = -20, y = -15, z = 0,
			},
		},
		{
			class = "ParticleEffect",
			properties =
			{
				ParticleEffect = "smoke_and_fire.black_smoke.harbor_postattack",
				bActive = 1,
			},
			position =
			{
				x = -20, y = -18, z = 1,
			},
		},

		{
			class = "ItemSpawner",
			properties =
			{
				ItemCategory = "All",
				fSpawnRadius = 30,
				nMinItems = 20,
				nMaxItems = 30,
				bRespawn = 0,
				nTimer = 2,
				bEnabled = 1,
			},
			position =
			{
				x = 0, y = 0, z = 1,
			},
		},
	},
}

function CrashSpawner:OnSpawn()
	self:SetFlags(ENTITY_FLAG_SERVER_ONLY, 0);
end

function CrashSpawner:OnInit()
	self:OnReset();
end

function CrashSpawner:OnPropertyChange()
	self:OnReset();
end

function CrashSpawner:OnReset()
	self.enabled = nil;
	self:Enable(tonumber(self.Properties.bEnabled)~=0);
end

function CrashSpawner:Enable(enable)
	self.enabled=enable;
end

function CrashSpawner:Event_Enable(sender)
	self:Enable(true);
	BroadcastEvent(self, "Enable");
end

function CrashSpawner:Event_Disable(sender)
	self:Enable(false);
	BroadcastEvent(self, "Disable");
end

CrashSpawner.FlowEvents =
{
	Inputs =
	{
		Disable = { CrashSpawner.Event_Disable, "bool" },
		Enable = { CrashSpawner.Event_Enable, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
	},
}

-- Load mods
Script.LoadScriptFolder("scripts/spawners/event_mods", true, true)