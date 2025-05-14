
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
		
	M8 := FALSE;
	M16 := FALSE;
	M17 := FALSE;
	M32 := FALSE;
	M33 := FALSE;
	M34 := FALSE;
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