Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Scorpions = 
{
	Properties = 
	{
	Boid = 
		{
			nCount = 5,
			object_Model = "objects/characters/animals/scorpion/scorpion.cdf",
		},
		Movement =
		{
			SpeedMin = 0,
			SpeedMax = 1,
			MaxAnimSpeed = 1,
		},
	},
	Audio = 
	{
		"Play_idle_rat",	-- idle
		"Play_scared_rat",	-- scared
		"Play_scared_rat",	-- die
		"Play_scared_rat",	-- pickup
		"Play_scared_rat",	-- throw
	},
	Animations = 
	{
		"walk_loop",	-- walking
		"idle01_loop",	-- idle1
		"idle01_loop",	-- idle2
		"idle01_loop",	-- idle3
		"idle01_loop",	-- pickup
		"idle01_loop",	-- throw
	},
	Editor = 
	{
		Icon = "chicken.bmp"
	},
}

MakeDerivedEntityOverride( Scorpions, Chickens )


function Scorpions:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

function Scorpions:GetFlockType()
	return Boids.FLOCK_CHICKENS;
end