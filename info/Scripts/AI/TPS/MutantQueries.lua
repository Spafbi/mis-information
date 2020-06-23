AI.TacticalPositionManager.Mutant = AI.TacticalPositionManager.Mutant or {};

function AI.TacticalPositionManager.Mutant:OnInit()
	
	AI.RegisterTacticalPointQuery(
	{
		Name = "Mutant_Wander",
		{
			Parameters = { density = 4.0, },
			Generation = { grid_around_puppet = 32.0, },
			Conditions = { isInNavigationMesh = true },
			Weights =    { random = 1.0, },
		},
	} );

	AI.RegisterTacticalPointQuery(
	{
		Name = "Mutant_ApproachAttentionTarget",
		{
			Generation =
			{
				pointsInNavigationMesh_around_attentionTarget = 5.0, -- Width (height is hardcoded to be 20 down and 0.2 up)
			},
			Conditions =
			{
				min_distance_from_attentionTarget = 3.0,
			},
			Weights =
			{
				distance_from_attentionTarget = -1.0,
			},
		},
	} );

	AI.RegisterTacticalPointQuery(
	{
		Name = "Mutant_GetNearPlayer",
		{
			Parameters =	{ density = 1 },
			Generation =	{ grid_around_player = 5 },
			Conditions = 	{ reachable = true, towards_the_player = true, max_distance_from_player = 3.0, },
			Weights =		{ distance_from_player = -1.0, directness_to_player = 0.5 },
		},
	} );

	AI.RegisterTacticalPointQuery(
	{
		Name = "Mutant_CurrentPosition",
		{
			Parameters =	{ density = 2 },
			Generation =	{ grid_around_puppet = 10 },
			Conditions = 	{ reachable = true, max_distance_from_puppet = 8.0, },
			Weights =		{ random = 1.0 },
		},
	} );

	AI.RegisterTacticalPointQuery(
	{
		Name = "Mutant_RallyPoint",
		{
			Parameters =	{ density = 1 },
			Generation =	{ grid_around_referencePoint = 3.0 },
			Conditions = 	{ reachable = true },
			Weights =		{ random = 1.0 },
		},
	} );

	AI.RegisterTacticalPointQuery(
	{
		Name = "Mutant_SearchQuery",
		{
			Parameters =	{ density = 5 },
			Generation =	{ grid_around_referencePoint = 5.0 },
			Conditions = 	{ min_distance_to_puppet = 2.0 },
			Weights =		{ distance_to_puppet = -0.1, random = 0.5 },
		},
	} );

end