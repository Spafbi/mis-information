Script.ReloadScript( "Scripts/Entities/Boids/Birds.lua" );

Crows = 
{
	Properties = 
	{
		Boid =
		{
			object_Model = "objects/characters/animals/birds/crow/crow.cdf",
		},
	},
	Audio =
	{
		"Play_idle_crow",		-- idle
		"Play_scared_crow",		-- scared
	},
}

MakeDerivedEntityOverride( Crows,Birds )


function Crows:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end