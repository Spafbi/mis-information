Script.ReloadScript( "SCRIPTS/Entities/actor/BasicActor.lua");

Player = 
{
	AnimationGraph = "player.xml",
	UpperBodyGraph = "",
	ActionController = "Animations/Mannequin/ADB/playerControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/playerAnims3P.adb",
	AnimDatabase1P = "Animations/Mannequin/ADB/playerAnims1P.adb",
	SoundDatabase = "Animations/Mannequin/ADB/playerSounds.adb",

	type = "Player",

	Properties =
	{
		-- AI-related properties
		soclasses_SmartObjectClass = "Player",
		groupid = 0,
		esFaction = "Players",
		commrange = 40; -- Luciano - added to use SIGNALFILTER_GROUPONLY

		aicharacter_character = "Player",
		
		-- Kythera
		esKytheraProfile = "Player", -- valid profiles defined in Scripts/Kythera/Profiles.xml
		
		maxFireDuration = 10,

		Damage =
		{
			bLogDamages = 0,
			health = 100, -- See  Player:SetIsMultiplayer()  for MP value
			--playerMult = 1.0,
			--AIMult = 1.0,
			FallSleepTime = 6.0,

			fileBodyDamage = "Libs/BodyDamage/BodyDamage_MP.xml";
			fileBodyDamageParts = "Libs/BodyDamage/BodyParts_HumanMaleShared.xml";
			fileBodyDestructibility = "Libs/BodyDamage/BodyDestructibility_Default.xml";
		},

		CharacterSounds =
		{
			footstepEffect = "footstep_player",		-- Footstep mfx library to use
			remoteFootstepEffect = "footstep_player",		-- Footstep mfx library to use for remote players
			bFootstepGearEffect = 0,				-- This plays a sound from materialfx
			footstepIndGearAudioSignal_Walk = "Player_Footstep_Gear_Walk",	-- This directly plays the specified audiosignal on every footstep
			footstepIndGearAudioSignal_Run = "Player_Footstep_Gear_Run",	-- This directly plays the specified audiosignal on every footstep
			foleyEffect = "foley_player",			-- Foley signal effect name
		},

		Perception =
		{
			--ranges
			sightrange = 50,
		},

		fileModel = "Objects/Characters/players/male/human_male.cdf",
		fileModelFemale = "Objects/Characters/players/female/human_female.cdf",
		-- EI don't need this because of SFP mode shadowFileModel = "Objects/Characters/players/male/human_male.cdf", -- this is different in C3, why?
		-- EI don't need because we use the fileModel above clientFileModel = "Objects/Characters/players/male/human_male.cdf",

		fileHitDeathReactionsParamsDataFile = "Libs/HitDeathReactionsData/HitDeathReactions_MP.xml",
	},

	PropertiesInstance = 
	{
		aibehavior_behaviour = "PlayerIdle",
	},

	gameParams =
	{
		strafeMultiplier = 0.9,

		inventory =
		{
			items =
			{
				{ name = "Zeus", equip = true },
			},
			ammo =
			{
				{ name = "lightbullet", amount = 28},
			},
		},

		Damage =
		{
			health = 1000,
		},

		stance =
		{
			{
				stanceId = STANCE_STAND,
				maxSpeed = 4.0,
				heightCollider = 1.25,
				heightPivot = 0.0,
				size = {x=0.4,y=0.4,z=0.25},
				viewOffset = {x=0.04,y=0.02,z=1.7},
				weaponOffset = {x=0.2,y=0.0,z=1.35},
				viewDownYMod = 0.05,
				modelOffset = {x=0,y=0,z=0.0},
				name = "stand",
				useCapsule = 1,
			},

			{
				stanceId = -2, -- -2 is a magic number that gets ignored by CActor::SetupStance
			},

			{
				stanceId = STANCE_PRONE,
				maxSpeed = 0.75, -- See  Player:SetIsMultiplayer()  for MP value
				heightPivot = 0.0,

				viewOffset = {x=0.05,y=0.75,z=0.327}, -- this is the offset of the firstperson scope camera, no real influence on tp/sfp camera..
				weaponOffset = {x=0,y=0,z=0},
				viewDownYMod = 0.00,
				modelOffset = {x=0,y=0,z=0},
				name = "prone",

				-- z = (half height), x = radius
				--size = {x=0.125,y=0,z=0.125}, -- capsule worked up to 45° 
				--size = {x=0.15,y=0,z=0.2},-- capsule worked up to 30°
				--size = {x=0.3,y=0,z=0.29},-- orientated big capsule does work ok for very low slopes
				--size = {x=0.3,y=0,z=0.25},-- orientated capsule worked ok low slopes
				--size = {x=0.13,y=0,z=0.15},-- orientated capsule works up to 45°
				--size = {x=0.15,y=0,z=0.16},-- orientated capsule works up to 45°
				--size = {x=0.3,y=0,z=0.16},-- orientated capsule works up to 20° with heighcollider 0.36
				--size = {x=0.2,y=0,z=0.16},-- orientated capsule works up to 45° with heighcollider 0.38
				--size = {x=0.25,y=0,z=0.16},-- orientated capsule should works up to 30° with heighcollider 0.38
				--size = {x=0.25,y=0,z=0.16},-- orientated capsule should works up to 40° with heighcollider 0.4

				-- <--- best possible result after long session of tweaking for stepsize, slope, tight places, uneven terrain
				--      but camera protection doesnt work as one can turn into  wall and also cylinder can't be longer
				useCapsule = 1,
				zLeeway = -0.5, --negative leeway means rotate capsule to forward
				size = {x=0.23,y=0,z=0.16},-- orientated capsuleworks up to 45° with heighcollider 0.43 
				heightCollider = 0.43, -- offset capsule
				
				-- <--- best fallback for avoiding camera collisions
				--      but char doesnt fit into tighter uneven areas and max slope is 20°
				--useCapsule = 0,
				--zLeeway = 0.5, -- positive leeway means keep upward capsule rotation
				--size = {x=0.85,y=0,z=0.17}, -- cylinder
				--heightCollider = 0.5, -- offset cylinder
			},

			{
				stanceId = STANCE_UNCONSCIOUS,
				maxSpeed = 0.0, -- See  Player:SetIsMultiplayer()  for MP value
				heightCollider = 0.25,
				heightPivot = 0,
				size = {x=0.01,y=0.01,z=0.01},
				viewOffset = {x=0.0,y=0.0,z=0.327},
				weaponOffset = {x=0,y=0,z=0},
				viewDownYMod = 0.00,
				modelOffset = {x=0,y=0,z=0},
				name = "unconscious",
				useCapsule = 1,
			},


			{
				stanceId = STANCE_WOUNDED,
				maxSpeed = 0.35, -- See  Player:SetIsMultiplayer()  for MP value
				heightCollider = 0.25,
				heightPivot = 0,
				size = {x=0.01,y=0.01,z=0.01},
				viewOffset = {x=0,y=0.0,z=0.0},
				weaponOffset = {x=0,y=0,z=0},
				viewDownYMod = 0.00,
				modelOffset = {x=0,y=0,z=0},
				name = "wounded",
				useCapsule = 1,
			},

			{
				stanceId = STANCE_CROUCH,
				maxSpeed = 1.0, -- See  Player:SetIsMultiplayer()  for MP value
				heightCollider = 0.85,
				heightPivot = 0,
				size = {x=0.4,y=0.4,z=0.1},
				viewOffset = {x=0.12,y=0.27,z=1.15},
				weaponOffset = {x=0.2,y=0.0,z=0.85},
				viewDownYMod = 0.05,
				modelOffset = {x=0,y=0,z=0},
				name = "crouch",
				useCapsule = 1,
			},

			{
				stanceId = STANCE_SWIM,
				maxSpeed = 2.1,
				heightCollider = 1.0,
				heightPivot = 0,
				size = {x=0.4,y=0.4,z=0.3},
				viewOffset = {x=0,y=0.1,z=1.5},
				modelOffset = {x=0,y=0,z=0.0},
				weaponOffset = {x=0.3,y=0.0,z=0},
				name = "swim",
				useCapsule = 1,
			},

			{
				stanceId = STANCE_SIT,
				maxSpeed = 0.0,
				heightCollider = 0.6,
				heightPivot = 0,
				size = {x=0.4,y=0.4,z=0.05},
				viewOffset = {x=0,y=0.065,z=1.0},
				weaponOffset = {x=0.2,y=0.0,z=0.85},
				viewDownYMod = 0.05,
				modelOffset = {x=0,y=0,z=0},
				name = "sit",
				useCapsule = 1,
			},
		},

		autoAimTargetParams =
		{
			primaryTargetBone = BONE_SPINE,
			physicsTargetBone = BONE_SPINE,
			secondaryTargetBone = BONE_HEAD,
			fallbackOffset = 1.2,
			innerRadius = 1.0,
			outerRadius = 3.5,
			snapRadius = 1.0,
			snapRadiusTagged = 1.0,
		},

		boneIDs =
		{
			BONE_BIP01 = "Bip01",
			BONE_SPINE = "Bip01 Spine1",
			BONE_SPINE2 = "Bip01 Spine2",
			BONE_SPINE3 = "Bip01 Spine3",
			BONE_HEAD = "Bip01 Head",
			BONE_EYE_R = "eye_right_bone",
			BONE_EYE_L = "eye_left_bone",
			BONE_WEAPON = "weapon_bone",
			BONE_WEAPON2 = "Lweapon_bone",
			BONE_FOOT_R = "Bip01 R Foot",
			BONE_FOOT_L = "Bip01 L Foot",
			BONE_ARM_R = "Bip01 R Forearm",
			BONE_ARM_L = "Bip01 L Forearm",
			BONE_CALF_R = "Bip01 R Calf",
			BONE_CALF_L = "Bip01 L Calf",
			BONE_HAND_R = "Bip01 R Hand",
			BONE_HAND_L = "Bip01 L Hand",
			BONE_CAMERA = "Bip01 Camera",
			BONE_HUD = "Bip01 HUD",
		},

		characterDBAs =
		{
			"HumanPlayer",
			"HumanShared",
		},

		lookFOV = 90,
		aimFOV = 180,

		proceduralLeaningFactor = 0.0, -- disable procedural leaning as we have turn assets now
	},

	SoundSignals =
	{
		FeedbackHit_Armor = -1,
		FeedbackHit_Flesh = -1,
	},


	Server = {},
	Client = {},
	squadFollowMode = 0,

	squadTarget = {x=0,y=0,z=0},
	SignalData = {},

	AI = {},
}

