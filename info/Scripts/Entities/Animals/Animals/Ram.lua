Ram = {
	ActionController = "Animations/Mannequin/ADB/ramControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/ram.adb",
	SoundDatabase = "Animations/Mannequin/ADB/ramSounds.adb",
	UseMannequinAGState = true,

	esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Deer", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function ram:OnInit()
	self:OnReset();
end

function ram:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function ram:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function ram:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function ram:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function ram.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function ram:IsDead()
	return Animals.IsDead(self);
end
