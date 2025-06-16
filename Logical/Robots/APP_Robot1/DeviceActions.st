
// This action operates the Gripper, 
ACTION operateGripper:
	
	IF M16 THEN
		MultigripperClosedPos1 := FALSE;
		GripperClosed := FALSE;
	END_IF
	IF M17 THEN
		MultigripperClosedPos2 := FALSE;
	END_IF
	IF M32 THEN
		GripperClosed := TRUE;
	END_IF
	IF M33 THEN
		MultigripperClosedPos1 := TRUE;
	END_IF
	IF M34 THEN
		MultigripperClosedPos2 := TRUE;
	END_IF
	
	IF M40 THEN
		MC_BR_TrackingFrameCreate_X.Parameters.Translation.X := MC_BR_GroupReadCyclicPosition_X.CyclicPosition[0];
		MC_BR_TrackingFrameCreate_X.Parameters.Translation.Y := MC_BR_GroupReadCyclicPosition_X.CyclicPosition[1];
		MC_BR_TrackingFrameCreate_X.Parameters.LatchedPath.Position := MC_BR_ReadCyclicPosition_X.CyclicPosition;
		MC_BR_TrackingFrameCreate_X.Parameters.Attribute := 2#0100;
		MC_BR_TrackingFrameCreate_X.Execute := TRUE;
	END_IF
		
	M16 := FALSE;
	M17 := FALSE;
	M32 := FALSE;
	M33 := FALSE;
	M34 := FALSE;
	M40 := FALSE;
END_ACTION	


ACTION updateConditionalStop:
	
	// interrupt execution every 3 seconds 
	IF  ((TIME_TO_INT(clock_ms()) / 1500) MOD 2) = 0 THEN
		MC_BR_ConditionalStop_0.Reactivate := TRUE;
		MC_BR_ConditionalStop_0.Deactivate := FALSE;
	ELSE
		MC_BR_ConditionalStop_0.Deactivate := TRUE;
		MC_BR_ConditionalStop_0.Reactivate := FALSE;
	END_IF
	
	MC_BR_ConditionalStop_0.Reactivate := MC_BR_ConditionalStop_0.Reactivate AND NOT MC_BR_ConditionalStop_0.Activated;
	MC_BR_ConditionalStop_0.Deactivate := MC_BR_ConditionalStop_0.Deactivate AND MC_BR_ConditionalStop_0.Activated;
	
END_ACTION

ACTION calcPickRate:
	PickRateTrackingPath ACCESS LinkTrackingPath;
	IF PickRateWaitForSync 
		AND MC_BR_TrackingStatus_PathGen_X.TrackingState = mcPATHGEN_TS_SYNCHRONIZED 
		AND PickRateTrackingPath.controlif = MC_BR_TrackingStatus_PathGen_X.TrackingAdditionalInfo.TrackedObject.TrackedTrkPath.controlif THEN
		
		IF PickRateCount = 0 THEN
			PickRateTimestamp := clock_ms();
		ELSE
			PickRate := 60 * (UDINT_TO_LREAL(PickRateCount) / (TIME_TO_LREAL(clock_ms() - PickRateTimestamp) / 1000.0));
		END_IF
		PickRateCount := PickRateCount + 1;
		
	END_IF
	PickRateWaitForSync := MC_BR_TrackingStatus_PathGen_X.TrackingState = mcPATHGEN_TS_SYNCHRONIZING;
END_ACTION