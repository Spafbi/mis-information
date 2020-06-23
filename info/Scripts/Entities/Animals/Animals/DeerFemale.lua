DeerFemale = {
	ActionController = "Animations/Mannequin/ADB/deerControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/deer.adb",
	SoundDatabase = "Animations/Mannequin/ADB/deerSounds.adb",
	UseMannequinAGState = true,

	esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Deer", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function DeerFemale:OnInit()
	self:OnReset();
end

function DeerFemale:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function DeerFemale:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function DeerFemale:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function DeerFemale:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function DeerFemale.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function DeerFemale:IsDead()
	return Animals.IsDead(self);
end