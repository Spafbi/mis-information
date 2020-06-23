--------------------------------------------------------------------------
--	Miscreated Source File.
-- 	Copyright (C), Entrada Interactive, 2013
--------------------------------------------------------------------------
--	$Id$
--	$DateTime$
--	Description: Network-ready Continuous Proximity Trigger
--    Continually fires an event when someone is within its proximity
--
--------------------------------------------------------------------------
--  History:
--
--------------------------------------------------------------------------

RadiationProximityTrigger =
{
	Properties =
	{
		DimX = 5,
		DimY = 5,
		DimZ = 5,

		bEnabled = 1,
		EnterDelay = 1,
		ExitDelay = 0,
		--InsideFrequency = 2, --[2,2,1,"Frequency damage is applied (locked to 2)"]

		bOnlyPlayer = 1,
		bOnlyMyPlayer = 0,
		bOnlyAI = 0,
		bOnlySpecialAI = 0,

		--nRadiation = 1, --[1,1,1,"Radiation damage applied (locked to 1)"]

		ScriptCommand = "",
	},

	Client={},
	Server={},

	Editor={
		Model="Editor/Objects/T.cgf",
		Icon="Trigger.bmp",
		ShowBounds = 1,
		IsScalable = false;
		IsRotatable = false;
	},
}


Net.Expose{
	Class = RadiationProximityTrigger,
	ClientMethods = {
		ClEnter		= { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, INT8},
		ClInside	= { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, INT8},
		ClLeave		= { RELIABLE_ORDERED, PRE_ATTACH, ENTITYID, INT8},
	},
	ServerMethods = {
	},
	ServerProperties = {
	}
}


function RadiationProximityTrigger:OnPropertyChange()
	self:OnReset();
end


function RadiationProximityTrigger:OnReset()

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

	self.triggeredPP={};

	self.triggered=nil;

	self.insideCount=0;

	local min = { x=-self.Properties.DimX/2, y=-self.Properties.DimY/2, z=-self.Properties.DimZ/2 };
	local max = { x=self.Properties.DimX/2, y=self.Properties.DimY/2, z=self.Properties.DimZ/2 };

	self:SetUpdatePolicy( ENTITY_UPDATE_PHYSICS );

	self:SetTriggerBBox( min, max );

	self:Enable(tonumber(self.Properties.bEnabled)~=0);

	self:InvalidateTrigger();

	self:ActivateOutput("IsInside", 0);
end


function RadiationProximityTrigger:Enable(enable)
	self.enabled=enable;
	self:RegisterForAreaEvents(enable and 1 or 0);
end


function RadiationProximityTrigger:OnSpawn()
	self:OnReset();
end


function RadiationProximityTrigger:OnDestroy()
end


function RadiationProximityTrigger:OnSave(tbl)
	tbl.enabled = self.enabled;
	tbl.triggered =	self.triggered;
end


function RadiationProximityTrigger:OnLoad(tbl)
	self:OnReset();
	self.enabled = tbl.enabled;
	self.triggered = tbl.triggered;
end


function RadiationProximityTrigger:Event_Enter(entityId)
	self.inside[entityId] = true;
	self.insideCount = self.insideCount + 1;

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


function RadiationProximityTrigger.Client:ClEnter(entityId, insideCount)
	self:Trigger(entityId, insideCount);

	self:ActivateOutput("Enter", entityId);
end


function RadiationProximityTrigger:Event_Inside(entityId)
	if (not self.enabled) then return; end;

	self:InsideTrigger(entityId, self.insideCount);

	self:ActivateOutput("Inside", entityId or NULL_ENTITY);

	if (self.isServer) then
		-- following doesn't work in mp - says parameter 2 is not a number
		--self.otherClients:ClInside(g_localChannelId, entityId or NULL_ENTITY, self.insideCount);
	end
end


function RadiationProximityTrigger.Client:ClInside(entityId, insideCount)
	self:InsideTrigger(entityId, insideCount);

	self:ActivateOutput("Inside", entityId);
end


function RadiationProximityTrigger:Event_Leave(entityId)
	self.inside[entityId] = nil;
	--self.insideCount = self.insideCount - 1;

	if (not self.enabled) then return; end;
	if (not self.triggered) then return; end;

	if (entityId) then
		if (not self.triggeredPP[entityId]) then
			return;
		end;
	end

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


function RadiationProximityTrigger.Client:ClLeave(entityId, inside)
	self:ActivateOutput("Sender", entityId);
	self:ActivateOutput("IsInside", inside);

	self:ActivateOutput("Leave", entityId);
end


function RadiationProximityTrigger:Event_Enable()
	self:Enable(true);

	local entityIdInside = next(self.inside);

	if (entityIdInside) then
		self:Event_Enter(entityIdInside);
	end

	self:ActivateOutput("IsInside", self.insideCount);

	BroadcastEvent(self, "Enable");
