Boar = {
	esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Pig", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function Boar:OnInit()
	self:OnReset();
end

function Boar:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Boar:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Boar:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Boar:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Boar.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Boar:IsDead()
	return Animals.IsDead(self);
end