-- Function called from C++ to set up multiplayer parameters
function Player:SetIsMultiplayer()

	--self.Properties.Damage.health = 100;
	--self.Properties.fileModel = "Objects/Characters/players/male/human_male.cdf";
	--self.Properties.shadowFileModel = "Objects/Characters/players/male/human_male.cdf";
	--self.Properties.clientFileModel = "Objects/Characters/players/male/human_male.cdf";
	--self.Properties.fileHitDeathReactionsParamsDataFile = "Libs/HitDeathReactionsData/HitDeathReactions_MP.xml";
	--self.Properties.Damage.fileBodyDamage = "Libs/BodyDamage/BodyDamage_MP.xml";
	--self.Properties.Damage.fileBodyDamageParts = "Libs/BodyDamage/BodyParts_HumanMaleShared.xml";
	--self.Properties.Damage.fileBodyDestructibility = "Libs/BodyDamage/BodyDestructibility_Default.xml";

	--self.gameParams.stance[3].maxSpeed = 2.5;
	--self.gameParams.strafeMultiplier = 0.9; --speed is multiplied by this amount when strafing
	--self.gameParams.crouchMultiplier = 1.0; --speed is multiplied by this amount when crouching
end

function Player:Expose()
	Net.Expose
	{
		Class = self,
		ClientMethods = 
		{
			Revive			= { RELIABLE_ORDERED, POST_ATTACH },
			MoveTo			= { RELIABLE_ORDERED, POST_ATTACH, VEC3 },
			AlignTo			= { RELIABLE_ORDERED, POST_ATTACH, VEC3 },
			ClearInventory	= { RELIABLE_ORDERED, POST_ATTACH },
		},
		ServerMethods = 
		{
			--UseEntity = { RELIABLE_ORDERED, POST_ATTACH, ENTITYID, INT16, BOOL},
		},
		ServerProperties = 
		{
		}
	};
