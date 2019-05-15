HumanZombie = {
	type = "HumanZombie",
	
	ActionController = "Animations/Mannequin/ADB/humanzombieControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/humanzombie.adb",
	SoundDatabase = "Animations/Mannequin/ADB/humanzombieSounds.adb",
	UseMannequinAGState = true,


	Properties = {

		object_Model = "objects/characters/mutants/humanzombie/humanzombie.cdf",
		Size = 1,
		SizeRandom = 0, -- doesn't work yet - don't remove
		RelevanceDistance = -1.0, -- default is 25 meters - keep as small as possible/reasonable (if <= 0, will use appropriate net_relevance cvar)
		esLootItemCategory = "RandomMutantLoot", -- loot category must exist in ItemSpawnerManager.lua, empty/missing means no loot
		eiCarryType = 0, -- How object is carried 0=can't carry,1=onehanded,2=onehanded_side,3=twohanded_ontop,4=twohanded_reacharound,5=overshoulder
		esFaction = "Mutants", -- empty faction will make this animal be ignored as a target by all other AI
		
		Damage =
		{
			Health = 100, 
			fileBodyDamage = "Libs/BodyDamage/BodyDamage_MutantsSharedBiped.xml",  -- Not used by animal system - this is read in directly by Body Damage system
			fileBodyDamageParts = "Libs/BodyDamage/BodyParts_MutantsSharedBiped.xml",  -- Not used by animal system - this is read in directly by Body Damage system
			fileBodyDestructibility = "Libs/BodyDamage/BodyDestructibility_MutantsSharedBiped.xml",  -- Not used by animal system - this is read in directly by Body Damage system
		},
		
		Physics =
		{
			Mass = 110,
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
			MaxTurnRate = 360, -- Turn rate (degrees per second)
			ForceTurnOnSpotAngle = 0.0, -- Min Angle (degrees) between move dir and body dir at which we should force turning on the spot before moving
		},
		
		Stances =
		{
			{
				StanceId       = STANCE_STAND,
				Name           = "stand",
				HeightPivot    = 0.0,
				HeightCollider = 1.1,
				SizeCollider   = {x=0.35, y=0.35, z=0.35},
				ViewOffset     = {x=0.0,  y=0.1,  z=1.625},
				bUseCapsule    = 1,
			},
		},
		
		AI =
		{
			bKytheraEnabled = 1,
			esKytheraProfile = "HumanZombie", -- valid profiles defined in Scripts/Kythera/Profiles.xml
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
					Hurt = "Play_human_mutant_hurt",
					Death = "Play_human_mutant_death",
				},
			},
		},

		Bones =
		{
			-- Only used for footstep anim events so far, so just adding the feet
			BONE_FOOT_R = "Bip01 R Foot",
			BONE_FOOT_L = "Bip01 L Foot",
		},

		CharacterSounds =
		{
			footstepEffect = "footstep_npc_shoes",			-- Footstep mfx library to use
		},
	},

	Editor={
		Icon = "Character.bmp"
	},

	Client = {},
	Server = {},
}

function HumanZombie:OnInit()
	self:OnReset();
end

function HumanZombie:OnPropertyChange()
	self:OnReset();
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function HumanZombie:OnReset()
end

function HumanZombie:IsActionable(user)	
	--Log("[ Animal ] IsActionable");
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function HumanZombie:GetActions(user)
	--Log("[ Animal ] GetActions");
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function HumanZombie:PerformAction(user, action)
	--Log("[ Animal ] PerformAction: action="..action);
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function HumanZombie:OnSave(tbl)
end

function HumanZombie:OnLoad(tbl)
end

function HumanZombie:OnShutDown()
end

function HumanZombie.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function HumanZombie:IsDead()
	return Animals.IsDead(self);
end
