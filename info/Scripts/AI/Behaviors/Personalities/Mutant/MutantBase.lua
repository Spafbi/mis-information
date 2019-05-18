-- Default Log Colors
-- $0 - black (default)
-- $1 - white
-- $2 - blue
-- $3 - green
-- $4 - red
-- $5 - cyan
-- $6 - yellow (normal warning color)
-- $7 - pink
-- $8 - orange
-- $9 - gray

local Behavior = CreateAIBehavior("MutantBase",
{
	Log = function(self, fmt, ...)
		System.Log(string.format(fmt, ...));
	end,

	Constructor = function (self, entity)
		self:Log("MutantBase::Constructor");
	end,	
	
	Destructor = function(self, entity)
		self:Log("MutantBase::Destructor");
	end,

	-- functions shared among multiple behaviors

	CheckAlerted = function(self, entity)
		self:Log("MutantBase::CheckAlerted");
		local attPos = g_Vectors.temp_v1;
	
		if (AI.GetTargetType(entity.id) ~= AITARGET_NONE) then
			AI.GetAttentionTargetPosition(entity.id, attPos);
		end

		if (not entity.AI.targetPos) then
			entity.AI.targetPos = {x=0, y=0, z=0};
		end

		CopyVector(entity.AI.targetPos, attPos);  -- (dest, src) - don't ask me why??

		AI.SetRefPointPosition(entity.id, attPos);
	end,

	GoBackToIdlePos = function(self, entity)
		self:Log("MutantBase::GoBackToIdlePos");
		AI.SetRefPointPosition(entity.id, entity.AI.idlePos);
		self:Log("SelectPipe: mutant_go_back_to_idlepos");
		entity:SelectPipe(0, "mutant_go_back_to_idlepos");
	end,

	EnterWanderBehavior = function(self, entity, target)
		self:Log("MutantBase::EnterWanderBehavior");

		self:CheckAlerted(entity);

		AI.SetBehaviorVariable(entity.id, "IdleWander", true);
		AI.SetBehaviorVariable(entity.id, "Alert", false);
	end,

	EnterSeekBehavior = function(self, entity, target)
		self:Log("MutantBase::EnterSeekBehavior");

		self:CheckAlerted(entity);

		AI.SetBehaviorVariable(entity.id, "Seek", true);
		AI.SetBehaviorVariable(entity.id, "Alert", true);
	end,

	ForceLookAtTarget = function(self, entity)
		self:Log("MutantBase::ForceLookAtTarget");
		local targetPos = {x=0, y=0, z=0};
		local lookAtPos = {x=0, y=0, z=0};
		AI.GetAttentionTargetPosition(entity.id, targetPos);
		SubVectors(lookAtPos, targetPos, entity:GetPos());
		lookAtPos.z = 0;
		NormalizeVector(lookAtPos);
		entity:SetDirectionVector(lookAtPos);
	end,

	ForceLookAtEntity = function(self, entity, target)
		self:Log("MutantBase::ForceLookAtEntity");
		local targetPos = target:GetPos();
		local lookAtPos = {x=0, y=0, z=0};
		SubVectors(lookAtPos, targetPos, entity:GetPos());
		lookAtPos.z = 0;
		NormalizeVector(lookAtPos);
		entity:SetDirectionVector(lookAtPos);
	end,

	-- Should we switch to the collided with entity instead of the
	-- current target as it's probably closer?
	OnCollision = function(self, entity, sender, data)
		self:Log("MutantBase::OnCollision");	
		
		if (false) then
		if (AI.GetTargetType(entity.id) ~= AITARGET_ENEMY) then
			if (AI.Hostile(entity.id, data.id)) then
				if (AI.GetTargetType(entity.id) == AITARGET_NONE) then -- this handles the case if the player just barely touches the ai
					self:Log("MutantBase::OnCollision0a");
					local bumper = System.GetEntity(data.id); -- we don't have an attention target, so force the looking direction
					if (bumper) then
						AI.SetRefPointPosition(entity.id, bumper:GetPos());
						AI.SetBehaviorVariable(entity.id, "Seek", true);
						AI.SetBehaviorVariable(entity.id, "Alert", true);
					end
				elseif (AI.GetAttentionTargetEntity(entity.id) == nil) then -- ai has attention target?
					local bumper = System.GetEntity(data.id);
					self:EnterSeekBehavior(bumper, 0);
				else
					self:Log("MutantBase::OnCollision0b");
					AI.SetBehaviorVariable(entity.id, "Seek", true);
					AI.SetBehaviorVariable(entity.id, "Alert", true);
				end
			else
				self:Log("MutantBase::OnCollision1");	
			end
		else
			self:Log("MutantBase::OnCollision2");	
		end
		end
	end,


	-- template functions

	-- called when the AI has requested a path and it's been computed succesfully
	OnPathFound = function(self, entity, sender)
		self:Log("$9MutantBase::OnPathFound");
	end,

	-- called when the AI has requested a path and the end of path is far from the desired destination
	OnEndPathOffset = function(self, entity, sender)
		self:Log("$9MutantBase::OnEndPathOffset");
	end,

	-- called when the AI has requested a path which is not possible
	OnNoPathFound = function(self, entity, sender)
		self:Log("$9MutantBase::OnNoPathFound");
	end,

	OnFriendInWay = function(self, entity, sender)
		self:Log("$9MutantBase::OnFriendInWay");
	end,

	-- called when the attention target died
	OnTargetDead = function(self, entity)
		self:Log("$9MutantBase::OnTargetDead");
	end,

	-- called when the enemy can no longer see its foe, but remembers where it saw it last
	OnEnemyMemory = function(self, entity)
		self:Log("$9MutantBase::OnEnemyMemory");
	end,

	-- called when AI is damaged
	-- called when AI is damaged by an enemy AI
	OnEnemyDamage = function(self, entity, sender, data)
		self:Log("$9MutantBase::OnEnemyDamage");	
		-- data.id = damaging enemy's entity id
	end,

	OnNewAttentionTarget = function(self, entity, distance)
		self:Log("$9MutantBase::OnNewAttentionTarget");
	end,

	-- called when the AI hears a living enemy
	OnEnemyHeard = function(self, entity, distance)
		self:Log("$9MutantBase::OnEnemyHeard");
	end,

	-- called when AI gets at close distance (entity.damageRadius) to an enemy
	OnCloseContact = function(self, entity)
		self:Log("$9MutantBase::OnCloseContact");
	end,

	-- called when the AI sees a living enemy
	OnEnemySeen = function(self, entity)
		self:Log("$9MutantBase::OnEnemySeen");
	end,

	-- called when the AI hears a threatening sound (ie player grenade)
	OnThreateningSoundHeard = function(self, entity)
		self:Log("$9MutantBase::OnThreateningSoundHeard");
	end,

	-- called when the AI hears an interesting sound (ie footsteps)
	OnInterestingSoundHeard = function(self, entity)
		self:Log("$9MutantBase::OnInterestingSoundHeard");
	end,

	-- called when the AI sees an object registered for this kind of signal
	OnObjectSeen = function(self, entity, fDistance, signalData)
		self:Log("$9MutantBase::OnObjectSeen");
		-- data.iValue = target AIObject type
		-- data.id = target.id
		-- data.point = target position
		-- data.point2 = target velocity
	end,

	-- called when the enemy sees a foe which is not a living player
	OnSomethingSeen = function(self, entity)
		self:Log("$9MutantBase::OnSomethingSeen");
	end,

	-- called when the enemy hears a scary sound
	OnThreateningSeen = function(self, entity)
		self:Log("$9MutantBase::OnThreateningSeen");		
	end,

	-- called when the AI stops having an attention target
	OnNoTarget = function(self, entity, distance)
		self:Log("$9MutantBase::OnNoTarget");
	end,

	-- called when bullets pass through field of view
	-- called when there are bullet impacts nearby
	OnBulletRain = function(self, entity, sender, data)	
		self:Log("$9MutantBase::OnBulletRain");
	end,

	------------------------------------------------------------------------------
	OnNoTargetVisible = function(self, entity, sender, data)
		self:Log("$9MutantBase::OnNoTargetVisible");
	end,

	------------------------------------------------------------------------------
	OnNoTargetAwareness = function(self, entity)
		self:Log("$9MutantBase::OnNoTargetAwareness");
	end,

	OnExplosionDanger = function(self,entity,sender,data)
		self:Log("$9MutantBase::OnExplosionDanger");
	end,

	-- called when a member of the group dies
	OnGroupMemberDiedNearest = function ( self, entity, sender,data)
		self:Log("$9MutantBase::OnGroupMemberDiedNearest");
	end,

	OnGroupMemberDied = function(self, entity, sender)
		self:Log("$9MutantBase::OnGroupMemberDied");
	end,

	OnFriendInWay = function(self, entity, sender)
		self:Log("$9MutantBase::OnFriendInWay");
--		local rnd=random(1,4);
--		entity:InsertSubpipe(0,"friend_circle");
	end,

	-- called when a vehicle is going towards the AI
	OnVehicleDanger = function(self, entity, sender, data)
		self:Log("$9MutantBase::OnTargetTooFar");
		-- data.point = vehicle movement direction
		-- data.point2 = AI direction with respect to vehicle
	end,

	------------------------------------------------------------------------------
	OnFriendlyDamage = function ( self, entity, sender,data)
		self:Log("$9MutantBase::OnFriendlyDamage");
	end,

	------------------------------------------------------------------------------
	OnCallReinforcements = function (self, entity, sender, data)
		self:Log("$9MutantBase::OnCallReinforcements");
	end,

	------------------------------------------------------------------------------
	OnExposedToFlashBang = function (self, entity, sender, data)
		self:Log("$9MutantBase::OnExposedToFlashBang");
	end,

	------------------------------------------------------------------------------
	OnExposedToSmoke = function (self, entity)
		self:Log("$9MutantBase::OnExposedToSmoke");
	end,

	------------------------------------------------------------------------------
	OnExposedToExplosion = function(self, entity, data)
		self:Log("$9MutantBase::OnExposedToExplosion");
	end,

	------------------------------------------------------------------------------
	OnCloseCollision = function(self, entity, data)
		self:Log("$9MutantBase::OnCloseCollision");
	end,

	------------------------------------------------------------------------------
	OnFallAndPlay = function(self, entity, data)
		self:Log("$9MutantBase::OnFallAndPlay");
	end,

	------------------------------------------------------------------------------
	OnFallAndPlayWakeUp	= function(self, entity, data)
		self:Log("$9MutantBase::OnFallAndPlayWakeUp");
	end,

	------------------------------------------------------------------------------
	OnSeenByEnemy = function( self, entity )
		self:Log("$9MutantBase::OnSeenByEnemy");
		--AI.PushGoal("animation", 1, AIANIM_ACTION, "ZombieReact_downface");
	end,

	-- called when the enemy is damaged
	OnReceivingDamage = function ( self, entity, sender)
		self:Log("$9MutantBase::OnReceivingDamage");
	end,

	------------------------------------------------------------------------------
	OnDeath = function( self,entity )
		self:Log("$9MutantBase::OnDeath");
	end,

	-- player is looking at the ai since <entity.Properties.awarenessOfPlayer> seconds
	OnPlayerLooking = function(self,entity,sender,data)
		self:Log("$9MutantBase::OnPlayerLooking");
		-- data.fValue = player distance
	end,

	-- player has just stopped looking at the AI
	OnPlayerLookingAway = function(self,entity,sender,data)
		self:Log("$9MutantBase::OnPlayerLookingAway");
	end,

	-- player is staying close to the ai since <entity.Properties.awarenessOfPlayer> seconds
	OnPlayerSticking = function(self,entity,sender,data)
		self:Log("$9MutantBase::OnPlayerSticking");
	end,

	-- player has just stopped staying close to the AI
	OnPlayerGoingAway = function(self,entity,sender,data)
		self:Log("$9MutantBase::OnPlayerGoingAway");
	end,

	-- called after finishing any AI action for which this agent was "the user"
	OnActionDone = function( self, entity, data )
		self:Log("$9MutantBase::OnActionDone");
		-- data.ObjectName is the action name
		-- data.iValue is 0 if action was canceled or 1 if it was finished normally
		-- data.id is the entity id of "the object" of AI action
	end,

	-- called when the attention target is too close for the current weapon range
	OnTargetTooClose = function (self,entity,sender,data)
		self:Log("$9MutantBase::OnTargetTooClose");
	end,

	-- called when the attention target is too close for the current weapon range
	OnTargetTooFar = function (self, entity, sender, data)
		self:Log("$9MutantBase::OnTargetTooFar");
	end,

	-- called when the enemy sees a friendly target
	OnFriendSeen = function(self, entity)
		self:Log("$9MutantBase::OnFriendSeen");
	end,

	-- called when the enemy sees a dead body
	OnDeadBodySeen = function(self, entity)
		self:Log("$9MutantBase::OnDeadBodySeen");
	end,
})