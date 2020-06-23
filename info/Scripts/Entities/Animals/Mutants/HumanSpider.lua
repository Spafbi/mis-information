HumanSpider = {
	ActionController = "Animations/Mannequin/ADB/human_spiderControllerDefs.xml",
	AnimDatabase3P = "Animations/Mannequin/ADB/human_spider.adb",
	SoundDatabase = "Animations/Mannequin/ADB/human_spiderSounds.adb",
	UseMannequinAGState = true,

	esFaction = "Mutants", -- empty faction will make this animal be ignored as a target by all other AI
	esKytheraProfile = "HumanSpider", -- valid profiles defined in Scripts/Kythera/Profiles.xml

	Client = {},
	Server = {},
}

function HumanSpider:OnInit()
	self:OnReset();
end

function HumanSpider:OnPropertyChange()
	self:OnReset();
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end

function HumanSpider:IsActionable(user)	
	return g_gameRules.game:IsActionable(user.id, self.id);
end

function HumanSpider:GetActions(user)
	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function HumanSpider:PerformAction(user, action)
	return g_gameRules.game:PerformAction(user.id, self.id, action);
end

function HumanSpider.Server:OnHit(hit)
	return Animals.OnHit(self, hit);	
end

function HumanSpider:IsDead()
	return Animals.IsDead(self);
end
