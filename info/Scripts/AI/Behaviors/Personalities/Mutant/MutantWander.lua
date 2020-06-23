-- MutantWander
-- For when the AI is in just a random wander state

local Behavior = CreateAIBehavior("MutantWander", "MutantBase",
{
	Alertness = 0,

	---------------------------------------------------------------------------
	Constructor = function(self, entity)
		self:Log("$9MutantWander");

		AIBehavior.DEFAULT:ABORT_ALL_ACTIONS(entity, entity);
		entity:CancelSubpipe();
		self:GetNewDestination(entity);
	end,


	---------------------------------------------------------------------------
	Destructor = function(self, entity)
		entity:CancelSubpipe();
	end,

	---------------------------------------------------------------------------
	-- GetNewDestination
	-- Determine a new destination for the entity to wander to and then call the
	-- ACT_GOTO function to actually wander there
	---------------------------------------------------------------------------

	GetNewDestination = function(self, entity)
		local pos = entity:GetPos();
		pos.x = pos.x + random(-30, 30);
		pos.y = pos.y + random(-30, 30);

		local data = {};
		data.point = pos; -- TargetPoint
		data.fValue = 0; -- EndAccuracy
		data.point2 = {};
		data.point2.x = 0; -- StopDistance
		data.iValue = BODYPOS_RELAXED; -- Stance

		self:ACT_GOTO(entity, entity, data);
	end,

	-- ===========================================================================
	-- Essentially the same as in default.lua
	-- Used for random wander behavior
	-- ===========================================================================

	ACT_GOTO = function(self, entity, sender, data)
		if (data and data.point) then
			AI.SetRefPointPosition(entity.id, data.point);

			-- use dynamically created goal pipe to set approach distance
			g_StringTemp1 = "wander_goto"..data.fValue;
			AI.CreateGoalPipe(g_StringTemp1);
			AI.PushGoal(g_StringTemp1, "run",0, -1.5);
			AI.PushGoal(g_StringTemp1, "locate", 0, "refpoint");
			AI.PushGoal(g_StringTemp1, "+stick", 1, data.point2.x, AI_REQUEST_PARTIAL_PATH + AILASTOPRES_USE, STICK_BREAK + STICK_SHORTCUTNAV, data.fValue);	-- noncontinuous stick
			AI.PushGoal(g_StringTemp1, "+branch", 1, "NO_PATH", IF_LASTOP_FAILED );
			AI.PushGoal(g_StringTemp1, "branch", 1, "END", BRANCH_ALWAYS );
			AI.PushLabel(g_StringTemp1, "NO_PATH" );
			AI.PushGoal(g_StringTemp1, "signal", 1, 1, "CANCEL_CURRENT", 0);
			AI.PushLabel(g_StringTemp1, "END" );
			AI.PushGoal(g_StringTemp1, "signal", 1, 1, "END_ACT_GOTO", 0);
			AI.PushGoal(g_StringTemp1, "timeout", 1, 30.0)

			entity:InsertSubpipe(AIGOALPIPE_SAMEPRIORITY, g_StringTemp1, nil, data.iValue);
		end
	end,

	CANCEL_CURRENT = function(self, entity, data)
		self:Log("$9MutantWander::CANCEL_CURRENT");
		entity:CancelSubpipe();
		AI.Signal(SIGNALFILTER_SENDER, 1, "TO_IDLE", entity.id);
	end,

	END_ACT_GOTO = function(self, entity, data)
		entity:CancelSubpipe();
		AI.Signal(SIGNALFILTER_SENDER, 1, "TO_IDLE", entity.id);
		--self:GetNewDestination(entity);  -- if we want the AI to just always keep walking
	end,

	-- ===========================================================================
	-- Event Handlers (override defaults in MutantBase.lua)
	-- ===========================================================================

	-- called when the AI sees a living enemy
	OnEnemySeen = function(self, entity)
		self:Log("$9MutantWander::OnEnemySeen");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SEEN(entity);
	end,

	-- called when the AI hears a living enemy
	OnEnemyHeard = function(self, entity, distance)
		self:Log("$9MutantWander::OnEnemyHeard");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance);
	end,

	-- called when AI is damaged
	OnEnemyDamage = function(self, entity, sender)
		self:Log("$9MutantWander::OnEnemyDamage");
		AIBehavior.DEFAULT:AGGRO_AND_CALL_FOR_HELP(entity);
	end,

	-- called when the AI hears a threatening sound (ie player grenade)
	OnThreateningSoundHeard = function(self, entity, distance)
		self:Log("$9MutantWander::OnThreateningSoundHeard");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance);
	end,

	-- called when the AI sees something threatening - further distance away?
	OnThreateningSeen = function(self, entity)
		self:Log("$9MutantWaner::OnThreateningSeen");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SEEN(entity);
	end,

	-- called when bullets pass through field of view
	-- called when there are bullet impacts nearby
	OnBulletRain = function(self, entity, sender, data)
		self:Log("9MutantWander::OnBulletRain");
		if (AI.Hostile(entity.id, data.id)) then
			AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance); 
		end
	end,

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
		self:Log("$9MutantWander::OnFallAndPlay");
		entity:SelectPipe(0, "do_nothing");
	end,

	---------------------------------------------------------------------------
	OnStuck = function(self, entity)
		self:Log("$9MutantWander::OnStuck");
		entity:SelectPipe(0, "mutant_idle");
	end,

	-- called when the AI has requested a path which is not possible
	OnNoPathFound = function(self, entity, sender)
		self:Log("$9MutantWander::OnNoPathFound");
		entity:CancelSubpipe();
		AI.Signal(SIGNALFILTER_SENDER, 1, "TO_IDLE", entity.id);
	end,
})