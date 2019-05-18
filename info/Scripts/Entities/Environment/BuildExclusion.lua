BuildExclusion = 
{
	type = "BuildExclusion",
	
	Properties = 
	{
	},
	
	Editor = 
	{
		Model="Editor/Objects/T.cgf",
		Icon="Water.bmp",
		ShowBounds = 1,
		IsScalable = false;
		IsRotatable = true;
	},
}

function BuildExclusion:OnInit()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0);
end

function BuildExclusion:OnPropertyChange()
end


function BuildExclusion:IsShapeOnly()
	return 0;
end


function BuildExclusion:Event_Hide()
	self:Hide(1);
	self:ActivateOutput("Hidden", true);
end;


function BuildExclusion:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHidden", true );
end;


BuildExclusion.FlowEvents =
{
	Inputs =
	{
		Hide = { BuildExclusion.Event_Hide, "bool" },
		UnHide = { BuildExclusion.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Hidden = "bool",
		UnHidden = "bool",
	},
}
