ScriptDice = {
    type = "ScriptDice",
    Properties={
	    fileModel = "Objects/props/dice/dice.cgf",
		bPickable = 1,
		eiPhysicsType = 2, -- not physicalized by default
		bMounted = 0,
		bUsable = 0,
		bSpecialSelect = 0,
		soclasses_SmartObjectClass = "",
		initialSetup = "",
	},
	
	Client = {},
	Server = {},
	
	Editor={
		Icon = "Item.bmp",
		IconOnTop=1,
    },
}

function ScriptDice:Expose()
    Net.Expose {
        Class = self,
        ClientMethods = {
        },
        ServerMethods = {
            AddImpulseToScriptDice = {RELIABLE_ORDERED, POST_ATTACH}
        },
        ServerProperties = {
		}
    };
end

local Physics_DX9MP_Simple = {
    bPhysicalize = 1, -- True if object should be physicalized at all.
    bPushableByPlayers = 0,

    Density = -1,
    Mass = -1,
    bStaticInDX9Multiplayer = 1
}

function ScriptDice.Server:AddImpulseToScriptDice()
    local randomX = random(8, 12) / 10;
    local randomY = random(11, 16) / 10;
    local randomZ = random(13, 18) / 10;
    self:AddImpulse(0, {x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 5}, 7.0, 1.0, {x = randomX, y = randomY, z = randomZ}, 0.5, 0.5);
end

function ScriptDice:OnPropertyChange()
    self:OnReset();
end

function ScriptDice:OnEditorSetGameMode(gameMode)

end

function ScriptDice:OnReset()

end

function ScriptDice:PhysicalizeThis(slot)
    if (self.Properties.Physics.MP.bDontSyncPos == 1) then
        CryAction.DontSyncPhysics(self.id);
    end

    local physics = self.Properties.Physics;
    if (CryAction.IsImmersivenessEnabled() == 0) then
        physics = Physics_DX9MP_Simple;
    end
    EntityCommon.PhysicalizeRigid(self, slot, physics, 1);

    if (physics.Buoyancy) then
        self:SetPhysicParams(PHYSICPARAM_BUOYANCY, physics.Buoyancy);
    end
end

function ScriptDice.Server:OnHit(hit)

end

function ScriptDice.Client:OnHit(hit, remote)

end

-- EI Begin

function ScriptDice:IsActionable(user)
    if (self.item:CanPickUp(user.id) or self.item:CanUse(user.id) or self.item:IsActionable(user.id)) then
		return 1;
	else
		return 0;
	end
end

function ScriptDice:GetActions(user)
    local actions = {};
    actions = self.item:GetActions(user.id, actions);
    table.insert(actions, "Roll dice");

    return actions;
end

function ScriptDice:PerformAction(user, action)
    if (action == "Roll dice") then
        self.server:AddImpulseToScriptDice();
    else
        return self.item:PerformAction(user.id, action);
    end
end

-- EI End

----------------------------------------------------------------------------------------------------
function ScriptDice.Server:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
end

----------------------------------------------------------------------------------------------------
function ScriptDice.Client:OnInit()
    if (not self.bInitialized) then
        self:OnReset();
        self.bInitialized = 1;
    end
    self:CacheResources();
end

function ScriptDice:GetMaxHealth()
    return self.Properties.fHealth;
end

AddInteractLargeObjectProperty(ScriptDice);
ScriptDice:Expose();

local function CreateScriptDiceTable()
    _G['ScriptDice'] = new(ScriptDice);
    Log('Added dice to the dable');
end

CreateScriptDiceTable();