--------------------------------------------------------------------------
--	Miscreated Source File.
-- 	Copyright (C), Entrada Interactive, 2013
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Network-ready Continuous Area Trigger
--    Continually fires an event when someone is within its area
--
--------------------------------------------------------------------------
--  History:
--
--------------------------------------------------------------------------
RadiationAreaTrigger =
{
	Properties =
	{
		bEnabled = 1,
		bOnlyPlayers = 1,
		bOnlyLocalPlayer= 0,
		ScriptCommand = "",
		-- MultiplayerOptions =
		-- {
			-- bNetworked = 0,
			-- bPerPlayer = 0,
		-- },
		EnterDelay = 1,
		ExitDelay = 0,
		InsideFrequency = 2,
		nRadiation = 1,
		
		bOnlyPlayer = 1,
		bOnlyMyPlayer = 0,
		bOnlyAI = 0,
		bOnlySpecialAI = 0,
	},

	Client = {},
	Server = {},

	Editor =
	{
		Model = "Editor/Objects/T.cgf",
		Icon = "AreaTrigger.bmp",
		IsScalable = false;
		IsRotatable = false;
	},
}


Net.Expose
{
	Class = RadiationAreaTrigger,
	ClientMethods = 
	{
		ClEnter 	= { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, INT8 },
		ClInside	= { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, INT8},
		ClLeave 	= { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, INT8 },
	},
	ServerMethods = {},
	ServerProperties = {}
}


function RadiationAreaTrigger:OnPropertyChange()
	self:OnReset();
end


function RadiationAreaTrigger:OnReset()	
	if (self.timers) then
		for i,v in pairs(self.timers) do
			self:KillTimer(i);
		end
	end
	
	self.timerId = 0;
	
	self.enabled = nil;

	self.isServer=CryAction.IsServer();
	self.isClient=CryAction.IsClient();

	self.inside={};
	self.timers={};
	self.insideCount=0;

	self.triggeredPP={};

	self.triggered=nil;
	
	self:Enable(tonumber(self.Properties.bEnabled)~=0);
	self:ActivateOutput("IsInside", 0);
end


function RadiationAreaTrigger:Enable(enable)
	self.enabled=enable;
	self:RegisterForAreaEvents(enable and 1 or 0);
end


function RadiationAreaTrigger:OnSpawn()
	self:OnReset();
end


function RadiationAreaTrigger:OnSave(props)
	props.enabled = self.enabled;
	props.triggered = self.triggered;
end


function RadiationAreaTrigger:OnLoad(props)
	self:OnReset();
	self.enabled = props.enabled;
	self.triggered = props.triggered;
end


function RadiationAreaTrigger:Event_Enter(entityId)	
	if (not self.enabled) then return; end; -- TODO: might need a self.active here

	self.triggered = true;

	if (entityId) then
		self.triggeredPP[entityId] = true;
	end

	self:Trigger(entityId, self.insideCount);

	self:ActivateOutput("Enter", entityId or NULL_ENTITY);

	if (self.isServer) then
		--self.otherClients:ClEnter(g_localChannelId, entityId or NULL_ENTITY, self.insideCount);
	end
end


function RadiationAreaTrigger.Client:ClEnter(entityId, insideCount)
	self.insideCount = insideCount;
	self:Trigger(entityId, insideCount);
	self:ActivateOutput("Enter", entityId);
end


function RadiationAreaTrigger:Event_Inside(entityId)
	if (not self.enabled) then return; end;

	self:InsideTrigger(entityId, self.insideCount);

	self:ActivateOutput("Inside", entityId or NULL_ENTITY);

	if (self.isServer) then
		-- following doesn't work in mp - says parameter 2 is not a number
		--self.otherClients:ClInside(g_localChannelId, entityId or NULL_ENTITY, self.insideCount);
	end
end


function RadiationAreaTrigger.Client:ClInside(entityId, insideCount)
	self:InsideTrigger(entityId, insideCount);
	self:ActivateOutput("Inside", entityId);
end


function RadiationAreaTrigger:Event_Leave(entityId)
	self.inside[entityId] = nil;
	
	if (not self.enabled) then return; end;
	if (not self.triggered) then return; end;

	if (entityId) then
		if (not self.triggeredPP[entityId]) then
			return;
		end;
	end

	--only disable triggered when all players are gone
	if (self.insideCount <= 0) then
		self.triggered = nil;
	end
	
	if (entityId) then
		self.triggeredPP[entityId] = nil;
	end

	self:ActivateOutput("Sender", entityId or NULL_ENTITY);
	self:ActivateOutput("IsInside", self.insideCount);
	self:ActivateOutput("Leave", entityId or NULL_ENTITY);

	if (self.isServer) then
		--self.otherClients:ClLeave(g_localChannelId, entityId or NULL_ENTITY, self.insideCount);
	end
end


function RadiationAreaTrigger.Client:ClLeave(entityId, inside)
	self:ActivateOutput("Sender", entityId);
	self:ActivateOutput("IsInside", inside);
	self:ActivateOutput("Leave", entityId);
end


function RadiationAreaTrigger:Event_Enable()
	self:Enable(true);

	local entityIdInside = next(self.inside);
	
	if (entityIdInside) then
		self:Event_Enter( entityIdInside );
	end;
	
	self:ActivateOutput("IsInside", self.insideCount);
	BroadcastEvent(self, "Enable");
end


function RadiationAreaTrigger:Event_Disable()
	self:Enable(false);
	BroadcastEvent(self, "Disable");
end


