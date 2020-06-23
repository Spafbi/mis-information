LoginExclusion = 
{
	type = "LoginExclusion",
	
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

function LoginExclusion:OnInit()
	self:SetFlags(ENTITY_FLAG_CLIENT_ONLY,0);
end

function LoginExclusion:OnPropertyChange()
end


function LoginExclusion:IsShapeOnly()
	return 0;
end


function LoginExclusion:Event_Hide()
	self:Hide(1);
	self:ActivateOutput("Hidden", true);
end;


function LoginExclusion:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHidden", true );
end;


LoginExclusion.FlowEvents =
{
	Inputs =
	{
		Hide = { LoginExclusion.Event_Hide, "bool" },
		UnHide = { LoginExclusion.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Hidden = "bool",
		UnHidden = "bool",
	},
}
