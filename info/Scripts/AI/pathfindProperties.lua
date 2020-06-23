function AssignPFPropertiesToPathType(...)
	AI.AssignPFPropertiesToPathType(...);
	if (System.IsEditor() and EditorAI) then
		EditorAI.AssignPFPropertiesToPathType(...);
	end
end

-- Default properties for humans
AssignPFPropertiesToPathType(
	"AIPATH_HUMAN",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0,
	5.0, 0.5, -10000.0, 0.0, 20.0, 3.5,
	0, 0.4, 2, 45, 1, true);

AI.AssignPathTypeToSOUser("Human", "AIPATH_HUMAN");

-- Default properties for car/vehicle agents
AssignPFPropertiesToPathType(
	"AIPATH_CAR",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_ROAD, 
	18.0, 18.0, 0.0, 0.0, 0.0, 
	0.0, 1.5, -10000.0, 0.0, 0.0, 7.0,
	0, 0.3, 2.0, 0.0, 5, true);

AssignPFPropertiesToPathType(
	"AIPATH_TANK",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_ROAD, 
	18.0, 18.0, 0.0, 0.0, 0.0, 
	0.0, 1.5, -10000.0, 0.0, 0.0, 7.0,
	0, 0.3, 2.0, 0.0, 6, true);

--- character that travels on the surface but has no preferences - except it prefers to walk around
--- hills rather than over them
AssignPFPropertiesToPathType(
	"AIPATH_DEFAULT",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN + NAV_SMARTOBJECT,
	0.0, 0.0, 0.0, 0.0, 0.0, 
	5.0, 0.5, -10000.0, 0.0, 20.0, 3.5,
	0, 0.4, 2, 45, 7, true);

-- Default properties for deer
AssignPFPropertiesToPathType(
	"AIPATH_DEER",
	NAV_TRIANGULAR + NAV_WAYPOINT_HUMAN,
	0.0, 0.0, 0.0, 0.0, 0.0,
	5.0, 0.5, -10000.0, 0.0, 20.0, 2.0, -- not as averse to going up hills
	0, 0.65, 2, 40, 8, true);

--[[ From IAgent.h
		navCapMask = IAISystem::NAVMASK_ALL;

		triangularResistanceFactor = 0.0f;
		waypointResistanceFactor = 0.0f;
		flightResistanceFactor = 0.0f;
		volumeResistanceFactor = 0.0f;
		roadResistanceFactor = 0.0f;

		waterResistanceFactor = 0.0f;
		maxWaterDepth = 10000.0f;
		minWaterDepth = -10000.0f;
		exposureFactor = 0.0f;
		dangerCost = 0.0f;		// Cost (in meters) per dead body in the destination node!
		zScale = 1.0f;

		customNavCapsMask = 0;
		radius = 0.3f;
		height = 2.0f;
		maxSlope = 0.0f;
		id = -1;
		avoidObstacles = true;
]]--