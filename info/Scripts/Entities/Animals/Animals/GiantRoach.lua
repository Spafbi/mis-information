GiantRoach = {
	ActionController = "Animations/Mannequin/ADB/giant_roachControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/giant_roach.adb",
	UseMannequinAGState = true,

	esFaction = "Predators", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "GiantRoach", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function GiantRoach:OnInit()
	self:OnReset();
end

function GiantRoach:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function GiantRoach:OnReset()
end

function GiantRoach:IsActionable(user)
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function GiantRoach:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function GiantRoach:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function GiantRoach.Server:OnHit(hit)
	return Animals.OnHit(self, hit);
end

function GiantRoach:IsDead()
	return Animals.IsDead(self);
end