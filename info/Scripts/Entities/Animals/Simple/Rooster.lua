Rooster = {
	esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Rooster", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function Rooster:OnInit()
	self:OnReset();
end

function Rooster:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Rooster:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Rooster:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Rooster:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Rooster.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Rooster:IsDead()
	return Animals.IsDead(self);
end