function RadiationAreaTrigger:CreateTimer(entityId, time, inside, leave)
	local timerId = self.timerId; -- last timerId used for all timers
	
	if (timerId > 1023) then  -- wraparound
		timerId = 0;
	end

	--Log("CreateTimer - insideCount: %s", tostring(self.insideCount));
	if (not inside and not leave and self.insideCount==0) then
		timerId = timerId + 1;
		self.timerId = timerId;
	end

	if (leave and self.insideCount <= 0) then
		self.timers[timerId] = nil;
		timerId = timerId + 1024; -- bump from inside to exit timer
	end

	self.timers[timerId] = entityId;
	self:SetTimer(timerId, time);
end


function RadiationAreaTrigger.Client:OnTimer(timerId, msec)
	if (not self.isServer) then
		self:OnTimer(timerId, msec);
	end
end


function RadiationAreaTrigger.Server:OnTimer(timerId, msec)
	self:OnTimer(timerId, msec);
end


function RadiationAreaTrigger:OnTimer(timerId, msec)
	for ent,ins in pairs(self.inside) do
		if (timerId > 1023) then
		Log("Event_Leave: %s", tostring(ent));
			self:Event_Leave(ent);
		else
			if (self.inside[ent]) then
				self:Event_Inside(ent);
			else
				self:Event_Enter(ent);
			end
		end
	end
end


function RadiationAreaTrigger:Trigger(entityId, inside)	
	local entity = System.GetEntity(entityId);

	self:ActivateOutput("IsInside", inside);

	if (self.Properties.ScriptCommand and self.Properties.ScriptCommand~="")then
		local f = loadstring(self.Properties.ScriptCommand);
		if (f~=nil) then
			f();
		end
	end

	if (self.isServer) then
		if (entity and entity.actor:IsPlayer()) then
			if (PWM ~= nil) then
				PWM.ApplyRadiationToPlayer(entityId, 1);
			end;
		end;
	end;

	self:CreateTimer(entityId, 2 * 1000, true);

	self:ActivateOutput("Sender", entityId or NULL_ENTITY);

	if(AI ~= nil) then
		self:ActivateOutput("Faction", AI.GetFactionOf(entityId or NULL_ENTITY) or "");
	end
end


function RadiationAreaTrigger:InsideTrigger(entityId, inside)
	local entity = System.GetEntity(entityId);

	self:ActivateOutput("IsInside", inside);

	if (self.Properties.ScriptCommand and self.Properties.ScriptCommand~="")then
		local f = loadstring(self.Properties.ScriptCommand);
		if (f~=nil) then
			f();
		end
	end

	if (self.isServer) then
		if (entity and entity.actor:IsPlayer()) then
			if (PWM ~= nil) then
				PWM.ApplyRadiationToPlayer(entityId, 1);
			end;
		end;
	end;

	self:CreateTimer(entityId, 2 * 1000, true);

	self:ActivateOutput("Sender", entityId or NULL_ENTITY);

	if(AI ~= nil) then
		self:ActivateOutput("Faction", AI.GetFactionOf(entityId or NULL_ENTITY) or "");
	end
end


function RadiationAreaTrigger:EnteredArea(entity, areaId)
	if (not self:CanTrigger(entity.id, areaId)) then
		return;
	end

	self.inside[entity.id]=true;
	self.insideCount=self.insideCount+1;
	self:CreateTimer(entity.id, self.Properties.EnterDelay * 1000);
end


function RadiationAreaTrigger:LeftArea(entity, areaId)

	if (not self:CanTrigger(entity.id, areaId)) then
		return;
	end

	if (self.Properties.ExitDelay == 0) then
		self.Properties.ExitDelay = 0.01;
	end
	
	self.inside[entity.id]=nil;
	self.insideCount=self.insideCount-1;
	self:CreateTimer(entity.id, self.Properties.ExitDelay * 1000, false, true);
	--self:Event_Leave(entity.id);
end


function RadiationAreaTrigger.Server:OnEnterArea(entity, areaId)
	if (self:CanTrigger(entity.id)) then
		self:EnteredArea(entity, areaId);
	end
end


function RadiationAreaTrigger.Server:OnLeaveArea(entity, areaId)
	self:LeftArea(entity, areaId);
end


function RadiationAreaTrigger.Client:OnEnterArea(entity, areaId)
	if (not self:CanTrigger(entity.id)) then return; end;

	if (self.isServer) then return; end;

	self:EnteredArea(entity, areaId);
end


function RadiationAreaTrigger.Client:OnLeaveArea(entity, areaId)
	if (self.isServer) then return; end;

	self:LeftArea(entity, areaId);
end


function RadiationAreaTrigger:CanTrigger(entityId)
	local Properties = self.Properties;
	
	local entity=System.GetEntity(entityId);
	
	if (entity.ai and entity.lastHealth and (entity.lastHealth <= 0)) then
		return false;
	end

	if (Properties.bOnlyPlayer ~= 0 and Game.IsPlayer(entity.id) == false) then
		return false;
	end

	if (Properties.bOnlySpecialAI ~= 0 and entity.ai and entity.Properties.special==0) then
		return false;
	end

	if (Properties.bOnlyAI ~=0 and not entity.ai) then
		return false;
	end

	if (Properties.bOnlyMyPlayer ~= 0 and entity ~= g_localActor) then
		return false;
	end

	return true;
end


RadiationAreaTrigger.FlowEvents =
{
	Inputs =
	{
		Disable = { AreaTrigger.Event_Disable, "bool" },
		Enable = { AreaTrigger.Event_Enable, "bool" },
		Enter = { AreaTrigger.Event_Enter, "bool" },
		Inside = { AreaTrigger.Event_Inside, "bool" },
		Leave = { AreaTrigger.Event_Leave, "bool" },
	},
	Outputs =
	{
		IsInside = "int",
		Disable = "bool",
		Enable = "bool",
		Enter = "entity",
		Inside = "entity",
		Leave = "entity",
		Sender = "entity",
		Faction = "string",
	},
}