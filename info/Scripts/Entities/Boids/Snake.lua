Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Snake =
{
	Properties =
	{
		Boid =
		{
			object_Model = "objects/characters/animals/snake/snake.cdf",
		},
		Movement =
		{
			HeightMin = 0,
			HeightMax = 0.1,
			SpeedMin = 1,
			SpeedMax = 2,
			MaxAnimSpeed = 1,
		},
	},
	Audio =
	{
		"",	-- idle
		"Play_scared_snake",	-- scared
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
	Editor = 
	{
		Icon = "lizard.bmp"
	},
}

MakeDerivedEntityOverride( Snake,Chickens )

function Snake:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end