end

function Player.Server:OnInit(bIsReload)
	--self.actor:SetPhysicalizationProfile("alive");

	if AI then
		--AI related: create ai representation for the player
		CryAction.RegisterWithAI(self.id, AIOBJECT_PLAYER, self.Properties,self.PropertiesInstance);

		--AI related: player is leader of squad-mates always
		--AI.SetLeader(self.id);
	end

	self:OnInit(bIsReload);
end

function Player:PhysicalizeActor()
	--BasicActor.PhysicalizeActor(self);
end


function Player:SetModel(model, arms, frozen, fp3p)
	if (model) then
		if (fp3p) then
			self.Properties.clientFileModel = fp3p;
		end
		self.Properties.fileModel = model;
	end
end


function Player.Server:OnInitClient( channelId )
end


function Player.Server:OnPostInitClient( channelId )
	--for i,v in ipairs(self.inventory) do
		--self.onClient:PickUpItem(channelId, v, false);
	--end

	--if (self.inventory:GetCurrentItemId()) then
		--self.onClient:SetCurrentItem(channelId, self.inventory:GetCurrentItemId());
	--end
end


function Player.Client:Revive()
	self.actor:Revive();
end


function Player.Client:MoveTo(pos)
	self:SetWorldPos(pos);
end


function Player.Client:AlignTo(ang)
	self.actor:SetAngles(ang);
