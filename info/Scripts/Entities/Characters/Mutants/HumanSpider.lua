HumanSpider = {
	type = "HumanSpider",
	
	ActionController = "Animations/Mannequin/ADB/human_spiderControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/human_spider.adb",
	SoundDatabase = "Animations/Mannequin/ADB/human_spiderSounds.adb",
	UseMannequinAGState = true,


	Properties = {

		object_Model = "objects/characters/mutants/human_spider/human_spider.cdf",
		Size = 1,
		SizeRandom = 0, -- doesn't work yet - don't remove
		RelevanceDistance = -1.0, -- default is 25 meters - keep as small as possible/reasonable (if <= 0, will use appropriate net_relevance cvar)
		esLootItemCategory = "RandomHumanSpiderLoot", -- loot category must exist in ItemSpawnerManager.lua, empty/missing means no loot
		eiCarryType = 0, -- How object is carried 0=can't carry,1=onehanded,2=onehanded_side,3=twohanded_ontop,4=twohanded_reacharound,5=overshoulder
		esFaction = "Mutants", -- empty faction will make this animal be ignored as a target by all other AI
		
		Damage =
		{
			Health = 250, 
			fileBodyDamage = "Libs/BodyDamage/BodyDamage_HumanSpider.xml",  -- Not used by animal system - this is read in directly by Body Damage system
			fileBodyDamageParts = "Libs/BodyDamage/BodyParts_HumanSpider.xml",  -- Not used by animal system - this is read in directly by Body Damage system
			fileBodyDestructibility = "Libs/BodyDamage/BodyDestructibility_HumanSpider.xml",  -- Not used by animal system - this is read in directly by Body Damage system
		},
		
		Physics =
		{
			Mass = 250,
			Gravity = -13,
			Inertia = 5.0,
			InertiaAccel = 11.0,
			MaxVelGround = 5,
			MinSlideAngle = 75.0,
			MaxClimbAngle = 75.0,
			MinFallAngle = 80.0,
		},
		
		Movement =
		{
			MaxTurnRate = 360.0, -- Turn rate (degrees per second)
			ForceTurnOnSpotAngle = 0.0, -- Min Angle (degrees) between move dir and body dir at which we should force turning on the spot before moving
		},
		
		Stances =
		{
			{
				StanceId       = STANCE_STAND,
				Name           = "stand",
				HeightPivot    = 0.0,
				HeightCollider = 1.2,
				SizeCollider   = {x=0.55, y=0.55, z=0.3},
				ViewOffset     = {x=0, y=0.1, z=0.5},
				bUseCapsule    = 1,
			},
		},
		
		AI =
		{
			bKytheraEnabled = 1,
			esKytheraProfile = "HumanSpider", -- valid profiles defined in Scripts/Kythera/Profiles.xml
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
					Hurt = "Play_spiker_hurt",
					Death = "Play_spiker_death",
				},
			},
		},

		Bones =
		{
			BONE_FOOT_R = "HS_R_hand",
			BONE_FOOT_L = "HS_L_hand",
			BONE_FOOT_R2 = "HS_leg_R_4", -- back right
			BONE_FOOT_L2 = "HS_leg_L_4", -- back left
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

function HumanSpider:OnInit()
	self:OnReset();
end

function HumanSpider:OnPropertyChange()
	self:OnReset();
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function HumanSpider:OnReset()
end

function HumanSpider:IsActionable(user)	
	--Log("[ Animal ] IsActionable");
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function HumanSpider:GetActions(user)
	--Log("[ Animal ] GetActions");
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function HumanSpider:PerformAction(user, action)
	--Log("[ Animal ] PerformAction: action="..action);
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function HumanSpider:OnSave(tbl)
end

function HumanSpider:OnLoad(tbl)
end

function HumanSpider:OnShutDown()
end

function HumanSpider.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function HumanSpider:IsDead()
	return Animals.IsDead(self);
end
