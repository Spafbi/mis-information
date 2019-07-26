Bear = {
	ActionController = "Animations/Mannequin/ADB/bearControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/bear.adb",
	SoundDatabase = "Animations/Mannequin/ADB/bearSounds.adb",
	UseMannequinAGState = true,

	esFaction = "Predators", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Bear", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function Bear:OnInit()
	self:OnReset();
end

function Bear:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Bear:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Bear:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Bear:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Bear.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Bear:IsDead()
	return Animals.IsDead(self);
end
