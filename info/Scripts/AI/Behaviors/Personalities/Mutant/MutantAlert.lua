-- MutantAlert
-- For when the AI has been alerted to something and is just going to investigate what it was

local Behavior = CreateAIBehavior("MutantAlert", "MutantBase",
{
	Alertness = 0,

	Constructor = function (self, entity)
		self:Log("MutantAlert");

		-- Search at least 10s.
		entity.AI.allowLeave = false;
		entity.AI.alertTimer = Script.SetTimerForFunction(10 * 1000.0, "AIBehavior.MutantAlert.ALERT_TIMER", entity);

		self:Log("SelectPipe: mutant_alert");
		entity:SelectPipe(0, "mutant_alert");
	end,

	Destructor = function(self, entity)
		self:KillAlertTimer(entity);
	end,

	KillAlertTimer = function(self, entity)
		if (entity.AI.alertTimer) then
			Script.KillTimer(entity.AI.alertTimer);
		end
	end,

	---------------------------------------------
	ALERT_TIMER = function(entity, timerid)
		Log("MutantAlert::ALERT_TIMER");
		entity.AI.alertTimer = nil;
		entity.AI.allowLeave = true;

		local target = AI.GetAttentionTargetEntity(entity.id);
		if (target == nil) then
			AI.Signal(SIGNALFILTER_SENDER, 1, "ALERT_IDLE_LOOKAROUND", entity.id);
		end
	end,

	ALERT_IDLE = function(self, entity)
		self:Log("MutantAlert::ALERT_IDLE");
		self:Log("SelectPipe: mutant_alert_idle"); -- want to look around at least once
		entity:SelectPipe(0, "mutant_alert_idle");
	end,

	ALERT_IDLE_LOOKAROUND = function(self, entity)
		self:Log("MutantAlert::ALERT_IDLE_LOOKAROUND");
		if (entity.AI.allowLeave == true) then
			self:GoBackToIdlePos(entity);
		else
			self:Log("SelectPipe: mutant_alert_idle");
			entity:SelectPipe(0, "mutant_alert_idle");
		end
	end,

	IDLEPOS_REACHED = function(self, entity)
		self:Log("MutantAlert::IDLEPOS_REACHED");
		AI.SetBehaviorVariable(entity.id, "Alerted", false);
	end,

	-- threats (all threats take us to seek mode)

	OnEnemySeen = function(self, entity, fDistance, data)
		self:Log("MutantAlert::OnEnemySeen");
		self:EnterSeekBehavior(entity, distance);
	end,

	OnEnemyDamage = function(self, entity, distance, data)
		self:Log("MutantAlert::OnEnemyDamage");
		local enemy = System.GetEntity(data.id);
		if (enemy) then
			self:ForceLookAtEntity(entity, enemy);
		end
		self:EnterSeekBehavior(entity, distance);
	end,

	OnEnemyHeard = function(self, entity, distance)
		self:Log("MutantAlert::OnEnemyHeard");
		self:ForceLookAtTarget(entity); -- have to force as we're switching behaviors
		self:EnterSeekBehavior(entity, distance);
	end,

	OnBulletRain = function(self, entity, sender, data)
		self:Log("MutantAlert::OnBulletRain");
		if (AI.Hostile(entity.id, data.id)) then -- only react to hostile bullets
			self:EnterSeekBehavior(entity, distance);
		end
	end,

	OnThreateningSeen = function(self, entity)
		self:Log("MutantAlert::OnThreateningSoundHeard");
		self:EnterSeekBehavior(entity, distance);
	end,

	OnThreateningSoundHeard = function(self, entity)
		self:Log("MutantAlert::OnThreateningSoundHeard");
		self:ForceLookAtTarget(entity);
		self:EnterSeekBehavior(entity, distance);
	end,

	-- curiosities

	InvestigatePosition = function(self, entity, distance)
		self:Log("MutantAlert::InvestigatePosition");
		if (entity.AI.allowLeave) then
			local attPos = g_Vectors.temp_v1; -- needs to be initialized like this
			AI.GetAttentionTargetPosition(entity.id, attPos);
			AI.SetRefPointPosition(entity.id, attPos);

			entity.AI.allowLeave = false;
			entity.AI.alertTimer = Script.SetTimerForFunction(10 * 1000.0, "AIBehavior.MutantAlert.ALERT_TIMER", entity);

			self:Log("SelectPipe: mutant_alert");
			entity:SelectPipe(0, "mutant_alert");
		end
	end,

	OnSomethingSeen = function(self, entity, distance, data)
		self:Log("MutantAlert::OnSomethingSeen");
		self:InvestigatePosition(entity, distance);
	end,

	OnObjectSeen = function(self, entity, distance, data)
		self:Log("MutantAlert::OnObjectSeen");
		self:InvestigatePosition(entity, distance);
	end,

	OnInterestingSoundHeard = function(self, entity)
		self:Log("MutantAlert::OnInterestingSoundHeard");
		self:InvestigatePosition(entity, distance);
	end,
})