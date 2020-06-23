BruteMutant = {
	ActionController = "Animations/Mannequin/ADB/brute_mutantControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/brute_mutant.adb",
	SoundDatabase = "Animations/Mannequin/ADB/brute_mutantSounds.adb",
	UseMannequinAGState = true,

	esFaction = "Mutants", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Brute", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function BruteMutant:OnInit()
	self:OnReset();
end

function BruteMutant:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function BruteMutant:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function BruteMutant:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function BruteMutant:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function BruteMutant.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function BruteMutant:IsDead()
	return Animals.IsDead(self);
end
