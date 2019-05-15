GiantRoach = {
	type = "GiantRoach",

	ActionController = "Animations/Mannequin/ADB/giant_roachControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/giant_roach.adb",

	UseMannequinAGState = true,

	Properties =
	{
		object_Model = "objects/characters/animals/giant_roach/giant_roach.cdf",
		Size = 1,
		SizeRandom = 0, -- doesn't work yet - don't remove
		RelevanceDistance = -1.0, -- default is 25 meters - keep as small as possible/reasonable (if <= 0, will use appropriate net_relevance cvar)

		esLootItemCategory = "", -- loot category must exist in ItemSpawnerManager.lua, empty/missing means no loot
		eiCarryType = 0, -- How object is carried 0=can't carry,1=onehanded,2=onehanded_side,3=twohanded_ontop,4=twohanded_reacharound,5=overshoulder
		esFaction = "Predators", -- empty faction will make this animal be ignored as a target by all other AI

		Damage =
		{
			Health = 50
		},

		Physics =
		{
			Mass = 20,
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
			ForceTurnOnSpotAngle = 0.0, -- Min Angle (degrees) between move dir and body dir at which we should force turning on the spot before moving
		},

		Stances =
		{
			{
				StanceId       = STANCE_STAND,
				Name           = "stand",
				HeightPivot    = 0.0,
				HeightCollider = 0.3,
				SizeCollider   = {x=0.35,y=0.35,z=0.1},
				ViewOffset     = {x=0.0, y=0.1, z=0.15},
				bUseCapsule    = 1,
			},
		},

		AI =
		{
			bKytheraEnabled = 1,
			esKytheraProfile = "GiantRoach", -- valid profiles defined in Scripts/Kythera/Profiles.xml
		},

		Readabilities =
		{
			bUseMannequin = 1, -- If not using mannequin we use the simple readabilities
			Mannequin =
			{
				TurnStartDelay = 0.5, -- Duration (seconds) once current angle deviation is above TurnDelayMinAngle before the character turns
				TurnDelayMinAngle = 5,  -- Angle (degrees) that the character has to deviate from the entity before the turn timer (TurnStartDelay) starts
				TurnImmediateAngle = 30, -- Angle (degrees) that the character has to deviate from the entity before turning will be started without delay

				-- These are a simple replacement for the AI Communication manager used by actors, just to give basic hurt and death sound support
				Sounds =
				{
					Hurt = "Play_baby_spider_death",
					Death = "Play_baby_spider_death",
				},
			},
		},
	},

	Editor=
	{
		Icon = "Character.bmp"
	},

	Client = {},
	Server = {},
}


function GiantRoach:OnInit()
	self:OnReset();
end

function GiantRoach:OnPropertyChange()
	self:OnReset();
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function GiantRoach:OnReset()
end

function GiantRoach:IsActionable(user)
	--Log("[ Animal ] IsActionable");
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function GiantRoach:GetActions(user)
	--Log("[ Animal ] GetActions");
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function GiantRoach:PerformAction(user, action)
	--Log("[ Animal ] PerformAction: action="..action);
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function GiantRoach:OnSave(tbl)
end

function GiantRoach:OnLoad(tbl)
end

function GiantRoach:OnShutDown()
end

function GiantRoach.Server:OnHit(hit)
	return Animals.OnHit(self, hit);
end

function GiantRoach:IsDead()
	return Animals.IsDead(self);
end