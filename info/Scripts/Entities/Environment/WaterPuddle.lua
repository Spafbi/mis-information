WaterPuddle = 
{
	type = "WaterPuddle",
	
	Properties = 
	{
		bEnabled = true,

		-- naming needs to be same as in C++
		gas_smoke = 0,
		gas_radiation = 0,
		humidity = 0,
		rain = 0,
		rain_acid = 0,
		rain_radiation = 0,
		physical = 0,
		ray_radiation = 0,
		explosion = 0,
		feet_sharp = 0,
		feet_blunt = 0,
		fire = 0,
		temperature = 0,
		light = 0,
		geigercounter = 0,
		electricity = 0,
		pool_acid = 0,

		-- particle effect for area based pfx hits
		ParticleEffect = "",

		-- scale effects from the center of area
		bScaleEffectsFromCenter = false,
	},
	
	Editor = 
	{
		Model="Editor/Objects/T.cgf",
		Icon="hazard.bmp",
		ShowBounds = 1,
		IsScalable = false;
		IsRotatable = true;
	},
}



function WaterPuddle:OnPropertyChange()
	-- The OnPropertyChange callback is forwarded to script directly by the editor.
	-- As most of this entity is written in C++, we just want to send a notification
	-- that a property has changed, and deal with it there.
	self:ProcessBroadcastEvent( "OnPropertyChange" );
end



function WaterPuddle:IsShapeOnly()
	return 0;
end



function WaterPuddle:Event_Hide()
	self:Hide(1);
	self:ActivateOutput("Hidden", true);
end;



function WaterPuddle:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHidden", true );
end;




WaterPuddle.FlowEvents =
{
	Inputs =
	{
		Hide = { WaterPuddle.Event_Hide, "bool" },
		UnHide = { WaterPuddle.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Hidden = "bool",
		UnHidden = "bool",
	},
}
