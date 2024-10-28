PROGRAM _CYCLIC

	Start := 
	ControlPanel.Input.StartMultipick OR 
	ControlPanel.Input.StartPickNPlace OR 
	ControlPanel.Input.StartPlaceWithConditionalStop OR 
	ControlPanel.Input.StartPrePalletizing OR
	ControlPanel.Input.StartSorting;
	
	
	CASE State OF

		/////////////////////////////////////////////////////////////////////////////
		STATE_WAIT:
			/////////////////////////////////////////////////////////////////////////////
			/// State M. Wait
			IF  Start THEN
				State := STATE_INIT;
			ELSE
				MpDelta4Axis_X.ErrorReset := FALSE;
				MpDelta4Axis_X.Power := FALSE;
			END_IF
			
		/////////////////////////////////////////////////////////////////////////////
		STATE_INIT:
		/////////////////////////////////////////////////////////////////////////////
			/// State M. Init
			
			IF NOT MpDelta4Axis_X.Active THEN
				MpDelta4Axis_X.Enable := TRUE;
				
			ELSIF MpDelta4Axis_X.Error OR MC_BR_GroupHome_X.Error AND NOT MpDelta4Axis_X.UpdateDone THEN
				MpDelta4Axis_X.Update := TRUE;
				
			ELSIF (MpDelta4Axis_X.Error OR MC_BR_GroupHome_X.Error) THEN
				MpDelta4Axis_X.ErrorReset := TRUE;
			
			ELSIF MpDelta4Axis_X.CommandBusy OR MC_BR_GroupHome_X.Busy THEN
				// wait
				
			ELSIF NOT(MpDelta4Axis_X.PowerOn) THEN
				MpDelta4Axis_X.Power := TRUE;
			
			ELSIF NOT(MpDelta4Axis_X.IsHomed) THEN
				MC_BR_GroupHome_X.Execute := TRUE;			
						
			ELSIF MpDelta4Axis_X.Info.CommunicationReady AND NOT(MpDelta4Axis_X.CommandBusy) THEN
				
				IF ControlPanel.Input.StartMultipick THEN
					MpDelta4AxisPar_X.ProgramName := 'Multipick.st';
				END_IF
				
				IF ControlPanel.Input.StartPickNPlace THEN
					MpDelta4AxisPar_X.ProgramName := 'PickNPlace.st';
				END_IF
				
				IF ControlPanel.Input.StartPlaceWithConditionalStop THEN
					MpDelta4AxisPar_X.ProgramName := 'PlaceWithConditionalStop.st';
				END_IF
				
				IF ControlPanel.Input.StartPrePalletizing THEN
					MpDelta4AxisPar_X.ProgramName := 'PrePalletizing.st';
				END_IF
					
				IF ControlPanel.Input.StartSorting THEN
					MpDelta4AxisPar_X.ProgramName := 'Sorting.st';
				END_IF
								
				MpDelta4Axis_X.MoveProgram := TRUE;
				NextTrackingObjectIn := 0;
				NextTrackingObjectOut := 0;
				MultigripperClosedPos1 := FALSE;
				MultigripperClosedPos2 := FALSE;
				GripperClosed := FALSE;
				State := STATE_PRODUCTION;
						
			END_IF
				
		
		/////////////////////////////////////////////////////////////////////////////	
		STATE_PRODUCTION:
		/////////////////////////////////////////////////////////////////////////////

			// ------------------------------------------------------------------------------------------------------------------------------------------------
			// Case Pick Frame: choose which frame is the next to pick which is not already grabbed and not already in manipulation
			// ------------------------------------------------------------------------------------------------------------------------------------------------
			chooseNextProduct;

			// ------------------------------------------------------------------------------------------------------------------------------------------------
			// Case Grip Product: Hande M Commands on Tracked object
			// ------------------------------------------------------------------------------------------------------------------------------------------------
			operateGripper;
			
			
			// ------------------------------------------------------------------------------------------------------------------------------------------------
			// Update the random set conditional stop
			// ------------------------------------------------------------------------------------------------------------------------------------------------
			updateConditionalStop;
			
			
			// ------------------------------------------------------------------------------------------------------------------------------------------------		
			// Case Scene Viewer Update Robot 1: Update Positions in Tracking case, to get a Scene Viewer Visu
			// ------------------------------------------------------------------------------------------------------------------------------------------------		
		
			updateSceneViewer;	

			// ------------------------------------------------------------------------------------------------------------------------------------------------
			// Case State M. Production : Handle End of Process
			// ------------------------------------------------------------------------------------------------------------------------------------------------
			IF MpDelta4Axis_X.Error THEN
				State := STATE_ERROR;
			
			ELSIF NOT(Start) THEN
				IF MpDelta4Axis_X.Error OR MC_BR_GroupHome_X.Error THEN
					State := STATE_WAIT;
					MpDelta4Axis_X.MoveProgram := FALSE;
					MpDelta4Axis_X.Power := FALSE;
					
				ELSIF MpDelta4Axis_X.MoveActive THEN
					MpDelta4Axis_X.MoveProgram := FALSE;
					
				ELSIF MpDelta4Axis_X.PowerOn THEN	
					MpDelta4Axis_X.Power := FALSE;
					MpDelta4Axis_X.MoveProgram := FALSE;
					
				ELSE
					State := STATE_WAIT;

				END_IF 
			END_IF
		
				
		///////////////////////////////////////////////////////////////////////////////
		STATE_ERROR:
			///////////////////////////////////////////////////////////////////////////////
			/// State M. Error
			IF ControlPanel.Input.Reset AND MpDelta4Axis_X.Error AND NOT(MpDelta4Axis_X.CommandBusy) THEN
				MpDelta4Axis_X.MoveProgram := FALSE;
				MpDelta4Axis_X.Power := FALSE;
				MpDelta4Axis_X.ErrorReset := TRUE;
				
			ELSIF Start AND NOT(MpDelta4Axis_X.Error) AND NOT(MpDelta4Axis_X.CommandBusy) THEN
				MC_BR_GroupHome_X.Execute := TRUE;
				State := STATE_WAIT;
			END_IF
					
	END_CASE

	runFUBs;
			 
END_PROGRAM
