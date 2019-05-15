KytheraReferencePoint = {
	type = "KytheraReferencePoint",

	Editor = {
		Icon = "TagPoint.bmp",
	},
	Properties = {
		sTag = "",
		sTag2 = "",
	},
}

-------------------------------------------------------
function KytheraReferencePoint:OnSpawn()
	self:SetFlags(ENTITY_FLAG_SERVER_ONLY,0);
end

-------------------------------------------------------
function KytheraReferencePoint:OnInit()
	Kyt.AddTag(self.id,self.Properties.sTag);
	Kyt.AddTag(self.id,self.Properties.sTag2);
end


-------------------------------------------------------
function KytheraReferencePoint:OnReset()
	-- Clear all tags?
	Kyt.AddTag(self.id,self.Properties.sTag);
	Kyt.AddTag(self.id,self.Properties.sTag2);
end


Log("[KytheraReferencePoint.lua] KRP loaded")