end

function Player.Client:ClearInventory()
	self.inventory:Clear();
end

function Player.Client:OnSetPlayerId()
--	HUD:Spawn(self);
end


function Player.Client:OnInit(bIsReload)
	self:OnInit(bIsReload);
end

function Player:OnInit(bIsReload)

--	AI.RegisterWithAI(self.id, AIOBJECT_PLAYER, self.Properties);
	self:SetAIName(self:GetName());
	----------------------------------------

--	self:InitSounds();

	self:OnReset(true, bIsReload);
	--self:SetTimer(0,1);
end


function Player:OnReset(bFromInit, bIsReload)

	self.SoundSignals.FeedbackHit_Armor = GameAudio.GetSignal("PlayerFeedback_HitArmor" );
	self.SoundSignals.FeedbackHit_Flesh = GameAudio.GetSignal("PlayerFeedback_HitFlesh" );

	g_aimode = nil;

	BasicActor.Reset(self, bFromInit, bIsReload);

	self:SetTimer(0,500);

	mergef(Player.SignalData,g_SignalData,1);

--	HUD:Reset();
	self.squadFollowMode = 0;

	--reset the animation graph for third/first person switch.
	--self.actor:ChangeAnimGraph(self.AnimationGraph);

	self.Properties.esFaction = "Players";
	-- Reset all properties to editor set values.
	if AI then AI.ResetParameters(self.id, bIsReload, self.Properties, self.PropertiesInstance, nil,self.melee) end;
--	AI.ChangeParameter(self.id, AIPARAM_SPECIES, 0);

	--g_SignalData.fValue = 20;
	--AI.Signal(SIGNALFILTER_LEADER, 1,"OnEnableAlertStatus",self.id,g_SignalData);

	self.lastOverloadTime = nil;

end

function Player:OnUpdateView(frameTime)
--	HUD:UpdateHUD(self, frameTime, true);--not self:IsHidden());
end

function Player:GrabObject(object, query)
	BasicActor.GrabObject(self, object, query);
end

