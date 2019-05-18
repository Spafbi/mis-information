Openable = 
{
	Server = {},
	Client = {},

	Properties = 
	{
		soclasses_SmartObjectClass = "Openable",

		object_Model = "Objects/props/fridge/fridge.cga",
		
		Sounds = 
		{
			snd_Open = "",
			snd_Close = "",
		},
		Animation = 
		{
			anim_Open="open",
			anim_Close="close",
		},
		
		Physics = {
			bPhysicalize = 1, -- True if object should be physicalized at all.
			bRigidBody = 1, -- True if rigid body, False if static.
			bPushableByPlayers = 0,
			Density = -1,
			Mass = -1,
		},

		fUseDistance = 2.5,
		bNoFriendlyFire = 0,
  },
  	

	Editor=
	{
		Icon="Door.bmp",
		ShowBounds = 1,
	},
	
	nDirection = -1, -- -1 closed, 0 nothing, 1=open
	bUseSameAnim = 0,
	bNoAnims = 0,
	nSoundId = 0,

	bActionsChanged = 0,
}

-------------------------------------------------------
function Openable:OnLoad(table)
	-- start from default pose
	self:ResetAnimation(0, -1);
	self:DoStopSound();
	self.curAnim = "";
	self.nDirection = 0;
	self.bActionsChanged = 0;
	if AI then
		AI.SetSmartObjectState( self.id, "Closed" );
	end

	local newDirection = table.nDirection;
	
	if (table.doPlay == 1) then
		self:DoPlayAnimation(newDirection, table.animTime);
	else
		-- need to set set according to newDirection
		if (newDirection == 1) then
			-- only need to set open state
			-- play last frame of opening animation
			local wantedTime = self:GetAnimationLength(0, self.Properties.Animation.anim_Open);
			self:DoPlayAnimation(newDirection, wantedTime, false);
			self.curAnim = "";
			if AI then
				AI.ModifySmartObjectStates( self.id, "Open-Closed" );
			end
		end
	end
end

-------------------------------------------------------
function Openable:OnSave(table)

	if (self.curAnim ~= "" and self.nDirection ~= 0 and self:IsAnimationRunning(0,0)) then
		table.doPlay = 1;
		table.nDirection = self.nDirection;
		table.animTime = self:GetAnimationTime(0,0);
	else
		-- no need to play, but need to re-set set on load
		table.doPlay = 0;
		table.nDirection = self.nDirection;
	end
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function Openable:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function Openable:OnReset()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------
function Openable:OnSpawn()
	self:Reset();
end

function Openable:Reset()
	self.bUseSameAnim = self.Properties.Animation.anim_Close == "";
	if (self.Properties.object_Model ~= "") then
		self:LoadObject(0,self.Properties.object_Model);
	end

	self.bNoAnims = self.Properties.Animation.anim_Open == "" and self.Properties.Animation.anim_Close == "";
	
	self:PhysicalizeThis();
	self:DoStopSound();
	
	-- state setting, closed
	self.nDirection = -1;
	self.curAnim = "";
	self.bActionsChanged = 0;

	if AI then
		AI.SetSmartObjectState( self.id, "Closed" );
	end
end

function Openable:PhysicalizeThis()
	local Physics = self.Properties.Physics;
	EntityCommon.PhysicalizeRigid( self, 0, Physics, 1 );
end

function Openable:IsActionable(user)
	if (not user) then
		return 0;
	end

 	local useDistance = self.Properties.fUseDistance;
	if (useDistance <= 0.0) then
		return 0;
	end
	 
	local delta = g_Vectors.temp_v1;
	local mypos,bbmax = self:GetWorldBBox();
		
	FastSumVectors(mypos,mypos,bbmax);
	ScaleVectorInPlace(mypos,0.5);
	user:GetWorldPos(delta);
			
	SubVectors(delta,delta,mypos);
	
	local useDistance = self.Properties.fUseDistance;
	if (LengthSqVector(delta)<useDistance*useDistance) then
		return 1;
	else
		return 0;
	end
end

function Openable:DidActionsChange()
	if (bActionsChanged) then
		bActionsChanged = 0;
		return 1;
	end

	return 0;
end

function Openable:GetActions(user)
	--Log("[ Openable ] GetActions");

	local i = 1;

	local actions = {};

	local newDir = -self.nDirection;
	if (newDir == 1) then
		actions[i] = "@open"; i=i+1;
	else
		actions[i] = "@close"; i=i+1;
	end

	return actions;
