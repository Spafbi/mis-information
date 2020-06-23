Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Squirrels =
{
	Properties = 
	{
		Boid = 
		{
			object_Model = "objects/characters/animals/squirrel/squirrel.cdf",
		},
		Options = 
		{
			bPlaySounds = 0,
		},
	},
	Audio =
	{
		"",	-- idle
		"",	-- scared
		"",	-- die
		"",	-- pickup
		"",	-- throw
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
}


MakeDerivedEntityOverride( Squirrels,Chickens )

function Squirrels:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end