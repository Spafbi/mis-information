HumanZombie = {
	ActionController = "Animations/Mannequin/ADB/humanzombieControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/humanzombie.adb",
	SoundDatabase = "Animations/Mannequin/ADB/humanzombieSounds.adb",
	UseMannequinAGState = true,

	esFaction = "Mutants",
	esKytheraProfile = "HumanZombie",

	Client = {},
	Server = {},
}

function HumanZombie:OnInit()
	self:OnReset();
end

function HumanZombie:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function HumanZombie:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function HumanZombie:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function HumanZombie:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function HumanZombie.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function HumanZombie:IsDead()
	return Animals.IsDead(self);
end