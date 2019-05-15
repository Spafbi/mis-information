Script.ReloadScript( "Scripts/Entities/Boids/Birds.lua" );

Seagulls = 
{
	Properties = 
	{
		Boid =
		{
			object_Model = "objects/characters/animals/birds/seagull/seagull.cdf",
		},
		Flocking =
		{
			FactorAlign = 0.5, -- Seagull flocking behavior a bit more erratic
			FactorCohesion = 0.5,
		},
		Movement =
		{
			MaxAnimSpeed = 1,
		},
		Options =
		{
			bNoLanding = 1, -- Seagulls should never land
			bStartOnGround = 0,
			Radius = 20, -- Larger flight area for more erratic flocking behavior
		},
	},
	Audio =
	{
		"Play_idle_seagull",	-- idle
		"Play_scared_seagull",	-- scared
	},
}

MakeDerivedEntityOverride( Seagulls,Birds )


function Seagulls:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end