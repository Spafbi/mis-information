local Behavior = CreateAIBehavior("MutantSeek", "MutantBase",
{	
	Alertness = 1,

	Constructor = function(self, entity)
		self:Log("$9MutantSeek");

		self:AnalyzeSituation(entity)
	end,

	Destructor = function(self, entity)
		entity:SafeKillTimer(entity.searchTimer);
	end,

	AnalyzeSituation = function(self, entity)
		self:Log("$9~MutantSeek");
		AI.SetFireMode(entity.id, FIREMODE_OFF);

		local point = g_Vectors.temp_v1;
		local goalPipe = "SearchRunToReferencePoint";

		pointOk = AI.GetTacticalPoints(entity.id, "Mutant_SearchQuery", point) ~= false;

		if (pointOk) then		
			AI.SetRefPointPosition(entity.id, point);
			entity:SelectPipe(0, goalPipe);
		else
			entity:OnError("Could not find reference point!");
		end
	end,
	
	OnReferencePointReached = function(self, entity)
		self:Log("$9MutantSeek::OnReferencePointReached");
		entity:SelectPipe(0, "SearchLookAround");
		local userData = {self = self, entity = entity}
		entity.searchTimer = Script.SetTimerForFunction(3*1000, "AIBehavior.MutantSeek.OnSearchTimer", userData);
	end,
	
	OnSearchTimer = function(userData)
		--userData.entity:Log("$9MutantSeek::OnSearchTimer");
		userData.entity.searchTimer = nil;
		AI.SetBehaviorVariable(userData.entity.id, "Seek", false)
	end,

	-- ===========================================================================
	-- Event Handlers (override defaults in MutantBase.lua)
	-- ===========================================================================

	-- called when the AI sees a living enemy
	OnEnemySeen = function(self, entity)
		self:Log("$9MutantSeek::OnEnemySeen");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SEEN(entity);
	end,

	-- called when the AI hears a living enemy
	OnEnemyHeard = function(self, entity, distance)
		self:Log("$9MutantSeek::OnEnemyHeard");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance);
	end,

	-- called when AI is damaged
	OnEnemyDamage = function(self, entity, sender)
		self:Log("$9MutantSeek::OnEnemyDamage");
		AIBehavior.DEFAULT:AGGRO_AND_CALL_FOR_HELP(entity);
	end,

	-- called when the AI hears a threatening sound (ie player grenade)
	OnThreateningSoundHeard = function(self, entity, distance)
		self:Log("$9MutantSeek::OnThreateningSoundHeard");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance);
	end,

	-- called when the AI sees something threatening - further distance away?
	OnThreateningSeen = function(self, entity)
		self:Log("$9MutantSeek::OnThreateningSeen");
		AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SEEN(entity);
	end,

	-- called when bullets pass through field of view
	-- called when there are bullet impacts nearby
	OnBulletRain = function(self, entity, sender, data)
		self:Log("9MutantSeek::OnBulletRain");
		if (AI.Hostile(entity.id, data.id)) then
			AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance); 
		end
	end,

	-- called when bullets pass through field of view
	-- called when there are bullet impacts nearby
	OnBulletRain = function(self, entity, sender, data)
		self:Log("9MutantSeek::OnBulletRain");
		if (AI.Hostile(entity.id, data.id)) then
			AIBehavior.DEFAULT:RESPOND_TO_ENEMY_SOUND(entity, 30, distance); 
		end
	end,

	---------------------------------------------------------------------------
	OnCollision = function(self, entity, sender, data)
		self:Log("$9MutantSeek::OnCollision");
	end,

	-- called when AI gets at close distance (entity.damageRadius) to an enemy
	OnCloseContact = function(self, entity, sender, data)
		self:Log("$9MutantSeek::OnCloseContact");
		AIBehavior.DEFAULT:AGGRO_AND_CALL_FOR_HELP(entity);
	end,

	---------------------------------------------------------------------------
	OnFallAndPlay = function(self, entity, data)
		self:Log("$9MutantSeek::OnFallAndPlay");
		entity:SelectPipe(0, "do_nothing");
	end,

	---------------------------------------------------------------------------
	OnStuck = function(self, entity)
		self:Log("$9MutantSeek::OnStuck");
		entity:SelectPipe(0, "mutant_idle");
	end,

	-- called when the AI has requested a path which is not possible
	OnNoPathFound = function(self, entity, sender)
		self:Log("$9MutantSeek::OnNoPathFound");
		entity:CancelSubpipe();
		AI.Signal(SIGNALFILTER_SENDER, 1, "TO_IDLE", entity.id);
	end,

})