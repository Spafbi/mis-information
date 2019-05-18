Script.ReloadScript( "Scripts/Entities/Boids/Birds.lua" );

Eagle = 
{
	Properties = 
	{
		Boid =
		{
			nCount = 1,
			object_Model = "objects/characters/animals/birds/bald_eagle/bald_eagle.cdf",
		},
		Flocking =
		{
			bEnableFlocking = 0, -- No flocking, Eagle is loner
		},
		Movement = 
		{
			FactorOrigin = 0.01, -- Don't want Eagle turning frequently
			HeightMin = 30,
			HeightMax = 50,
			MaxAnimSpeed = 1.0, -- Slower anim speed for Eagle, should be done in anims
		},
		Options =
		{
			bNoLanding = 1, -- Eagle should never land
			bStartOnGround = 0,
			Radius = 50, -- Large area radius for Eagle to fly in
		},
	},
	Audio =
	{
		"Play_idle_eagle",		-- idle
		"Play_scared_eagle",	-- scared
	},
}

MakeDerivedEntityOverride( Eagle,Birds )


function Eagle:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end