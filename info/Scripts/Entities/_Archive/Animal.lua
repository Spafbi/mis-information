Animal = {
	type = "Animal",

	AnimationGraph = "animal.xml",

	Properties = {

		Animal = 
		{
			object_Model = "objects/characters/animals/alligator/alligator.cdf",
			Mass = 10,
			Size = 1,
			SizeRandom = 0,
			GravityAtDeath = -9.81,
		},

		Movement =
		{
			HeightMin = 0,
			HeightMax = 1,
			SpeedMin = 0.1,
			SpeedMax = 5,
			SpeedWalk = 0.5,
			WalkTimeMax = 20.0,
			IdleTimeMax = 20.0,
			FactorOrigin = 0.0,
			FactorAvoidLand = 10,
			MaxAnimationSpeed = 0.33,
		},

		Options = 
		{
			bAvoidWater = 1,
			bObstacleAvoidance = 1,
			VisibilityDist = 25,
			Radius = 1,
		},
	},
	
	Sounds = 
	{
		"Sounds/environment:boids:idle_chicken",   -- idle 
		"Sounds/environment:boids:scared_chicken", -- scared
		"Sounds/environment:boids:death_chicken",  -- die
	},

	Editor={
		Icon = "Bird.bmp"
	},

	Client = {},
	Server = {},
}


function Animal:OnInit()
	self:OnReset();
end

function Animal:OnPropertyChange()
	self:OnReset();
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Animal:OnReset()
end

function Animal:IsActionable(user)	
	return true;
end

function Animal:GetActions(user)
	Log("[ Animal ] GetActions");

	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Animal:PerformAction(user, action)
	Log("[ Animal ] PerformAction: action="..action);

	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Animal:OnSave(tbl)
end

function Animal:OnLoad(tbl)
end

function Animal:OnShutDown()
end

function Animal.Client:OnHit(hit)
	if (not self.bWasHit) then
		self.bWasHit = 1;
		Animals.OnAnimalHit(self, hit);	
	end
end

function Animal.Server:OnHit(hit)
	if (not self.bWasHit) then
		self.bWasHit = 1;
		Animals.OnAnimalHit(self, hit);	
	end
end

function Animal:Event_Enable( sender )
end

function Animal:Event_Disable( sender )
end

Animal.FlowEvents =
{
	Inputs =
	{
		Disable = { Animal.Event_Disable, "bool" },
		Enable = { Animal.Event_Enable, "bool" },
	},
	Outputs =
	{
		Disable = "bool",
		Enable = "bool",
		TargetReached = "bool",
	},
}
