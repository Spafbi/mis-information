Rooster = {
	type = "Rooster",

	Properties = {

		object_Model = "objects/characters/animals/birds/rooster/rooster.cdf",
		Size = 1,
		SizeRandom = 0, -- doesn't work yet - don't remove
		RelevanceDistance = -1.0, -- default is 25 meters - keep as small as possible/reasonable (if <= 0, will use appropriate net_relevance cvar)
		esLootItemCategory = "RandomChickenLoot", -- loot category must exist in ItemSpawnerManager.lua, empty/missing means no loot
		eiCarryType = 1, -- How object is carried 0=can't carry,1=onehanded,2=onehanded_side,3=twohanded_ontop,4=twohanded_reacharound,5=overshoulder
		esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
		
		Damage =
		{
			Health = 20
		},
		
		Physics =
		{
			Mass = 10,
			Gravity = -13,
			Inertia = 10.0,
			InertiaAccel = 11.0,
			MaxVelGround = 3,
			MinSlideAngle = 75.0,
			MaxClimbAngle = 75.0,
			MinFallAngle = 80.0,
		},
		Movement =
		{
			MaxTurnRate = 360, -- Turn rate in degrees per seconds
			ForceTurnOnSpotAngle = 45.0, -- Min Angle (degrees) between move dir and body dir at which we should force turning on the spot before moving
		},
		
		Stances =
		{
			{
				StanceId       = STANCE_STAND,
				Name           = "stand",
				HeightPivot    = 0.0,
				HeightCollider = 0.3,
				SizeCollider   = {x=0.25,y=0.25,z=0.0},
				ViewOffset     = {x=0.0, y=0.1, z=0.35},
				bUseCapsule    = 1,
			},
		},
		
		AI =
		{
			bKytheraEnabled = 0,
			esKytheraProfile = "Rooster", -- valid profiles defined in Scripts/Kythera/Profiles.xml
			SimpleAI =
			{
				SpeedMin = 0.4,
				SpeedDefault = 0.45, -- currently everything always moves at this speed - no randomization
				SpeedMax = 0.5,

				IdleTimeMin = 2.0,
				IdleTimeMax = 20.0,
				WalkTimeMin = 4.0,
				WalkTimeMax = 20.0,

				FactorOrigin = 0.05,
				FactorAvoidLand = 10,

				CollisionDistance = 1.0, -- in meters - lookahead distance (at min speed - scaled up for higher speeds)
				CollisionCheckTime = 0.2, -- in seconds to check for a collision
				
				bAvoidWater = 1,
				bObstacleAvoidance = 1,
			},
		},
		
		Readabilities =
		{
			bUseMannequin = 0, -- If not using mannequin we use the simple readabilities
			Simple =
			{
				MaxAnimationSpeed = 1.0, -- Animation speed multiplier at max speed -- leave at 1 currently
				Sounds = 
				{
					Stopped = "Play_chicken_idle",
					Moving = "Play_chicken_idle",
					Scared = "Play_chicken_scared", -- not currently used
					Death = "Play_chicken_death",
				},
				Animations = 
				{
					Stopped = "idle01_loop",
					Moving = "walk_loop",
					Scared = "idle01_loop", -- not currently used
					Death = "idle01_loop",
					Carry = "carry",
				},
			},
		},
	},

	Editor={
		Icon = "Bird.bmp"
	},

	Client = {},
	Server = {},
}


function Rooster:OnInit()
	self:OnReset();
end

function Rooster:OnPropertyChange()
	self:OnReset();
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Rooster:OnReset()
end

function Rooster:IsActionable(user)	
	--Log("[ Animal ] IsActionable");
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Rooster:GetActions(user)
	--Log("[ Animal ] GetActions");
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Rooster:PerformAction(user, action)
	--Log("[ Animal ] PerformAction: action="..action);
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Rooster:OnSave(tbl)
end

function Rooster:OnLoad(tbl)
end

function Rooster:OnShutDown()
end

function Rooster.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Rooster:IsDead()
	return Animals.IsDead(self);
end