DynMatEntity =
{
	type = "DynMatEntity",

	Properties =
	{
		object_Model = "Objects/default/primitive_box.cgf",
	},

	Editor =
	{
		Icon="mine.bmp",
	},

	Client = {},
	Server = {},
}

function DynMatEntity:OnPropertyChange()
	Game.SendEventToGameObject( self.id, "UpdateFromProperties" );
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