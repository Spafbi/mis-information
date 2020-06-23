TwoHeadDog = {
	ActionController = "Animations/Mannequin/ADB/twoheaddogControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/twoheaddog.adb",
	SoundDatabase = "Animations/Mannequin/ADB/twoheaddogSounds.adb",
	UseMannequinAGState = true,

	esFaction = "Mutants", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "MutantDog", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function TwoHeadDog:OnInit()
	self:OnReset();
end

function TwoHeadDog:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function TwoHeadDog:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function TwoHeadDog:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function TwoHeadDog:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function TwoHeadDog.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function TwoHeadDog:IsDead()
	return Animals.IsDead(self);
end
