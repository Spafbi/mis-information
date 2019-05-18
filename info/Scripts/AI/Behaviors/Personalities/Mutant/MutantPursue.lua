local Behavior = CreateAIBehavior("MutantPursue", "MutantBase",
{
	Alertness = 1,

	Constructor = function(self, entity)
		self:Log("$9MutantPursue");

		AIBehavior.DEFAULT:ABORT_ALL_ACTIONS(entity, entity);
		entity:CancelSubpipe();

		entity:SelectPipe(0, "MutantDirectPursue")
		self:AnalyzeSituation(entity)
		
		entity.giveUpPursueTimer = Script.SetTimer(entity.melee.giveUpPursueTimer * 1000, function() self:CancelBehavior(entity); end)
	end,

	Destructor = function(self, entity)
		self:Log("$9~MutantPursue");
		entity:SafeKillTimer(entity.targetOutOfSightTimer)
		entity:SafeKillTimer(entity.giveUpPursueTimer)
		--AI.Animation(entity.id, AIANIM_ACTION, "idle")
	end,

	AnalyzeSituation = function(self, entity)
		enemy = AI.GetAttentionTargetOf(entity.id);
		if (enemy) then
			if (entity:CanMeleeEnemy()) then
				entity:CancelPursue()
				AI.SetBehaviorVariable(entity.id, "Attack", true)
				AI.SetBehaviorVariable(entity.id, "Pursue", true)
			end
		end
	end,

	OnDirectPursueComplete = function(self, entity)
		self:Log("$9MutantPursue::OnDirectPursueComplete");
		self:AnalyzeSituation(entity)
		entity:CancelPursue()
	end,

	OnMeleeRangeEnter = function(self, entity)
		self:Log("$9MutantPursue::OnMeleeRangeEnter");
		self:AnalyzeSituation(entity)
	end,

	OnEnemySeen = function(self, entity)
		self:Log("$9MutantPursue::OnEnemySeen");
		entity:SafeKillTimer(entity.targetOutOfSightTimer)
		self:AnalyzeSituation(entity)
	end,

	OnLostSightOfTarget = function(self, entity, sender, data)
		self:Log("$9MutantPursue::OnLostSightOfTarget");
		entity.targetOutOfSightTimer = Script.SetTimer(entity.melee.noTargetSightTimeout * 1000, function() self:CancelBehavior(entity); end)
	end,
	
	OnNoPathFound = function(self, entity)
		self:Log("$9MutantPursue::OnNoPathFound");
	end,

	CancelBehavior = function(self, entity, sender, data)
		self:Log("$9MutantPursue::CancelBehavior");
		entity:CancelPursue()
	end,
})