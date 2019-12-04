AirDropChristmas = {
	type = "AirDropChristmas",

	Client = {},
	Server = {},

	Properties = {
		-- Needs to be something very large to be seen from the ground
		fileModel = "GameSDK/Objects/props/santa_sleigh/sleigh.cgf",

		fTravelHeight = 1000, -- meters
		fTravelSpeed= 50, -- m/s

		fStartPercentRange = 0.8, -- middle percent of map plane can start in
		fFinishPercentRange = 0.6, -- middle percent of map plane can finish at
		fFadeInOutMultiplier = 0.75,  -- percent of map size plane appears before entering/after leaving the map

		LightLeftWingHelper = "light1",
		clrLightLeftColor = { x=1,y=0,z=0 },

		LightRightWingHelper = "light2",
		clrLightRightColor = { x=0,y=1,z=0 },

		LightRearTailHelper = "light3",
		clrLightTailColor = { x=1,y=1,z=1 },

		LightLeftWingStrobeHelper = "light4",
		clrLightLeftStrobeColor = { x=1,y=1,z=1 },

		LightRightWingStrobeHelper = "light5",
		clrLightRightStrobeColor = { x=1,y=1,z=1 },

		CrateClassName = "AirDropSantaCrate",

		StartAudioTrigger = "Play_airdrop_plane",
		StopAudioTrigger = "Stop_airdrop_plane",
	},
	
	Editor={
		--Model="Editor/Objects/T.cgf",
		Icon="AirDropChristmas.bmp",
	},
}

function AirDropChristmas:OnInit()
	self:OnReset();
end

function AirDropChristmas:OnPropertyChange()
	self:OnReset();
end

function AirDropChristmas:OnReset()
end

function AirDropChristmas:OnShutDown()
end

-- Called when the crate is dropped
--function AirDropChristmas:OnCrateDropped()
	--Log("AirDropChristmas - OnCrateDropped")
--end