PlayerCorpse =
{
	type = "PlayerCorpse",
	
	Properties =
	{
	},
}

function PlayerCorpse:IsActionable(user)
--	Log("[ PlayerCorpse ] IsActionable");
	if (g_gameRules.game:IsActionable(user.id, self.id)) then
		return 1;
	else
		return 0;
	end
end

function PlayerCorpse:GetActions(user)
--	Log("[ PlayerCorpse ] GetActions");

	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function PlayerCorpse:PerformAction(user, action)
--	Log("[ PlayerCorpse ] PerformAction: action="..action);

	return g_gameRules.game:PerformAction(user.id, self.id, action);
end