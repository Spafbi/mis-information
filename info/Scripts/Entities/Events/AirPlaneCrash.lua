AirPlaneCrash = {
	type = "AirPlaneCrash",

	Client = {},
	Server = {},

	Properties = {
		mass = 4000,

		fileModel = "Objects/props/misc/vehicles/small_plane/small_plane_a.cgf",
		fileModelCrashed = "Objects/props/crashed_plane/small_plane_crashed.cgf",

		fTravelHeight = 3500, -- meters
		fTravelSpeed= 25, -- m/s

		fStartPercentRange = 0.8, -- middle percent of map plane can start in
		fFinishPercentRange = 0.8, -- middle percent of map plane can finish at
		fFadeInOutMultiplier = 0.1,  -- percent of map size plane appears before entering/after leaving the map

		 -- lights not used currently - need helpers on the airplane
		LightLeftWingHelper = "",
		clrLightLeftColor = { x=1,y=0,z=0 },

		LightRightWingHelper = "",
		clrLightRightColor = { x=0,y=1,z=0 },

		LightRearTailHelper = "",
		clrLightTailColor = { x=1,y=1,z=1 },

		ParticleEffectInAir = "misc.planecrash.smoke",
		ParticleEffectOnGround = "misc.planecrash.plane_crash",

		StartAudioTrigger = "Play_prop_plane",
		StopAudioTrigger = "Stop_prop_plane",

		Explosion = {
			damage = 500,
			pressure = 2000,
			min_radius = 4,
			max_radius = 30,
			min_phys_radius = 4,
			max_phys_radius = 16,
			sound_radius = 400,
			radialblurdist = 45,
			effect_name = "explosions.jerrycan_diesel.burning",
			effect_scale = 1,
			hit_type = "explosion",
		}
	},
	
	Editor={
		--Model="Editor/Objects/T.cgf",
		Icon="AirPlaneCrash.bmp",
	},
}

function AirPlaneCrash:OnInit()
	self:OnReset();
end

function AirPlaneCrash:OnPropertyChange()
	self:OnReset();
end

function AirPlaneCrash:OnReset()
end

function AirPlaneCrash:OnShutDown()
end

-- Called when the crash happens on the server
function AirPlaneCrash:OnCrashed()
	--Log("AirPlaneCrash - OnCrashed")

	-- spawn the loot after 1 second, so the explosion doesn't damage it
	Script.SetTimerForFunction(1000, "SpawnAirPlaneCrashLoot", self)
end

-- Spawn the loot
SpawnAirPlaneCrashLoot = function(self)
	--Log("AirPlaneCrash - SpawnAirPlaneCrashLoot")

	-- Two meters behind the direction vector
	local vForwardOffset = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset, self:GetDirectionVector(), -2.0)

	-- Offset by the entity location
	local vSpawnPos = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

	-- Move up by 1 meter
	FastSumVectors(vSpawnPos, vSpawnPos, {x=0,y=0,z=1})

	-- Items that spawn in when the plane crashes
	ISM.SpawnCategory("AirPlaneCrashCrate", vSpawnPos)
	ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos)
	ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos)
	ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos)

end