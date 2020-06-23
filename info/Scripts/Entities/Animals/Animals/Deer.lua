Deer = {
	ActionController = "Animations/Mannequin/ADB/deerControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/deer.adb",
	SoundDatabase = "Animations/Mannequin/ADB/deerSounds.adb",
	UseMannequinAGState = true,

	esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Deer", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function Deer:OnInit()
	self:OnReset();
end

function Deer:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Deer:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Deer:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Deer:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Deer.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Deer:IsDead()
	return Animals.IsDead(self);
end
