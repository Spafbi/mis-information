local Behavior = CreateAIBehavior("MutantAttack", "MutantBase",
{
	Alertness = 2,

	Constructor = function(self, entity)
		self:Log("$9MutantAttack");

		-- Make sure we have a weapon equipped - even if it's just the fists
--		local weapon = entity.inventory:GetCurrentItem();
--		if (weapon == nil or weapon.class ~= entity.primaryWeapon) then
--			entity.actor:SelectItemByName(entity.primaryWeapon);
--		end

		--AI.SetContinuousMotion(entity.id, true)

--		entity:SelectPipe(0, "MutantMeleeAttackStart")
--		entity.stopContinuousMotionTimer = Script.SetTimer(1000, function() AI.SetContinuousMotion(entity.id, false) entity.stopContinuousMotionTimer = nil end)

		entity:Melee()
	end,

	Destructor = function(self, entity)
		self:Log("$9~MutantAttack");
		--AI.SetContinuousMotion(entity.id, false)
--		entity:SafeKillTimer(entity.stopContinuousMotionTimer)
	end,

	OnMeleeDone = function(self, entity)
		self:Log("$9MutantAttack::OnMeleeDone");
		if (AI.GetRangeState(entity.id, entity.meleeRangeID) == OutsideRange or AI.GetTargetType(entity.id) ~= AITARGET_ENEMY ) then
			self:LeaveMeleeAttack(entity)
		else
			self:LeaveMeleeAttack(entity)
--			entity:Melee()
		end
	end,

	-- Melee action initiated
	OnMeleeExecuted = function(self, entity)
		self:Log("$9MutantAttack::OnMeleeExecuted");
		AI.Animation(entity.id, AIANIM_ACTION, "meleeAttack");
		entity:SelectPipe(0, "MutantMeleeAttackPerforming")
	end,

	OnMeleeFailed = function(self, entity)
		self:Log("$9MutantAttack::OnMeleeFailed");
		self:LeaveMeleeAttack(entity)
	end,

	OnMeleeWaitDone = function(self, entity)
		self:Log("$9MutantAttack::OnMeleeWaitDone");
		self:LeaveMeleeAttack(entity)
	end,


	LeaveMeleeAttack = function(self, entity)
		self:Log("$9MutantAttack::LeaveMeleeAttack");
		--entity:CancelPursue()
		AI.SetBehaviorVariable(entity.id, "Attack", false)
		AI.Animation(entity.id, AIANIM_ACTION, "idle");
	end,
})
