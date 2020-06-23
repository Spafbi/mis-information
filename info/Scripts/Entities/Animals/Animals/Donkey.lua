Donkey = {
	ActionController = "Animations/Mannequin/ADB/donkeyControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/donkey.adb",
	UseMannequinAGState = true,

	esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Donkey", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function Donkey:OnInit()
	self:OnReset();
end

function Donkey:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Donkey:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Donkey:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Donkey:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Donkey.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Donkey:IsDead()
	return Animals.IsDead(self);
end
