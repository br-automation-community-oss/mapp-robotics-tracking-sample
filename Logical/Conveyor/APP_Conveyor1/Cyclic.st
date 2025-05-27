PROGRAM _CYCLIC	
	DefineLinks;
	
	CASE State OF
		
		/////////////////////////////////////////////////////////////////////////////
		STATE_WAIT:
			/////////////////////////////////////////////////////////////////////////////
			IF  Start THEN
				State := 	STATE_INIT;
			END_IF

		/////////////////////////////////////////////////////////////////////////////
		STATE_INIT:
		////////////////////////////////////////////////////////////////////////////
			
			IF MpAxConveyor.CommandBusy THEN
				// wait	
			ELSIF 	NOT(MpAxConveyor.Active) THEN
				MpAxConveyor.Enable := TRUE;
				
			ELSIF MpAxConveyor.Error THEN
				MpAxConveyor.ErrorReset := TRUE;
											
			ELSIF NOT(MpAxConveyor.PowerOn) THEN
				MpAxConveyor.Power := TRUE;
			
			ELSIF NOT(MpAxConveyor.IsHomed) THEN
				AxParConveyor.Homing.Mode := mcHOMING_DIRECT;
				AxParConveyor.Homing.Position := 0;
				MpAxConveyor.Home := TRUE;
				
			ELSIF MpAxConveyor.Info.CommunicationReady THEN
				LastProductPosition := MpAxConveyor.Position - ProductGap;
				MC_BR_TrackingFrameDelete_0.Execute := TRUE;
				State := STATE_PRODUCTION;
			END_IF
				
		//////////////////////////////////////// Frame Handling! + Stat Machine Conveyor///////////////////////////////////////
		STATE_PRODUCTION: 
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			// Move Belt with selected speed
			IF AxParConveyor.Velocity  <> SetVelocity THEN
				// If velocity ist not up to date, update Conveyer Velocity to the Velocity set at the ControlPanel
				MpAxConveyor.Update := TRUE;
			END_IF
			AxParConveyor.Velocity := SetVelocity;
			MpAxConveyor.MoveVelocity := TRUE;
			
			IF NOT MC_BR_TrackingFrameCreate_0.Busy THEN
				addNewObjects;
			END_IF	
				
			IF MpAxConveyor.Error THEN
				State := STATE_ERROR;
				
			ELSIF NOT Start THEN
				MpAxConveyor.MoveVelocity := FALSE;
				
				IF (MpAxConveyor.Error) THEN
					MpAxConveyor.Power := FALSE;
					State := STATE_WAIT;

				ELSIF MpAxConveyor.PowerOn AND NOT(MpAxConveyor.CommandBusy) THEN
					MpAxConveyor.MoveVelocity := FALSE;
					MpAxConveyor.Power := FALSE;
					
				ELSIF NOT(MpAxConveyor.CommandBusy) THEN
					State := STATE_WAIT;
					
				END_IF 
			END_IF
			
		///////////////////////////////////////////////////////////////////////////////
		STATE_ERROR:
		///////////////////////////////////////////////////////////////////////////////
			MpAxConveyor.MoveVelocity := FALSE;
			MpAxConveyor.Power := FALSE;
		
			IF Reset AND MpAxConveyor.Error AND MpAxConveyor.CommandBusy THEN
				MpAxConveyor.ErrorReset := TRUE;
				
			ELSIF Start AND NOT(MpAxConveyor.Error) AND NOT(MpAxConveyor.CommandBusy) THEN
				State := STATE_WAIT;
			END_IF			
					
	END_CASE
	
	MpAxConveyor(MpLink := LinkAxis, Parameters := ADR(AxParConveyor), ErrorReset := Reset);
	MC_BR_TrackingFrameCreate_0(TrackingPath := LinkTrackingPath);
	MC_BR_TrackingFrameDelete_0(TrackingPath := LinkTrackingPath);
	
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
	MC_BR_TrackingFrameDelete_0.Execute := FALSE;


END_PROGRAM