Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Turtles =
{
	Properties = 
	{
		Boid = 
		{
			object_Model = "Objects/characters/animals/reptiles/turtle/red_eared_slider.cdf",
		},
		Movement =
		{
			SpeedMin = 0.4,
			SpeedMax = 0.4,
			MaxAnimSpeed = 2.5,
		},
		Options =
		{
			bPlaySounds = 0,
		},
	},
	Audio =
	{
		"",		-- idle
		"",		-- scared
		"",		-- die
		"",		-- pickup
		"",		-- throw
	},
	Animations =
	{
		"walk_loop",	-- walking
		"idle01_loop",	-- idle1
		"scared",		-- scared anim
		"idle3",		-- idle3
		"pickup",		-- pickup
		"throw",		-- throw
	},
	Editor = 
	{
		Icon = "lizard.bmp"
	},
}


MakeDerivedEntityOverride( Turtles,Chickens )

function Turtles:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

function Turtles:GetFlockType()
	return Boids.FLOCK_TURTLES;
end