end


function RadiationProximityTrigger:Event_Disable()
	self:Enable(false);

	BroadcastEvent(self, "Disable");
end


function RadiationProximityTrigger:CreateTimer(entityId, time, inside, leave)
	local timerId = self.timerId; -- last timerId used for all timers

	if (timerId > 1023) then  -- wraparound
		timerId = 0;
	end

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


function RadiationProximityTrigger.Client:OnTimer(timerId, msec)
	if (not self.isServer) then
		self:OnTimer(timerId, msec);
	end
end


function RadiationProximityTrigger.Server:OnTimer(timerId, msec)
	self:OnTimer(timerId, msec);
end


function RadiationProximityTrigger:OnTimer(timerId, msec)
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
	-- if (timerId == 2048) then
		-- self:CheckAIDeaths()
		-- return;
	-- end

	-- --Log("OnTimer: %d", timerId);

	-- local entityId = self.timers[timerId];

	-- if (not entityId) then return; end;

	-- if (timerId > 1023) then
		-- --Log("Event_Leave");
		-- self:Event_Leave(entityId);
	-- else
		-- if (self.inside[entityId]) then
			-- --Log("Event_Inside");
			-- self:Event_Inside(entityId);
		-- else
			-- --Log("Event_Enter");
			-- self:Event_Enter(entityId);
		-- end
	-- end
end


function RadiationProximityTrigger:CheckAIDeaths()
	local amountInside = 0;

	for k,v in pairs(self.inside) do
		local entity = System.GetEntity( k );
		if (entity ~= nil and entity.ai ~= nil and entity.lastHealth <= 0) then
			self.inside[k] = nil;
		else
			amountInside = amountInside + 1;
		end
	end

	if (amountInside ~= self.insideCount) then
		self.insideCount = amountInside;
		self:ActivateOutput("IsInside", self.insideCount);
	end

	if (amountInside~=0) then
		self:CreateAIDeathsCheckTrigger();
	else
		self.timers[2048] = false; --to know that we are not using the AI trigger now
	end
end


-- this timer should be created only when it is a trigger that reacts to AI (which should be only a few), and there are AIs inside
function RadiationProximityTrigger:CreateAIDeathsCheckTrigger()
	self.timers[2048] = true; -- to know that we are using the AI timer. 2048 is the AI timer id
	self:SetTimer(2048, 3000);
end


function RadiationProximityTrigger:Trigger(entityId, inside)

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


function RadiationProximityTrigger:InsideTrigger(entityId, inside)

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


function RadiationProximityTrigger:EnteredArea(entity, areaId)
	if (not self:CanTrigger(entity, areaId)) then
		return;
	end

	self.inside[entity.id]=true;
	self.insideCount=self.insideCount+1;
	self:CreateTimer(entity.id, self.Properties.EnterDelay * 1000);

	if (entity.ai and self.timers[2048] ~= true) then  -- 2048 is the special timer id used to check the deaths of AIs
		self:CreateAIDeathsCheckTrigger();
	end
end


function RadiationProximityTrigger:LeftArea(entity, areaId)
	if (not self:CanTrigger(entity, areaId)) then
		return;
	end

	if (self.Properties.ExitDelay == 0) then
		self.Properties.ExitDelay = 0.01;
	end

	self.inside[entity.id]=nil;
	self.insideCount=self.insideCount-1;
	self:CreateTimer(entity.id, self.Properties.ExitDelay * 1000, false, true);
end


function RadiationProximityTrigger.Server:OnEnterArea(entity, areaId)
	if (self:CanTrigger(entity)) then
		self:EnteredArea(entity, areaId);
	end
end


function RadiationProximityTrigger.Server:OnLeaveArea(entity, areaId)
	self:LeftArea(entity, areaId);
end


function RadiationProximityTrigger.Client:OnEnterArea(entity, areaId)
	if (not self:CanTrigger(entity)) then return; end;

	if (self.isServer) then return; end;

	self:EnteredArea(entity, areaId);
end


function RadiationProximityTrigger.Client:OnLeaveArea(entity, areaId)
	if (self.isServer) then return; end;

	self:LeftArea(entity, areaId);
end


function RadiationProximityTrigger:CanTrigger(entity)
	local Properties = self.Properties;

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


RadiationProximityTrigger.FlowEvents =
{
	Inputs =
	{
		Disable = { ProximityTrigger.Event_Disable, "bool" },
		Enable = { ProximityTrigger.Event_Enable, "bool" },
		Enter = { ProximityTrigger.Event_Enter, "bool" },
		Inside = { ProximityTrigger.Event_Inside, "bool" },
		Leave = { ProximityTrigger.Event_Leave, "bool" },
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