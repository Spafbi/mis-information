AI.TacticalPositionManager.Pig = AI.TacticalPositionManager.Pig or {};

function AI.TacticalPositionManager.Pig:OnInit()

	AI.RegisterTacticalPointQuery(
	{
		-- The default height tolerance appears to be fairly small, so we have a series of
		-- tables that are designed to allow the AI to go up and down inclines at times
		-- the up heights are different from the down heights so that we don't get into
		-- a circular up/down loop

		Name = "Pig_Wander",
		{
			Parameters = { density = 8.0, },
			Generation = { grid_around_puppet = 32.0, },
			Conditions = { isInNavigationMesh = true },
			Weights =    { random = 1.0, },
		},
	} );

	AI.RegisterTacticalPointQuery(
	{
		Name = "Pig_RunAway",
		{
			Parameters = { density = 16.0, },
			Generation = { grid_around_puppet = 48.0, },
			Conditions = { isInNavigationMesh = true, min_distance_from_puppet = 16.0, towards_the_attentionTarget = false, },
			Weights =    { distance_from_puppet = -0.75, random = 0.5, otherSide_of_attentionTarget = -2.0, },
		},
		{
			Parameters = { density = 16.0, },
			Generation = { grid_around_puppet = 48.0, },
			Conditions = { isInNavigationMesh = true, min_distance_from_puppet = 16.0, },
			Weights =    { distance_from_puppet = -0.75, random = 0.5, otherSide_of_attentionTarget = -1.0, },
		},
		{
			Parameters = { density = 8.0, },
			Generation = { grid_around_puppet = 32.0, },
			Conditions = { isInNavigationMesh = true, min_distance_from_puppet = 8.0, },
			Weights =    { distance_from_puppet = -0.5, random = 0.25, },
		},
		{
			Parameters = { density = 8.0, },
			Generation = { grid_around_puppet = 16.0, },
			Conditions = { isInNavigationMesh = true, },
			Weights =    { random = 1.0, },
		},
	} );
	
end


-- Just some other conditions and weights

-- towards_the_attentionTarget = false,

--				distance_from_puppet = -1,
--				distance_from_attentionTarget = 1,

--				objectsDot_to_realTarget = -0.3,
--				otherSide_of_realTarget = -1.0,
--				directness_to_attentionTarget = -1.0,
--				towards_the_referencePoint = -1.0,
--				towards_the_attentionTarget = 1.0,
--				otherSide_of_attentionTarget = -3.0,
--				changeInDistance_to_attentionTarget = -0.5,