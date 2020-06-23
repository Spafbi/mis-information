DynEnvProbe =
{
	type = "DynEnvProbe",

	Properties =
	{
		bActive = true,
		bPreview = false,
		bPreviewExtents = true,
		
		bGenerate_1th_Pass = true, -- generate with no probes at all (dark shadows)
		bGenerate_2th_Pass = true, -- generate affected by a global probe
		bGenerate_2th_HideSelf = false, -- must be set when no second pass is used
		bGenerate_2th_HideOthers = false, -- generate twice only oneself (if first pass was used)
		fSunIntensityDiffuseFactor = 0.0,

		sGlobalName = "",
		TimeSamples = 24,

		ProbeExtents = { x=5,y=5,z=5},
		bBoxProjection = false,
		--Box = { x=10,y=10,z=10 },
		
		clrLigthColor = { x=1, y=1, z=1 },
		fDiffuseMultiplier = 1,
		fSpecularMultiplier = 1,
		
		fAttenuationFalloffMax = 0.3,

		bAffectsThisAreaOnly = true,
		bIgnoresVisAreas = false,
		-- bDeferredClipBounds = false,
		SortPriority = 0,
		
		-- FadeMin = { x=0,y=0,z=0 },
		-- FadeMax = { x=0,y=0,z=0 },
		
		-- bIndoorOnly = false,
	},

	Editor =
	{
		Icon="environmentProbe.bmp",
		ShowBounds = 0,
		AbsoluteRadius = 1,
	},

	Client = {},
	Server = {},
}

function DynEnvProbe:OnPropertyChange()
	Game.SendEventToGameObject( self.id, "UpdateFromProperties" );
	
	if (self.bActive and self.Properties.bDeferredClipBounds) then
		self:UpdateLightClipBounds(2);
	end
end

function DynEnvProbe:OnUpdate(dt)
	if (self.bActive and self.Properties.bDeferredClipBounds) then
		self:UpdateLightClipBounds(2);
	end
end
-- Flownode related

DynMatEntity.FlowEvents =
{
	Inputs =
	{
	},
	Outputs =
	{
	},
}