end

function Openable:PerformAction(user, action)
	--Log("[ Openable ] PerformAction: action="..action);

	if (self.nDirection == 0) then
		return;
	end

	local newDir = -self.nDirection;

	if (action == "@open" and self.nDirection == -1) then
		self:Event_Open();
	elseif (action == "@close" and self.nDirection == 1) then
		self:Event_Close();
	end
end

function Openable:DoPlaySound(sndName)
	self:DoStopSound();
	if (sndName and sndName ~= "") then
		local sndFlags=bor(SOUND_DEFAULT_3D, 0);
		g_Vectors.temp = self:GetDirectionVector(1);
		self.nSoundId=self:PlaySoundEvent(sndName, g_Vectors.v000, g_Vectors.temp, sndFlags, 0, SOUND_SEMANTIC_MECHANIC_ENTITY);
	end
end;

function Openable:DoStopSound()
	if(self.nSoundId ~= 0 and Sound.IsPlaying(self.nSoundId)) then
		self:StopSound(self.nSoundId);
	end
	self.nSoundId = 0;
end

function Openable:DoPlayAnimation(direction, forceTime, useSound)
	if (self.nDirection == direction) then
	  return
	end
	
	-- stop animation
	local curTime = 0;
	
	local len = 0;
	local bNeedAnimStart = 1;
	if (self.curAnim~="" and self:IsAnimationRunning(0,0)) then
		curTime = self:GetAnimationTime(0,0);
		len = self:GetAnimationLength(0, self.curAnim);	
		bNeedAnimStart = not self.bUseSameAnim;
	end
	
	if (bNeedAnimStart) then
		local animDirection = direction;
		local animName = self.Properties.Animation.anim_Open;
		if (direction == -1 and not self.bUseSameAnim) then
			animName = self.Properties.Animation.anim_Close;
			animDirection = -animDirection;
		end
		
		if (not self.bNoAnims) then
			self:StopAnimation(0,0);
			self:StartAnimation(0, animName);
			self:SetAnimationSpeed( 0, 0, animDirection );
		
			if (forceTime) then
				self:SetAnimationTime(0,0,forceTime);
			else
				-- now we have to match the times
				local percentage = 0.0;
				if (len > 0.0) then
					percentage = 1.0 - curTime / len;
					if (percentage > 1.0) then
					  percentage = 1.0;
					end
				end
				if (animDirection == -1) then
					percentage = 1.0 - percentage;
				end
				curTime = self:GetAnimationLength(0, animName) * percentage;
				self:SetAnimationTime(0,0,curTime);
			end
			
			local animTime = self:GetAnimationLength(0, animName)-self:GetAnimationTime(0, 0);
			Script.SetTimerForFunction(animTime*1000, "Openable.OnAnimationDoneTimer", self);
		end
		self.curAnim = animName;
	else
	  self:SetAnimationSpeed(0,0, direction);
	end

	self.nDirection = direction;
	self:ForceCharacterUpdate(0, true);
	
	local sndName = self.Properties.Sounds.snd_Open;
	if (direction == -1) then
	  sndName = self.Properties.Sounds.snd_Close;
	end
	
	if (useSound == nil or useSound) then
		self:DoPlaySound(sndName);
	end
end

function Openable:OnAnimationDoneTimer(timerID)	
	if (self.bNoAnims ~= 0 or (self.curAnim ~= "" and self.nDirection ~= 0)) then
		self.curAnim = "";
		if (self.nDirection == -1) then
			-- fully closed
			if AI then
				AI.ModifySmartObjectStates( self.id, "Closed-Open" );
			end
			bActionsChanged = 1;
			BroadcastEvent(self, "Close");
		else
			-- fully open
			if AI then
				AI.ModifySmartObjectStates( self.id, "Open-Closed" );
			end
			bActionsChanged = 1;
			BroadcastEvent(self, "Open");
		end
	 end
end

function Openable:Event_Open(sender)
	if (sender == self) then return; end

	self:DoPlayAnimation(1);
end

function Openable:Event_Close(sender)
	if (sender == self) then return; end

	self:DoPlayAnimation(-1);
end

Openable.FlowEvents =
{
	Inputs =
	{
		Close = { Openable.Event_Close, "bool" },
		Open = { Openable.Event_Open, "bool" },
	},
	Outputs =
	{
		Close = "bool",
		Open = "bool",
	},
}
