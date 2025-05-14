PROGRAM _CYCLIC
	DefineLinks;

	CASE State OF

		/////////////////////////////////////////////////////////////////////////////
		ROBOT_WAIT:
		/////////////////////////////////////////////////////////////////////////////
			IF  Start THEN
				State := ROBOT_RESET;
			END_IF
			MC_BR_GroupPower_X.Enable := FALSE;
			
		/////////////////////////////////////////////////////////////////////////////
		ROBOT_RESET:
		/////////////////////////////////////////////////////////////////////////////
			MC_GroupReset_X.Execute := TRUE;
			IF MC_GroupReset_X.Done THEN
				State := ROBOT_POWER;
			END_IF
			
		/////////////////////////////////////////////////////////////////////////////
		ROBOT_POWER:
		/////////////////////////////////////////////////////////////////////////////
			MC_BR_GroupPower_X.Enable := TRUE;
			IF MC_BR_GroupPower_X.Status THEN
				State := ROBOT_HOME;
			END_IF
				
		/////////////////////////////////////////////////////////////////////////////
		ROBOT_HOME:
		/////////////////////////////////////////////////////////////////////////////
			MC_BR_GroupHome_X.Execute := TRUE;
			IF MC_BR_GroupHome_X.Done THEN
				State := ROBOT_MOVE;
			END_IF
				
			
		/////////////////////////////////////////////////////////////////////////////
		ROBOT_MOVE:
		/////////////////////////////////////////////////////////////////////////////
			MC_BR_MoveProgram_X.Execute := TRUE;
			IF MC_BR_MoveProgram_X.Active THEN
				State := ROBOT_PRODUCTION;
			END_IF
				
		/////////////////////////////////////////////////////////////////////////////	
		ROBOT_PRODUCTION:
		/////////////////////////////////////////////////////////////////////////////

			operateGripper;
			updateConditionalStop;

			IF MC_BR_MoveProgram_X.Done THEN
					State := ROBOT_WAIT;
			ELSIF NOT(Start) THEN
				MC_BR_GroupStop_X.Execute := TRUE;
				IF MC_BR_GroupStop_X.Done THEN
					State := ROBOT_WAIT;
				END_IF 
			END_IF
					
				
		///////////////////////////////////////////////////////////////////////////////
		ROBOT_ERROR:
		///////////////////////////////////////////////////////////////////////////////
			IF Reset THEN
				State := ROBOT_WAIT;
			END_IF
		
	END_CASE
	
	IF MC_GroupReset_X.Error OR MC_BR_GroupPower_X.Error OR MC_BR_GroupHome_X.Error OR MC_BR_MoveProgram_X.Error OR MC_BR_GroupReadInfo_X.Error THEN
		State := ROBOT_ERROR;	
	END_IF
			
	
	MC_BR_GroupReadInfo_X(AxesGroup := LinkAxesGroup);
	MC_GroupReset_X(AxesGroup := LinkAxesGroup);
	MC_BR_GroupPower_X(AxesGroup := LinkAxesGroup);
	MC_BR_GroupHome_X(AxesGroup := LinkAxesGroup);
	MC_BR_MoveProgram_X(AxesGroup := LinkAxesGroup);
	MC_BR_GroupStop_X(AxesGroup := LinkAxesGroup);
	MC_BR_TrackingStatus_PathGen_0(AxesGroup := LinkAxesGroup);
	MC_GroupContinue_0(AxesGroup := LinkAxesGroup);
	MC_BR_PathInfo_0(AxesGroup := LinkAxesGroup);
	MC_BR_ConditionalStop_0(AxesGroup := LinkAxesGroup);
	MC_BR_GroupReadCyclicPosition_X(AxesGroup := LinkAxesGroup);
	MC_BR_TrackingFrameCreate_X(TrackingPath := LinkTrackingPath);
	MC_BR_ReadCyclicPosition_X(Axis := LinkAxisTrackingPath);
	
	
	MC_GroupReset_X.Execute := FALSE;
	MC_BR_GroupHome_X.Execute := FALSE;
	MC_BR_MoveProgram_X.Execute := FALSE;
	MC_BR_GroupStop_X.Execute := FALSE;
	MC_GroupContinue_0.Execute := FALSE;
	MC_BR_TrackingFrameCreate_X.Execute := FALSE;
	
	IF NOT IPMonitor.Handshake THEN
		IPMonitor.Handshake := TRUE;
	END_IF
	
			 
END_PROGRAM
