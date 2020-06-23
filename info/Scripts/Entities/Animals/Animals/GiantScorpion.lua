GiantScorpion = {
	ActionController = "Animations/Mannequin/ADB/giant_scorpionControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/giant_scorpion.adb",
	UseMannequinAGState = true,

	esFaction = "Predators", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "GiantScorpion", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function GiantScorpion:OnInit()
	self:OnReset();
end

function GiantScorpion:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function GiantScorpion:OnReset()
end

function GiantScorpion:IsActionable(user)
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function GiantScorpion:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function GiantScorpion:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function GiantScorpion.Server:OnHit(hit)
	return Animals.OnHit(self, hit);
end

function GiantScorpion:IsDead()
	return Animals.IsDead(self);
end