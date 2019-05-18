TwoHeadDog = {
	type = "TwoHeadDog",
	
	ActionController = "Animations/Mannequin/ADB/twoheaddogControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/twoheaddog.adb",
	SoundDatabase = "Animations/Mannequin/ADB/twoheaddogSounds.adb",
	UseMannequinAGState = true,


	Properties = {

		object_Model = "objects/characters/mutants/twoheaddog/twoheaddog.cdf",
		Size = 1,
		SizeRandom = 0, -- doesn't work yet - don't remove
		RelevanceDistance = -1.0, -- default is 25 meters - keep as small as possible/reasonable (if <= 0, will use appropriate net_relevance cvar)
		esLootItemCategory = "RandomWolfLoot", -- loot category must exist in ItemSpawnerManager.lua, empty/missing means no loot
		eiCarryType = 0, -- How object is carried 0=can't carry,1=onehanded,2=onehanded_side,3=twohanded_ontop,4=twohanded_reacharound,5=overshoulder
		esFaction = "Mutants", -- empty faction will make this animal be ignored as a target by all other AI
		
		Damage =
		{
			Health = 90, 
			fileBodyDamage = "Libs/BodyDamage/BodyDamage_TwoHeadDog.xml",  -- Not used by animal system - this is read in directly by Body Damage system
			fileBodyDamageParts = "Libs/BodyDamage/Bodyparts_TwoHeadDog.xml",  -- Not used by animal system - this is read in directly by Body Damage system
		},
		
		Physics =
		{
			Mass = 50,
			Gravity = -13,
			Inertia = 10.0,
			InertiaAccel = 11.0,
			MaxVelGround = 5,
			MinSlideAngle = 75.0,
			MaxClimbAngle = 75.0,
			MinFallAngle = 80.0,
		},
		
		Movement =
		{
			MaxTurnRate = 360, -- Turn rate (degrees per second)
			ForceTurnOnSpotAngle = 90.0, -- Min Angle (degrees) between move dir and body dir at which we should force turning on the spot before moving
		},
		
		Stances =
		{
			{
				StanceId       = STANCE_STAND,
				Name           = "stand",
				HeightPivot    = 0.0,
				HeightCollider = 0.6,
				SizeCollider   = {x=0.4, y=0.4, z=0.0},
				ViewOffset     = {x=0.0, y=0.5, z=0.8},
				bUseCapsule    = 1,
			},
		},
		
		AI =
		{
			bKytheraEnabled = 1,
			esKytheraProfile = "MutantDog", -- valid profiles defined in Scripts/Kythera/Profiles.xml
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
					Hurt = "Play_dog_mutant_hurt",
					Death = "Play_dog_mutant_death",
				},
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

function TwoHeadDog:OnInit()
	self:OnReset();
end

function TwoHeadDog:OnPropertyChange()
	self:OnReset();
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function TwoHeadDog:OnReset()
end

function TwoHeadDog:IsActionable(user)	
	--Log("[ Animal ] IsActionable");
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function TwoHeadDog:GetActions(user)
	--Log("[ Animal ] GetActions");
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function TwoHeadDog:PerformAction(user, action)
	--Log("[ Animal ] PerformAction: action="..action);
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function TwoHeadDog:OnSave(tbl)
end

function TwoHeadDog:OnLoad(tbl)
end

function TwoHeadDog:OnShutDown()
end

function TwoHeadDog.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function TwoHeadDog:IsDead()
	return Animals.IsDead(self);
end
