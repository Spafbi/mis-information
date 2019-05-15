Script.ReloadScript( "Scripts/Entities/Boids/Birds.lua" );

Bats = 
{
	Properties = 
	{
		Boid =
		{
			object_Model = "objects/characters/animals/bat/bat.cdf",
		},
		Flocking =
		{
			FactorAlign = 0.5, -- Bat flocking behavior a bit more erratic
			FactorCohesion = 0.5,
		},
		Movement =
		{
			SpeedMin = 2, -- Bat movement faster than normal birds
			SpeedMax = 4,
		},
		Options =
		{
			bNoLanding = 1, -- Bats should never land
			bStartOnGround = 0,
			Radius = 20, -- Larger flight area for more erratic flocking behavior
		},
	},
	Audio =
	{
		"Play_scared_bat",	-- idle
		"Play_scared_bat",	-- scared
	},
}

MakeDerivedEntityOverride( Bats,Birds )


function Bats:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end