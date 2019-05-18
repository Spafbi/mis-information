--------------------------------------------------------------------------
--	Crytek Source File.
-- 	Copyright (C), Crytek Studios, 2001-2007.
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Elevator Switch Button
--
--------------------------------------------------------------------------
--  History:
--  - 28:1:2007 : Created by Marcio Martins
--
--------------------------------------------------------------------------

ElevatorSwitch =
{
	Server = {},
	Client = {},
	Properties =
	{
		soclasses_SmartObjectClass = "ElevatorSwitch",

		objModel = "objects/default/primitive_cube_tiny.cgf",
		nFloor = 0,
		fDelay = 3,
		UseMessage = "Use Elevator",
		Sounds =
		{
			soundSoundOnPress = "",
		},
		bEnabled = 0,
	},
	Editor =
	{
		Icon = "elevator.bmp",
		IconOnTop = 0,
	},
}


Net.Expose 
{
	Class = ElevatorSwitch,
	ClientMethods = 
	{
		ClUsed = { RELIABLE_UNORDERED, POST_ATTACH, },
	},
	ServerMethods = 
	{
		SvRequestUse = { RELIABLE_UNORDERED, POST_ATTACH, ENTITYID, },
	},
	ServerProperties = {},
};


----------------------------------------------------------------------------------------------------
function ElevatorSwitch:OnPreFreeze(freeze, vapor)
	if (freeze) then
		return false; -- don't allow freezing
	end
end


function ElevatorSwitch:OnPropertyChange()
	self:Reset();
end


function ElevatorSwitch:OnReset()
	self:Reset();
end


function ElevatorSwitch:OnSpawn()
	CryAction.CreateGameObjectForEntity(self.id);
	CryAction.BindGameObjectToNetwork(self.id);
	CryAction.ForceGameObjectUpdate(self.id, true);

	self.isServer=CryAction.IsServer();
	self.isClient=CryAction.IsClient();

	self.user = 0;
	self.tmp = {x=0,y=0,z=0};
	self.tmp_2 = {x=0,y=0,z=0};
	self.tmp_3 = {x=0,y=0,z=0};
	self.initialdir=self:GetDirectionVector(1);

	self:Reset(1);
end


function ElevatorSwitch:OnDestroy()
end


function ElevatorSwitch:DoPhysicalize()
	if (self.currModel ~= self.Properties.objModel) then
		self:LoadObject( 0,self.Properties.objModel );
		self:Physicalize(0,PE_RIGID, {mass=0});
	end

	self.currModel = self.Properties.objModel;
end


function ElevatorSwitch:Reset(onSpawn)
	self:Activate(0);
	self:DoPhysicalize();
	self.enabled = tonumber(self.Properties.bEnabled) ~= 0
end


function ElevatorSwitch:IsUsable(user)
	return false; -- EI - we don't use the usable system
end


function ElevatorSwitch:OnUsed(user)
	self.server:SvRequestUse(user.id);
end


function ElevatorSwitch:GetUsableMessage()
	return self.Properties.UseMessage;
end


function ElevatorSwitch.Server:SvRequestUse(userId)
	if (self.Properties.fDelay>0) then
		self:SetTimer(0, 1000*self.Properties.fDelay);
	else
		self:Used();
	end
end


function ElevatorSwitch.Server:OnTimer(timerId, msec)
	self:Used();
end

-- In Sandbox, name the entity link "up" if you want the switch to send the elevator up or name the link "down" if you want to send the elevator down.
function ElevatorSwitch:Used()

	local i=0;
	local link=self:GetLinkTarget("up", i);
	while (link) do
		link:Up(self.Properties.nFloor);
		i=i+1;
		link=self:GetLinkTarget("up", i);
	end

	i=0;
	link=self:GetLinkTarget("down", i);
	while (link) do
		link:Down(self.Properties.nFloor);
		i=i+1;
		link=self:GetLinkTarget("down", i);
	end

	self:ActivateOutput("Used", true);
	self.allClients:ClUsed();
end


function ElevatorSwitch.Client:ClUsed()
	local sound=self.Properties.Sounds.soundSoundOnPress;
	if (sound and sound~="") then
		-- REINSTANTIATE!!!
		--self:PlaySoundEvent(self.Properties.Sounds.soundSoundOnPress, g_Vectors.v000, g_Vectors.v010, SOUND_DEFAULT_3D, 0, SOUND_SEMANTIC_MECHANIC_ENTITY);
	end
end

-- EI BEGIN

function ElevatorSwitch:IsActionable(user)
	--Log("[ ElevatorSwitch ] IsActionable");
	return self.Properties.bEnabled;
end

function ElevatorSwitch:GetActions(user)
	--Log("[ ElevatorSwitch ] GetActions");

	local i = 1;

	local actions = {};

	if (self.Properties.bEnabled==1) then
		actions[i] = self.Properties.UseMessage; i=i+1;
	end

	return actions;
end

function ElevatorSwitch:PerformAction(user, action)
	--Log("[ ElevatorSwitch ] PerformAction: action="..action);

	if (self:IsActionable(user) ~= 1) then
		return nil;
	end

	self.server:SvRequestUse(user.id);
end

-- EI END

-- Events
function ElevatorSwitch:Event_Enable()
	self.enabled = true;
	self.Properties.bEnabled = 1;
	self:ActivateOutput("Enabled", true);
end

function ElevatorSwitch:Event_Disable()
	self.enabled = false;
	self.Properties.bEnabled = 0;
	self:ActivateOutput("Disabled", true);
end

function ElevatorSwitch:Event_Use()
	self:Used()
end


ElevatorSwitch.FlowEvents =
{
	Inputs =
	{
		Enable = { ElevatorSwitch.Event_Enable, "any" },
		Disable = { ElevatorSwitch.Event_Disable, "any" },
		Use = { ElevatorSwitch.Event_Use, "any" },
	},

	Outputs =
	{
		Enabled = "bool",
		Disabled = "bool",
		Used = "bool",
	},
}