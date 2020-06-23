Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Rats = 
{
	Properties = 
	{
	Boid = 
		{
			object_Model = "objects/characters/animals/rat/rat.cdf",
		}
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

MakeDerivedEntityOverride( Rats, Chickens )


function Rats:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

function Rats:GetFlockType()
	return Boids.FLOCK_CHICKENS;
end