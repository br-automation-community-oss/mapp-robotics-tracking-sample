PROGRAM _INIT
	
	// This action defines the links to the conveyeor and the robot
	DefineLinks;
	
	MC_BR_PathInfo_0.Enable := TRUE;
	MC_BR_GroupReadInfo_X.Enable := TRUE;
	MC_BR_GroupReadCyclicPosition_X.Enable := TRUE;
	
	MC_BR_ConditionalStop_0.Enable := TRUE;
	MC_BR_ConditionalStop_0.Identifier := 123;
	MC_BR_ConditionalStop_0.Deactivate := TRUE;
	MC_BR_ConditionalStop_0.Reactivate := FALSE;
	
	MC_BR_GetCoordSystemIdent_X.CoordSystemName := NameTrackingPath;
	MC_BR_GetCoordSystemIdent_X.Execute := TRUE;
	MC_BR_GetCoordSystemIdent_X();
	
	MC_BR_ReadCyclicPosition_X.Enable := TRUE;
	MC_BR_ReadCyclicPosition_X.ValueSource := mcVALUE_ACTUAL;
	
	MC_BR_GroupReadCyclicPosition_X.CoordSystem := MC_BR_GetCoordSystemIdent_X.Ident;
	
	MC_BR_TrackingStatus_PathGen_X.Enable := TRUE;
	
	
END_PROGRAM