-- MutantIdle
-- For when the AI is in its idle state just waiting for anything to happen

local Behavior = CreateAIBehavior("MutantIdle", "MutantBase",
{
	Alertness = 0,

	Constructor = function (self, entity)
		AIBehavior.DEFAULT:ABORT_ALL_ACTIONS(entity, entity);
		entity:CancelSubpipe();

--		entity.AI.StandbyShape = nil;

--		AI.SetBehaviorVariable(entity.id, "Alert", false);

		-- Remember our original idle location
--		if (not entity.AI.idlePos) then
--			entity.AI.idlePos = {x=0, y=0, z=0};
--			CopyVector(entity.AI.idlePos, entity:GetPos());
--		end

--		entity:MakeIdle();

--		local rndnum = random(10, 120);
		local rndnum = random(1, 5);

		entity.AI.idleTimer = Script.SetTimerForFunction(rndnum * 1000.0, "AIBehavior.MutantIdle.IDLE_TIMER", entity);

		entity:SelectPipe(0, "mutant_idle");
	end,
	
	Destructor = function(self, entity)
		entity:CancelSubpipe();
		if (entity.AI.idleTimer) then
			Script.KillTimer(entity.AI.idleTimer);
			entity.AI.idleTimer = nil;
		end
	end,

	-- ===========================================================================
	-- Timer Handlers
	-- ===========================================================================

	IDLE_TIMER = function(entity, timerid)
		AI.Signal(SIGNALFILTER_SENDER, 1, "TO_WANDER", entity.id);
	end,

	-- ===========================================================================
	-- Event Handlers (override defaults in MutantBase.lua)
	-- ===========================================================================

	-- called when the AI sees a living enemy
	OnEnemySeen = function(self, entity)
		self:Log("$9MutantIdle::OnEnemySeen");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SEEN(entity);
	end,

	-- called when the AI hears a living enemy
	OnEnemyHeard = function(self, entity, distance)
		self:Log("$9MutantIdle::OnEnemyHeard");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance);
--		self:ForceLookAtTarget(entity);
--		self:EnterAlertedBehavior(entity, distance); -- exception, run to spot first
	end,

	-- called when AI is damaged by a hostile enemy
	-- data.id = damaging enemy's entity id
	OnEnemyDamage = function(self, entity, sender)
		self:Log("$9MutantIdle::OnEnemyDamage");
		AIBehavior.DEFAULT:AGGRO_AND_CALL_FOR_HELP(entity);
	end,

	-- called when the AI hears a threatening sound (ie player grenade)
	OnThreateningSoundHeard = function(self, entity, distance)
		self:Log("$9MutantIdle::OnThreateningSoundHeard");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance);
	end,

	-- called when the AI sees something threatening - further distance away?
	OnThreateningSeen = function(self, entity)
		self:Log("$9MutantIdle::OnThreateningSeen");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SEEN(entity);
	end,

	-- called when bullets pass through field of view
	-- called when there are bullet impacts nearby
	OnBulletRain = function(self, entity, sender, data)	
		self:Log("$9MutantIdle::OnBulletRain");
		if (AI.Hostile(entity.id, data.id)) then
			AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance); 
		end
	end,

	-- curiosities
--[[
	EnterAlertedBehavior = function(self, entity, distance)
		self:Log("MutantIdle::EnterAlertedBehavior");
		self:CheckAlerted(entity);
		AI.SetBehaviorVariable(entity.id, "Alerted", true);
	end,

	OnSomethingSeen = function(self, entity, distance, data)
		self:Log("MutantIdle::OnSomethingSeen");
		self:EnterAlertedBehavior(entity, distance);
	end,

	OnObjectSeen = function(self, entity, distance, data)
		self:Log("MutantIdle::OnObjectSeen");
		self:EnterAlertedBehavior(entity, distance);
	end,

	OnInterestingSoundHeard = function(self, entity)
		self:Log("MutantIdle::OnInterestingSoundHeard");
		self:EnterAlertedBehavior(entity, distance);
	end,

	OnNewAttentionTarget = function(self, entity, distance)
		self:Log("MutantIdle::OnNewAttentionTarget");
		self:EnterAlertedBehavior(entity, distance);
	end,
--]]
	---------------------------------------------------------------------------
	OnCollision = function(self, entity, sender, data)
		self:Log("$9MutantWander::OnCollision");
	end,

	-- called when AI gets at close distance (entity.damageRadius) to an enemy
	OnCloseContact = function(self, entity, sender, data)
		self:Log("$9MutantWander::OnCloseContact");
		AIBehavior.DEFAULT:AGGRO_AND_CALL_FOR_HELP(entity);
	end,

	---------------------------------------------------------------------------
	OnFallAndPlay = function(self, entity, data)
		self:Log("$9MutantIdle::OnFallAndPlay");
		entity:SelectPipe(0, "do_nothing");
	end,

	---------------------------------------------------------------------------
	OnStuck = function(self, entity)
		self:Log("$9MutantIdle::OnStuck");
		entity:SelectPipe(0, "mutant_idle");
	end,

})