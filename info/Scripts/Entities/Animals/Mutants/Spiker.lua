Spiker = {
	ActionController = "Animations/Mannequin/ADB/spikerControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/spiker.adb",
	SoundDatabase = "Animations/Mannequin/ADB/spikerSounds.adb",
	UseMannequinAGState = true,

	esFaction = "Mutants",
	esKytheraProfile = "Spiker",

	Client = {},
	Server = {},
}

function Spiker:OnInit()
	self:OnReset();
end

function Spiker:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Spiker:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Spiker:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Spiker:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Spiker.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Spiker:IsDead()
	return Animals.IsDead(self);
end
