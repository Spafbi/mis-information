HouseVolume = 
{
	type = "HouseVolume",
	
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

function HouseVolume:OnInit()
	self:SetFlags(ENTITY_FLAG_SERVER_ONLY,0);
end

function HouseVolume:OnPropertyChange()
end


function HouseVolume:IsShapeOnly()
	return 0;
end


function HouseVolume:Event_Hide()
	self:Hide(1);
	self:ActivateOutput("Hidden", true);
end;


function HouseVolume:Event_UnHide()
	self:Hide(0);
	self:ActivateOutput( "UnHidden", true );
end;


HouseVolume.FlowEvents =
{
	Inputs =
	{
		Hide = { HouseVolume.Event_Hide, "bool" },
		UnHide = { HouseVolume.Event_UnHide, "bool" },
	},
	Outputs =
	{
		Hidden = "bool",
		UnHidden = "bool",
	},
}
