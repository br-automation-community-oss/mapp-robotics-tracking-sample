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
				LastProductPosition := MpAxConveyor.Position - ControlPanel.Input.ProductGap;
				State := STATE_PRODUCTION;
			END_IF
				
		//////////////////////////////////////// Frame Handling! + Stat Machine Conveyor///////////////////////////////////////
		STATE_PRODUCTION: 
		///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			
			// Move Belt with selected speed
			IF ControlPanel.Input.VelocityProduction <> AxParConveyor.Velocity THEN
				// If velocity ist not up to date, update Conveyer Velocity to the Velocity set at the ControlPanel
				MpAxConveyor.Update := TRUE;
			END_IF
			AxParConveyor.Velocity := ControlPanel.Input.VelocityProduction;
			MpAxConveyor.MoveVelocity := TRUE;
			
			// Frame Handling
			MC_BR_TrackingPathGetFrames_0.Execute := NOT(MC_BR_TrackingPathGetFrames_0.Done);
			IF MC_BR_TrackingPathGetFrames_0.Done AND NOT MC_BR_TrackingPathGetFrames_0.Busy AND NOT(MC_BR_TrackingFrameDelete_0.Execute) AND NOT(MC_BR_TrackingFrameCreate_0.Execute) THEN
				
				// Update the Data of the products stored in the product buffer
				updateProductData;
				// Find & Delete Products, which are out of scope
				deleteOutOfScopeProducts;	
				IF  NOT (MC_BR_TrackingFrameDelete_0.Execute) AND Start																														    AND
					((MpAxConveyor.Position >= LastProductPosition + ControlPanel.Input.ProductGap) 																							OR 
					(MpAxConveyor.Position < LastProductPosition AND (LastProductPosition + ControlPanel.Input.ProductGap >= McCfgAxConveyor.BaseType.LinearPeriodic.PeriodSettings.Period))) 	THEN

					addNewObjects;
				END_IF	
					
			END_IF
			
			IF (MpAxConveyor.Error) THEN
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
		
			IF ControlPanel.Input.Reset AND MpAxConveyor.Error AND MpAxConveyor.CommandBusy THEN
				MpAxConveyor.ErrorReset := TRUE;
				
			ELSIF Start AND NOT(MpAxConveyor.Error) AND NOT(MpAxConveyor.CommandBusy) THEN
				State := STATE_WAIT;
			END_IF			
					
	END_CASE
	
	

	(* *************************************************************************************************************************** *)
	(* *************************************************************************************************************************** *)
	(* *************************************************************************************************************************** *)

	// Function blocks call
	MpAxConveyor(MpLink := LinkAxis, Parameters := ADR(AxParConveyor), ErrorReset := ControlPanel.Input.Reset);
	
	// Tracking commands
	MC_BR_TrackingFrameCreate_0(TrackingPath := LinkTrackingPath);
	MC_BR_TrackingPathGetFrames_0(TrackingPath := LinkTrackingPath);
	MC_BR_TrackingFrameDelete_0(TrackingPath := LinkTrackingPath);
	
	// Update Scene Viewer positions
	updateSceneViewerPositions;	

	(* *************************************************************************************************************************** *)
	(*                                                    RESET PARAMETER 														   *)
	(* *************************************************************************************************************************** *)
	
	resetFUBs;

END_PROGRAM