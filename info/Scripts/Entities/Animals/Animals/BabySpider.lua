BabySpider = {
	ActionController = "Animations/Mannequin/ADB/spider_largeControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/spider_large.adb",
	UseMannequinAGState = true,

	esFaction = "Mutants", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "BabySpider", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function BabySpider:OnInit()
	self:OnReset();
end

function BabySpider:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function BabySpider:IsActionable(user)
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function BabySpider:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function BabySpider:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function BabySpider.Server:OnHit(hit)
	return Animals.OnHit(self, hit);
end

function BabySpider:IsDead()
	return Animals.IsDead(self);
end