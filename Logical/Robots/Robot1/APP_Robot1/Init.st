PROGRAM _INIT
	
	// This action defines the links to the conveyeor and the robot
	DefineLinks;
	

	MC_BR_TrackingStatus_PathGen_0.Enable := TRUE;
	MC_BR_PathInfo_0.Enable := TRUE;
	MC_BR_TrackingStatus_PathGen_0.Enable := TRUE;
	MC_BR_GroupReadInfo_X.Enable := TRUE;
	
	MC_BR_ConditionalStop_0.Enable := TRUE;
	MC_BR_ConditionalStop_0.Identifier := 123;
	MC_BR_ConditionalStop_0.Deactivate := TRUE;
	MC_BR_ConditionalStop_0.Reactivate := FALSE;
	
END_PROGRAM