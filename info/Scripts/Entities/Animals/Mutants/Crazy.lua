Crazy = {
	ActionController = "Animations/Mannequin/ADB/crazyControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/crazy.adb",
	SoundDatabase = "Animations/Mannequin/ADB/crazySounds.adb",
	UseMannequinAGState = true,

	esFaction = "Mutants",
	esKytheraProfile = "Crazy",

	Client = {},
	Server = {},
}

function Crazy:OnInit()
	self:OnReset();
end

function Crazy:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Crazy:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Crazy:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Crazy:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Crazy.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Crazy:IsDead()
	return Animals.IsDead(self);
end