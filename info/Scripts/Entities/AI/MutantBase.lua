--Script.ReloadScript( "SCRIPTS/Entities/AI/Shared/AIBase.lua");
Script.ReloadScript( "SCRIPTS/Entities/AI/Shared/BasicAI.lua");

MutantBase =
{
}

--mergef(MutantBase, AIBase, 1);

function CreateMutant(child)
	mergef(child, MutantBase, 1);
	CreateActor(child);
end

