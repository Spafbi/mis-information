Item = {
	Properties={
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


----------------------------------------------------------------------------------------------------
function Item:OnPropertyChange()
	self.item:Reset();
	
	if (self.OnReset) then
		self:OnReset();
	end

end


function Item:OnSave(props)
	if (self.flowUser) then
		props.flowUserID = self.flowUser.id;
    end
end

function Item:OnLoad(props)
	if (props.flowUserID) then
		self.flowUser = System.GetEntity( props.flowUserID );
	end
end


-- EI BEGIN

----------------------------------------------------------------------------------------------------
function Item:IsActionable(user)
--	Log("[ Item ] IsActionable");

	if (self.item:CanPickUp(user.id) or self.item:CanUse(user.id) or self.item:IsActionable(user.id)) then
		return 1;
	else
		return 0;
	end
end

function Item:GetActions(user)
--	Log("[ Item ] GetActions");

	local actions = {};
	actions = self.item:GetActions(user.id, actions);
	return actions;
end

function Item:PerformAction(user, action)
	--Log("[ Item ] PerformAction: action="..action);

	return self.item:PerformAction(user.id, action);
end

-- EI END

----------------------------------------------------------------------------------------------------
function Item:IsUsable(user)
	if(self.item:CanPickUp(user.id)) then
		return 725725;	-- Magic number to identify item pickups from interactor
	elseif (self.item:CanUse(user.id)) then
		return 1;
	else
		return 0;
	end
end


----------------------------------------------------------------------------------------------------

function Item:GetUsableMessage()
	if (self.item:IsMounted()) then
		return "@use_mounted";
	else
		return self.item:GetUsableText();
	--	return string.format("Press USE to pickup the %s!", self.class); --localization done in C++
	end
end


----------------------------------------------------------------------------------------------------
function Item:OnUsed(user)
    if (user) then
		self:ActivateOutput( "Used",user.id );
	end
	return self.item:OnUsed(user.id);
end

----------------------------------------------------------------------------------------------------
function Item:OnFreeze(shooterId, weaponId, value)
	if ((not g_gameRules.game:IsMultiplayer()) or g_gameRules.game:GetTeam(shooterId)~=g_gameRules.game:GetTeam(self.id)) then
		return true;
	end
	return false;
end

----------------------------------------------------------------------------------------------------
function Item.Server:OnHit(hit)
	local explosionOnly=tonumber(self.Properties.bExplosionOnly or 0)~=0;
  local hitpoints = self.Properties.HitPoints;
  
	if (hitpoints and (hitpoints > 0)) then
		local destroyed=self.item:IsDestroyed()
		if (hit.type=="repair") then
			self.item:OnHit(hit);
		elseif ((not explosionOnly) or (hit.explosion)) then
			if ((not g_gameRules.game:IsMultiplayer()) or g_gameRules.game:GetTeam(hit.shooterId)~=g_gameRules.game:GetTeam(self.id)) then
				self.item:OnHit(hit);
				if (not destroyed) then
					if (hit.damage>0) then
						if (g_gameRules.Server.OnTurretHit) then
							g_gameRules.Server.OnTurretHit(g_gameRules, self, hit);
						end
					end
				
					if (self.item:IsDestroyed()) then
						if(self.FlowEvents and self.FlowEvents.Outputs.Destroyed)then
							self:ActivateOutput("Destroyed",1);
						end
					end
				end
			end
		end
	end
end

----------------------------------------------------------------------------------------------------
function Item.Server:OnShattered(hit)
	g_gameRules.Server.OnTurretHit(g_gameRules, self, hit);
end

------------------------------------------------------------------------------------------------------
function Item:Event_Hide()
	self:Hide(1);
	self:ActivateOutput( "Hide", true );
end

------------------------------------------------------------------------------------------------------
function Item:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHide", true );
end

------------------------------------------------------------------------------------------------------
function Item:Event_UserId(sender, user)
	self.flowUser = user;
end

------------------------------------------------------------------------------------------------------
function Item:Event_Use()
	self:OnUsed(self.flowUser);
end

------------------------------------------------------------------------------------------------------
Item.FlowEvents =
{
	Inputs =
	{
		Hide = { Item.Event_Hide, "bool" },
		UnHide = { Item.Event_UnHide, "bool" },
		Use = { Item.Event_Use, "bool" },
		UserId = { Item.Event_UserId, "entity" },
	},
	Outputs =
	{
		Hide = "bool",
		UnHide = "bool",
		Used = "entity",
	},
}

----------------------------------------------------------------------------------------------------
function MakeRespawnable(entity)
	if (entity.Properties) then
		entity.Properties.Respawn={
			nTimer=30,
			bUnique=0,
			bRespawn=0,
		};
	end
end


----------------------------------------------------------------------------------------------------
function CreateItemTable(name)
	if (not _G[name]) then
		_G[name] = new(Item);
	end
	--MakeRespawnable(_G[name]);
end


----------------------------------------------------------------------------------------------------
CreateItemTable("HMG");

HMG.Properties.bMounted=1;
HMG.Properties.bUsable=1;
HMG.Properties.bPickable=0;
HMG.Properties.MountedLimits = {
	pitchMin = -22,
	pitchMax = 60,
	yaw = 70,
};


-----------------------------------------------------------------------------------------------------
function HMG:OnReset()
	self.item:SetMountedAngleLimits(self.Properties.MountedLimits.pitchMin, self.Properties.MountedLimits.pitchMax, self.Properties.MountedLimits.yaw);
	self.inUse = false
end

----------------------------------------------------------------------------------------------------
function HMG:OnSpawn()
	self:OnReset();
end


----------------------------------------------------------------------------------------------------
function HMG:OnUsed(user)
	if (user.actor:IsPlayer()) then
		return Item.OnUsed(self, user);
	end
end

function HMG:OnAIUsed(user, goalPipeID)
	if (user.OnUseMountedWeaponRequest) then
		user:OnUseMountedWeaponRequest(self.id)
		return
	end

	g_SignalData.id = self.id;
	g_SignalData.iValue = goalPipeID;
	
	AI.Signal(SIGNALFILTER_SENDER, 0, "PrepareForMountedWeaponUse", user.id, g_SignalData);
end

----------------------------------------------------------------------------------------------------

CreateItemTable("VehicleHMG");

VehicleHMG.Properties.bMounted=1;
VehicleHMG.Properties.bUsable=1;
VehicleHMG.Properties.bPickable=0;

function VehicleHMG:IsUsable(user)
  local ret = self.item:CanUseVehicle(user.id);
  if (ret==true) then
	return 1;
  end;
  return ret;
end

----------------------------------------------------------------------------------------------------
CreateItemTable("VTOLHMG");

VTOLHMG.Properties.bMounted=1;
VTOLHMG.Properties.bUsable=1;
VTOLHMG.Properties.bPickable=0;

function VTOLHMG:IsUsable(user)
  local ret = self.item:CanUseVehicle(user.id);
  if (ret==true) then
	return 1;
  end;
  return ret;
end

----------------------------------------------------------------------------------------------------
CreateItemTable("AGL");

AGL.Properties.bMounted=1;
AGL.Properties.bUsable=1;
AGL.Properties.bPickable=0;
AGL.Properties.MountedLimits = {
	pitchMin = -22,
	pitchMax = 60,
	yaw = 70,
};



----------------------------------------------------------------------------------------------------
CreateItemTable("swarmer");


swarmer.Properties.bPickable=1;
swarmer.Properties.bUsable=1;



----------------------------------------------------------------------------------------------------
CreateItemTable("Heavy_minigun");


Heavy_minigun.Properties.bPickable=1;
Heavy_minigun.Properties.bUsable=1;



----------------------------------------------------------------------------------------------------
CreateItemTable("Heavy_mortar");


Heavy_mortar.Properties.bPickable=1;
Heavy_mortar.Properties.bUsable=1;



----------------------------------------------------------------------------------------------------
CreateItemTable("Grunt_PlasmaRifle");


Grunt_PlasmaRifle.Properties.bPickable=1;
Grunt_PlasmaRifle.Properties.bUsable=1;



----------------------------------------------------------------------------------------------------
CreateItemTable("plasma_thrower");


plasma_thrower.Properties.bPickable=1;
plasma_thrower.Properties.bUsable=1;



----------------------------------------------------------------------------------------------------
CreateItemTable("LightningGun");


LightningGun.Properties.bPickable=1;
LightningGun.Properties.bUsable=1;


----------------------------------------------------------------------------------------------------
CreateItemTable("UseableTurret");


UseableTurret.Properties.bMounted=1;
UseableTurret.Properties.bUsable=1;
UseableTurret.Properties.MountedLimits = {
	pitchMin = -22,
	pitchMax = 60,
	yaw = 70,
};

----------------------------------------------------------------------------------------------------
CreateItemTable("Cinematic_VTolMG");

Cinematic_VTolMG.Properties.bPickable=0;
Cinematic_VTolMG.Properties.bUsable=0;

function Cinematic_VTolMG:Event_Primary( )
	Game.SendEventToGameObject( self.id, "primary" );
end

function Cinematic_VTolMG:Event_Secondary( )
	Game.SendEventToGameObject( self.id, "secondary" );
end

function Cinematic_VTolMG:Event_Deactivate( )
	Game.SendEventToGameObject( self.id, "deactivate" );
end

Cinematic_VTolMG.FlowEvents =
{
	Inputs =
	{
		Primary = { Cinematic_VTolMG.Event_Primary, "bool" },
		Secondary = { Cinematic_VTolMG.Event_Secondary, "bool" },
		Deactivate = { Cinematic_VTolMG.Event_Deactivate, "bool" },
	},
	Outputs =
	{

	},
}

----------------------------------------------------------------------------------------------------
function CreateTurret(name)
	CreateItemTable(name);	
	
	local Turret = _G[name];
	
	Turret.Properties.esFaction = "Players";
	Turret.Properties.teamName = "";
	Turret.Properties.GunTurret = 
	{
		bSurveillance = 1,
		bVehiclesOnly = 0,
		bEnabled = 1,
		bSearching = 0,
		bSearchOnly = 0,
		MGRange = 50,
		RocketRange = 50,
		TACDetectRange = 300,
		TurnSpeed = 1.5,
		SearchSpeed = 0.5,
		UpdateTargetTime = 2.0,
		AbandonTargetTime = 0.5,
		TACCheckTime = 0.2,
		YawRange = 360,
		MinPitch = -45,
		MaxPitch = 45,
		AimTolerance = 20,
		Prediction = 1,
		BurstTime = 0.0,
		BurstPause = 0.0,
		SweepTime = 0.0,
		LightFOV = 0.0,
		ExplosiveDamageMultiplier = 1.0,
		bFindCloaked = 1,
		bExplosionOnly = 0,
	};
	
	Turret.Server.OnInit = function(self)
		self:OnReset();
	end;
	
	Turret.OnReset = function(self)
		local teamId=g_gameRules.game:GetTeamId(self.Properties.teamName) or 0;
		g_gameRules.game:SetTeam(teamId, self.id);
	end;

	Turret.Properties.objModel="";
	Turret.Properties.objBarrel="";
	Turret.Properties.objBase="";
	Turret.Properties.objDestroyed="";

	Turret.Properties.bUsable=nil;
	Turret.Properties.bPickable=nil;

	Turret.Event_EnableTurret = function(self)
		self.Properties.GunTurret.bEnabled = 1
		self:ActivateOutput("TurretEnabled", 1)
	end
	
	Turret.Event_DisableTurret = function(self)
		self.Properties.GunTurret.bEnabled = 0
		self:ActivateOutput("TurretDisabled", true)
	end

	Turret.FlowEvents.Inputs.EnableTurret = { Turret.Event_EnableTurret, "bool" };
	Turret.FlowEvents.Inputs.DisableTurret = { Turret.Event_DisableTurret, "bool" };  
	Turret.FlowEvents.Outputs.TurretEnabled =  "bool";
	Turret.FlowEvents.Outputs.TurretDisabled =  "bool";
	Turret.FlowEvents.Outputs.Destroyed =  "bool";

	return Turret;
  
end

CreateTurret("WarriorMOARTurret");
CreateTurret("AutoTurret").Properties.bExplosionOnly=1;
CreateTurret("AutoTurretAA").Properties.bExplosionOnly=1;
AutoTurret.Properties.bPickable=0;

----------------------------------------------------------------------------------------------------
CreateItemTable("RippableTurretGun");

RippableTurretGun.Properties.bMounted=1;
RippableTurretGun.Properties.bUsable=1;
RippableTurretGun.Properties.MountedLimits = {
			pitchMin = -22,
			pitchMax = 60,
			yaw = 70,
			};


-----------------------------------------------------------------------------------------------------
function RippableTurretGun:OnReset()
	self.item:SetMountedAngleLimits( self.Properties.MountedLimits.pitchMin,
																	self.Properties.MountedLimits.pitchMax,
																	self.Properties.MountedLimits.yaw	);
end

----------------------------------------------------------------------------------------------------
function RippableTurretGun:OnSpawn()
	self:OnReset();
end


----------------------------------------------------------------------------------------------------
function RippableTurretGun:OnUsed(user)
	if (user.actor:IsPlayer()) then
		Item.OnUsed(self, user);
	else
		g_SignalData.id = self.id;
		AI.Signal(SIGNALFILTER_SENDER, 0, "UseMountedWeapon", user.id,g_SignalData);
	end
end

function RippableTurretGun:OnAIUsed(user, goalPipeID)
	g_SignalData.id = self.id;
	g_SignalData.iValue = goalPipeID;
	
	AI.Signal(SIGNALFILTER_SENDER, 0, "PrepareForMountedWeaponUse", user.id, g_SignalData);
end

----------------------------------------------------------------------------------------------------


-- EI BEGIN

--[[ Moved into item XML files now

function MakeConsumable(entity)
	if (entity.Properties) then

		entity.Properties.Consumable = {
			nFoodAmount = 0,
			nDrinkAmount = 0,
			bRefillableDrink = 0,
			bIsFull = 0,
		};
		entity.Properties.Sound = {
			soundConsumed  = "",
			soundRefilled  = "",
			fVolume = 200,
			fRange = 50,
		};
		entity.Properties.bMounted = nil;
		entity.Properties.HitPoints = nil;
		entity.Properties.bPickable = 1;
	end

	entity.OnUsed = function(self, user, index, action)
		if (user.actor:IsPlayer()) then
			Item.OnUsed(self, user, index, action);
		end
	end;

	entity.OnReset = function(self)
		self:SetViewDistRatio(150); -- so you can see consumable from a further away - doesn't seem to work though
	end;

	entity.PhysicalizeThis = function(self)
		local physics = self.Properties.Physics;
	end;
end

----------------------------------------------------------------------------------------------------
function CreateConsumable(name)
	if (not _G[name]) then
		_G[name] = new(Item);
	end
	MakeConsumable(_G[name]);
end

function CreateFood(name)
	CreateConsumable(name);

	local consumable = _G[name];
	consumable.Editor.Category = "Items/Food";
	consumable.Properties.Consumable.nFoodAmount = 1;
	consumable.Properties.Sound.soundConsumed = "Sounds/physics:objects/consumables:eat"; -- c++ adds _fp or _3p
	return consumable;
end

function CreateDrink(name)
	CreateConsumable(name);

	local consumable = _G[name];
	consumable.Editor.Category = "Items/Drink";
	consumable.Properties.Consumable.nDrinkAmount = 1;
	consumable.Properties.Sound.soundConsumed = "Sounds/physics:objects/consumables:soda_open"; -- c++ adds _fp or _3p
	return consumable;
end

function CreateRefillableDrink(name)
	CreateDrink(name);

	local consumable = _G[name];
	consumable.Properties.Consumable.bRefillableDrink = 1;
	consumable.Properties.Consumable.bIsFull = 1;
	consumable.Properties.Sound.soundConsumed = "Sounds/physics:objects/consumables:drink"; -- c++ adds _fp or _3p
	consumable.Properties.Sound.soundRefilled = "Sounds/physics:objects/consumables:container_fill"; -- c++ adds _fp or _3p
	return consumable;
end


-- Food Items
CreateFood("HersheysBar");
HersheysBar.Properties.Consumable.nFoodAmount = 5;

CreateFood("PeasCan");
PeasCan.Properties.Consumable.nFoodAmount = 10;
PeasCan.Properties.Consumable.nDrinkAmount = 4;

CreateFood("SoupCan");
SoupCan.Properties.Consumable.nFoodAmount = 10;
SoupCan.Properties.Consumable.nDrinkAmount = 4;

CreateFood("RavioliCan");
RavioliCan.Properties.Consumable.nFoodAmount = 10;
RavioliCan.Properties.Consumable.nDrinkAmount = 2;

CreateFood("TunaCan");
TunaCan.Properties.Consumable.nFoodAmount = 10;
TunaCan.Properties.Consumable.nDrinkAmount = 10;

CreateFood("PearsCan");
PearsCan.Properties.Consumable.nFoodAmount = 10;
PearsCan.Properties.Consumable.nDrinkAmount = 4;

CreateFood("PeachesCan");
PeachesCan.Properties.Consumable.nFoodAmount = 10;
PeachesCan.Properties.Consumable.nDrinkAmount = 4;

CreateFood("NutSpread");
NutSpread.Properties.Consumable.nFoodAmount = 10;
NutSpread.Properties.Consumable.nDrinkAmount = 2;

CreateFood("MRE");
MRE.Properties.Consumable.nFoodAmount = 10;
MRE.Properties.Consumable.nDrinkAmount = 10;

CreateFood("DogFoodCan");
DogFoodCan.Properties.Consumable.nFoodAmount = 10;
DogFoodCan.Properties.Consumable.nDrinkAmount = 2;

CreateFood("CornCan");
CornCan.Properties.Consumable.nFoodAmount = 10;
CornCan.Properties.Consumable.nDrinkAmount = 4;

CreateFood("BeefStew");
BeefStew.Properties.Consumable.nFoodAmount = 10;
BeefStew.Properties.Consumable.nDrinkAmount = 4;

CreateFood("CannedMeat");
CannedMeat.Properties.Consumable.nFoodAmount = 10;
CannedMeat.Properties.Consumable.nDrinkAmount = 2;

CreateFood("MeatCooked");
MeatCooked.Properties.Consumable.nFoodAmount = 20;

CreateFood("MeatUncooked");
MeatUncooked.Properties.Consumable.nFoodAmount = 10;


-- Drink Items
CreateDrink("PepsiCan");
PepsiCan.Properties.Consumable.nDrinkAmount = 10;

CreateDrink("CokeCan");
CokeCan.Properties.Consumable.nDrinkAmount = 10;

CreateDrink("TomatoJuiceCan");
TomatoJuiceCan.Properties.Consumable.nDrinkAmount = 10;
TomatoJuiceCan.Properties.Consumable.nFoodAmount = 4;

CreateDrink("DrPepperCan");
DrPepperCan.Properties.Consumable.nDrinkAmount = 10;

CreateDrink("SpriteCan");
SpriteCan.Properties.Consumable.nDrinkAmount = 10;


-- Refillable Drink Items
CreateRefillableDrink("CivCanteen01");
CivCanteen01.Properties.Consumable.nDrinkAmount = 20;
--]]

-- Script.ReloadScript( "SCRIPTS/Entities/Items/Medical.lua");

-- EI EMND
