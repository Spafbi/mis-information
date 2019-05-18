Script.ReloadScript( "SCRIPTS/Entities/Characters/Animals/Deer_x.lua")
-----------------------------------------------------------------------------------------------------

DeerFemale = {};
mergef(DeerFemale, Deer_x, 1);

-- Everything is the same as the base deer, but we just remove the antlers
DeerFemale.Properties.object_Model = "objects/characters/animals/deer/deer_female.cdf";