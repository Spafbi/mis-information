Deer_x = {
	type = "Deer",
	
	ActionController = "Animations/Mannequin/ADB/deerControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/deer.adb",
	SoundDatabase = "Animations/Mannequin/ADB/deerSounds.adb",
	UseMannequinAGState = true,


	Properties = {

		object_Model = "objects/characters/animals/deer/deer.cdf",
		Size = 1,
		SizeRandom = 0, -- doesn't work yet - don't remove
		RelevanceDistance = -1.0, -- default is 25 meters - keep as small as possible/reasonable (if <= 0, will use appropriate net_relevance cvar)
		esLootItemCategory = "RandomDeerLoot", -- loot category must exist in ItemSpawnerManager.lua, empty/missing means no loot
		eiCarryType = 0, -- How object is carried 0=can't carry,1=onehanded,2=onehanded_side,3=twohanded_ontop,4=twohanded_reacharound,5=overshoulder
		esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
		
		Damage =
		{
			Health = 30, 
			FatalImpulse = 750, -- Collision impulse at which animal will be killed
			fileBodyDamage = "Libs/BodyDamage/BodyDamage_Deer.xml",  -- Not used by animal system - this is read in directly by Body Damage system
			fileBodyDamageParts = "Libs/BodyDamage/BodyParts_Deer.xml",  -- Not used by animal system - this is read in directly by Body Damage system
		},
		
		Physics =
		{
			Mass = 140,
			Gravity = -13,
			Inertia = 10.0,
			InertiaAccel = 11.0,
			MaxVelGround = 16,
			MinSlideAngle = 75.0,
			MaxClimbAngle = 75.0,
			MinFallAngle = 80.0,
		},
		
		Movement =
		{
			MaxTurnRate = 180, -- Turn rate (degrees per second)
			ForceTurnOnSpotAngle = 90.0, -- Min Angle (degrees) between move dir and body dir at which we should force turning on the spot before moving
		},
		
		Stances =
		{
			{
				StanceId       = STANCE_STAND,
				Name           = "stand",
				HeightPivot    = 0.0,
				HeightCollider = 0.9,
				SizeCollider   = {x=0.6,y=0.6,z=0.0},
				ViewOffset     = {x=0.0, y=1.0, z=1.25},
				bUseCapsule    = 1,
			},
		},
		
		AI =
		{
			bKytheraEnabled = 1,
			esKytheraProfile = "Deer", -- valid profiles defined in Scripts/Kythera/Profiles.xml
		},
		
		Readabilities =
		{
			bUseMannequin = 1, -- If not using mannequin we use the simple readabilities
			Mannequin =
			{
				TurnStartDelay = 0.5, -- Duration (seconds) once current angle deviation is above TurnDelayMinAngle before the character turns
				TurnDelayMinAngle = 5,  -- Angle (degrees) that the character has to deviate from the entity before the turn timer (TurnStartDelay) starts
				TurnImmediateAngle = 30, -- Angle (degrees) that the character has to deviate from the entity before turning will be started without delay
			},
		},
		
		Bones =
		{
			-- Only used for footstep anim events so far, so just adding the feet
			BONE_FOOT_R = "Def_R_Wrist_jnt",
			BONE_FOOT_L = "Def_L_Wrist_jnt",
			BONE_FOOT_R2 = "Def_R_Toe_jnt", -- back right
			BONE_FOOT_L2 = "Def_L_Toe_jnt", -- back left
		},

		CharacterSounds =
		{
			footstepEffect = "footstep_animal_medium",			-- Footstep mfx library to use
		},
	},

	Editor={
		Icon = "Character.bmp"
	},

	Client = {},
	Server = {},
}

function Deer_x:OnInit()
	self:OnReset();
end

function Deer_x:OnPropertyChange()
	self:OnReset();
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Deer_x:OnReset()
end

function Deer_x:IsActionable(user)	
	--Log("[ Animal ] IsActionable");
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Deer_x:GetActions(user)
	--Log("[ Animal ] GetActions");
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Deer_x:PerformAction(user, action)
	--Log("[ Animal ] PerformAction: action="..action);
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Deer_x:OnSave(tbl)
end

function Deer_x:OnLoad(tbl)
end

function Deer_x:OnShutDown()
end

function Deer_x.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Deer_x:IsDead()
	return Animals.IsDead(self);
end
