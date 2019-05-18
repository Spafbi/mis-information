Script.ReloadScript( "Scripts/Entities/Boids/Chickens.lua" );

Salamanders = 
{
	Properties = 
	{
	Boid = 
		{
			object_Model = "objects/characters/animals/salamander/salamander.cdf",
		}
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
		"walk_loop",        -- walking
		"idle01_loop",      -- idle1
		"idle01_loop",      -- idle2
		"idle01_loop",      -- idle3
		"idle01_loop",      -- pickup
		"idle01_loop",      -- throw
	},
	Editor = 
	{
		Icon = "lizard.bmp"
	},
}

MakeDerivedEntityOverride( Salamanders, Chickens )


function Salamanders:OnSpawn()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY, 0);
end

function Salamanders:GetFlockType()
	return Boids.FLOCK_CHICKENS;
end