Pig = {
	esFaction = "WildLife", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "Pig", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function Pig:OnInit()
	self:OnReset();
end

function Pig:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function Pig:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function Pig:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function Pig:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function Pig.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function Pig:IsDead()
	return Animals.IsDead(self);
end