function Player.Client:OnTimer(timerId,mSec)
	if(timerId==SWITCH_WEAPON_TIMER) then
		if AI then AI.Signal(SIGNALFILTER_GROUPONLY_EXCEPT,1,"CheckNextWeaponAccessory",self.id) end;

		-- set player combat class depending on weapon
		local item = self.inventory:GetCurrentItem();
		if(item and item.class=="LAW") then
			if AI then AI.ChangeParameter( self.id, AIPARAM_COMBATCLASS, AICombatClasses.PlayerRPG ) end
		else
			if AI then AI.ChangeParameter( self.id, AIPARAM_COMBATCLASS, AICombatClasses.Player ) end
		end
	else
		BasicActor.Client.OnTimer(self,timerId,mSec);
	end
end

function Player.Client:OnHit(hit, remote)
	BasicActor.Client.OnHit(self,hit,remote);
end



function Player.Client:OnShutDown()
	BasicActor.ShutDown(self);
--	HUD:Destroy(self);
end


function Player:OnEvent( EventId, Params )
end


function Player:OnSave(save)
	BasicActor.OnSave(self, save);

--	local savedTable =self.AI_WeaponAccessoryTable;
--	if(savedTable) then
--		save.AI_WeaponAccessoryTable = {};
--		for acc,on in pairs(savedTable) do
--			save.AI_WeaponAccessoryTable[acc] = on;
--		end
--	end

end


function Player:OnLoad(saved)
	BasicActor.OnLoad(self, saved);
--	HUD:Spawn(self);

--	self.AI.WeaponAccessoryTable = {};
--	local savedTable =saved.AI.WeaponAccessoryTable;
--	if(savedTable) then
--		for acc,on in pairs(savedTable) do
--			self.AI.WeaponAccessoryTable[acc] = on;
--		end
--	end

end

function Player:OnLoadAI(saved)
	self.AI = {};
	if(saved.AI) then
		self.AI = saved.AI;
	end
end

function Player:OnSaveAI(save)
	if(self.AI) then
		save.AI = self.AI;
	end
end

--FIXME
function Player:CanPickItem(item)
	return self:CanChangeItem();
end

function Player:CanChangeItem()
	--if weapon is holstered, its not possible to switch weapons either
	if (self.holsteredItemId) then
		return false;
	end

	return true;
end

function Player:DropItem()
	local item;

	item = self.inventory:GetCurrentItem();
	if (item) then
		item:Drop();
	end
end

function Player:SetFollowMode( )
	AIBehaviour.PlayerIdle:Follow(self);
end


function Player:Goto()

end

function Player:OnEndCommandSound(timerid)
	-- note: self is not the player but the entity which the signal is sent
	if AI then AI.Signal(SIGNALFILTER_SENDER,1,"ON_COMMAND_TOLD",self.id,Player.SignalData) end
end

function Player:OnEndCommandSoundGroup(timerid)
	if AI then AI.Signal(SIGNALFILTER_GROUPONLY,1,"ON_COMMAND_TOLD",self.id,Player.SignalData) end
end

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- FUNCTIONS TO BE REMOVED AFTER CXP GO HERE :)

function Player:IsSquadAlive()
	if not AI then return false end
	local count = AI.GetGroupCount(self.id);
	for i=1,count do
		local mate = AI.GetGroupMember(self.id,i);
		if(mate and mate ~=self and not mate:IsDead()) then
			return true;
		end
	end
	return false
end

function Player:DoFeedbackHit2DSounds(hit)
	GameAudio.JustPlaySignal(self.SoundSignals.FeedbackHit_Flesh);
end

function Player:IsUsable(user)
	return 1;
end

function Player:ShouldIgnoreHit(hit)

	if (hit.type ~= "collision") then
		return false;
	end

	if (hit.shooter and hit.shooter.IsOnVehicle and hit.shooter:IsOnVehicle()) then
		return false;
	end

	if (hit.shooter and hit.shooter.Properties and hit.shooter.Properties.bDamagesPlayerOnCollisionSP == 1) then
 		return false;
	end

	return true;
end


-- // EI Begin
function Player:IsActionable(user)
	return true;
end

function Player:GetActions(user)
	--Log("[ Player ] GetActions");

	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Player:PerformAction(user, action)
	--Log("[ Player ] PerformAction: action="..action);

	return g_gameRules.game:PerformAction(user.id, self.id, action);
end
-- // EI End



CreateActor(Player);
Player:Expose();
