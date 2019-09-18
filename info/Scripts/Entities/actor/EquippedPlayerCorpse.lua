EquippedPlayerCorpse =
{
	type = "EquippedPlayerCorpse",
	
	Properties =
	{
	},
}

function EquippedPlayerCorpse:IsActionable(user)
--	Log("[ EquippedPlayerCorpse ] IsActionable");
	if (g_gameRules.game:IsActionable(user.id, self.id)) then
		return 1;
	else
		return 0;
	end
end

function EquippedPlayerCorpse:GetActions(user)
--	Log("[ EquippedPlayerCorpse ] GetActions");

	local actions = {};
	actions = g_gameRules.game:GetActions(user.id, self.id, actions);
	return actions;
end

function EquippedPlayerCorpse:PerformAction(user, action)
--	Log("[ EquippedPlayerCorpse ] PerformAction: action="..action);

	return g_gameRules.game:PerformAction(user.id, self.id, action);
end


function EquippedPlayerCorpse:AddRandomItems()
	Log("[ EquippedPlayerCorpse ] AddRandomItems");

	local rifle = ISM.GiveItem(self.id, "AT15");
	local accessory = ISM.GiveItem(self.id, "STANAGx30", false, rifle.id, "stanag_mag00");

	ISM.GiveItem(self.id, "DuffelBag");

	ISM.GiveItem(self.id, "TennisShoes");
	ISM.GiveItem(self.id, "BlueJeans");
	ISM.GiveItem(self.id, "TshirtNoImageBlack");

end