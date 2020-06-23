JointGen = {
	Properties = {
		object_BreakTemplate = "objects/broken_cube.cgf",
		file_Material = "",
		bForceEntityPieces = 0,
		bHierarchical = 1,
		Impulse = 1000,
		radius = 0.05,
		minSize = 0.0003,
		scale = 1,
		offset = {x=0,y=0,z=0},
	},

	Editor = {
		Icon = "Shake.bmp",
		DisplayArrow = 1,
	},
}

function JointGen:OnReset()
	local ang = {x=0,y=0,z=0};
	self:SetAngles(ang);
end

function JointGen:OnPropertyChange()
	self:OnReset()
end

function JointGen:OnSpawn()
	self:OnReset()
end
