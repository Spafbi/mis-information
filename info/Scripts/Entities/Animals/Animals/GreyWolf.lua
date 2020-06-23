GreyWolf = {
	ActionController = "Animations/Mannequin/ADB/greywolfControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/greywolf.adb",
	SoundDatabase = "Animations/Mannequin/ADB/greywolfSounds.adb",
	UseMannequinAGState = true,

	esFaction = "Predators", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "GreyWolf", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function GreyWolf:OnInit()
	self:OnReset();
end

function GreyWolf:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function GreyWolf:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function GreyWolf:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function GreyWolf:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function GreyWolf.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function GreyWolf:IsDead()
	return Animals.IsDead(self);
end
