ACTION addNewObjects:
		
	MC_BR_TrackingFrameCreate_0.Parameters.Translation.Y := yRange/2 - UDINT_TO_LREAL(createCnt) * yRange;
		
	IF createCnt > 0 OR yRange = 0 THEN
		createCnt := 0;
		LastProductPosition := MpAxConveyor.Position;
	ELSE
		createCnt := createCnt + 1;	
	END_IF
	
	// simulate two diffent product types
	MC_BR_TrackingFrameCreate_0.Parameters.Attribute := 0;
	IF (TIM_ticks() MOD 2) = 1 THEN
		MC_BR_TrackingFrameCreate_0.Parameters.Attribute := 1;
	END_IF;
		
	// Add frame in the buffer
	MC_BR_TrackingFrameCreate_0.Parameters.LatchedPath.Position := MpAxConveyor.Position;
	MC_BR_TrackingFrameCreate_0.Execute	:= TRUE;
	
END_ACTION
	

ACTION resetFUBs:
	
	IF (MpAxConveyor.Update AND MpAxConveyor.UpdateDone) OR MpAxConveyor.Error THEN
		MpAxConveyor.Update	:= FALSE;
	END_IF
	
		IF (NOT(MpAxConveyor.MoveActive) AND NOT(MpAxConveyor.CommandBusy)) OR MpAxConveyor.Error THEN
			MpAxConveyor.MoveVelocity := FALSE;
			MpAxConveyor.Update := FALSE;
		END_IF	
	
		IF MpAxConveyor.ErrorReset AND NOT(MpAxConveyor.Error) THEN
			MpAxConveyor.ErrorReset := FALSE;
		END_IF
	
		IF (MpAxConveyor.Home AND MpAxConveyor.IsHomed) OR MpAxConveyor.Error THEN
			MpAxConveyor.Home := FALSE;
		END_IF
	
		MC_BR_TrackingFrameCreate_0.Execute	:= FALSE;

				
END_ACTION