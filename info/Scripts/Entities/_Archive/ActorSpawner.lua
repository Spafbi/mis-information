ActorSpawner = 
{
	type = "ActorSpawner",

	Editor =
	{
		Icon="Trigger.bmp",
		DisplayArrow=1,
		IsScalable = false;
	},

	Properties = 
	{
		bEnabled = 1,
		ItemCategory = "",
		fSpawnRadius = 0.2,
		nMinItems = 1,
		nMaxItems = 1,
		bRespawn = 1,
		nTimer = 5,
	},
	
	-- Each item category below can either have a "classes" or a "group" table in it
	-- If it contains a "group", then the spawner will process ALL of the items
	--   in the group and attempt to spawn all of them.  Using  a group allows
	--   you to spawn a group of items at once (like a weapon and ammo for it).
	-- If it contains a "classes" then it will radomly pick just ONE of them to
	--   attempt to spawn

	-- For a class table, it can have an optional min and max value.  If that item
	--   is spawned then it will randomly create that many instances of the item
	--   (from min to max of them)
	-- Example:
	--   { class = "SchoolPackGreen", percent = 100, min = 1, max = 3 },

	-- The percent can be accurate to 4 decimal places (.001) to make for
	-- rare item spawns (one in 1,000), but the categories can be nested so
	-- you can have for example a 1 in 1,000 chance for a category that has
	-- a 1 in 1,000 chance of an item - so 1 in 1,000,000 in that case for a
	-- really rare spawn

	-- Item Categories can be nested to allow for a great amount of variety
	--   when spawning items

	aiCategories =
	{
		-- AI
		{
			category = "AI",
			classes =
			{
				{ class = "Grunt", percent = 100 },
			},
		},
	},
}

function ActorSpawner:OnSpawn()
	self:SetFlags(ENTITY_FLAG_SERVER_ONLY, 0);
end

function ActorSpawner:OnInit()
	self:OnReset();
end

function ActorSpawner:OnPropertyChange()
	self:OnReset();
end

function ActorSpawner:OnReset()
	self.enabled = nil;
	self:Enable(tonumber(self.Properties.bEnabled)~=0);
end

function ActorSpawner:Enable(enable)
	self.enabled=enable;
end

function ActorSpawner:Event_Enable(sender)
	self:Enable(true);
	BroadcastEvent(self, "Enable");
end

function ActorSpawner:Event_Disable(sender)
	self:Enable(false);
	BroadcastEvent(self, "Disable");
end

ActorSpawner.FlowEvents =
{
	Inputs =
	{
		Disable = { ActorSpawner.Event_Disable, "bool" },
		Enable = { ActorSpawner.Event_Enable, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
	},
}
