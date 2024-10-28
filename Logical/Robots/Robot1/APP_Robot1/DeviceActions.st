// This action choses the next Product to be manipulated by the robot
ACTION chooseNextProduct:
	
	// Input conveyor
	XPosMax := 0;
	j := MAX_TRACKING_FRAMES + 1;
	FOR i := 0 TO MAX_TRACKING_FRAMES DO
		IF ProductsIn[i].TrackingFrameID <> 0 AND 
			ProductsIn[i].Attribute <> 0 AND 
			ProductsIn[i].TrackingFrameID <> MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId THEN
			ProdDetails ACCESS ProductsIn[i].Attribute;
										
			// current frame is suitable - find the optimal one
			IF ProdDetails.Robot = DEV_Conveyor  AND	// no other robot has manipulate this object
				ProductsIn[i].Distance < MaxPickPosIn AND	// not already outside of the position
				ProductsIn[i].Distance > XPosMax AND 		// the object is the nearest to the robot
				ProductsIn[i].Distance > MinPickPosIn THEN // product is within the scope of the robot
				// select as next object
				XPosMax := ProductsIn[i].Distance;
				j := i;
			END_IF
		END_IF
	END_FOR
	
				
	IF j <= MAX_TRACKING_FRAMES THEN
		NextTrackingObjectIn := ProductsIn[j].Attribute;
		MC_GroupContinue_0.Execute := (MpDelta4Axis_X.Info.Program.InterruptStatus = mcINTERRUPT_INTERPRETER) AND NOT MC_GroupContinue_0.Done;
	ELSE
		NextTrackingObjectIn := 0;
	END_IF
	
	//Output conveyor
	XPosMax := 0;
	NextTrackingObjectOut := 0;
	FOR i := 0 TO MAX_TRACKING_FRAMES DO
		IF ProductsOut[i].TrackingFrameID <> 0 AND 
			ProductsOut[i].Attribute <> 0 AND 
			ProductsOut[i].TrackingFrameID <> MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId THEN
			ProdDetails ACCESS ProductsOut[i].Attribute;
										
			// current frame is suitable - find the optimal one
			IF ProdDetails.Robot = DEV_Conveyor  AND		// no other robot has manipulate this object
				ProductsOut[i].Distance < MaxPickPosOut AND	// not already outside of the position
				ProductsOut[i].Distance > XPosMax AND 			// the object is the nearest to the robot
				ProductsOut[i].Distance > MinPickPosOut THEN 	// product is within the scope of the robot
				// select as next object
				XPosMax := ProductsOut[i].Distance;
				NextTrackingObjectOut := ProductsOut[i].Attribute;
			END_IF
		END_IF
	END_FOR
	
END_ACTION

// This action operates the Gripper, 
ACTION operateGripper:
	FOR i := 0 TO MAX_TRACKING_FRAMES DO
		IF MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId <> 0 THEN
			
			ProdDetails ACCESS 0;
			IF MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId = ProductsIn[i].TrackingFrameID THEN
				ProdDetails ACCESS ProductsIn[i].Attribute;
			END_IF
			
			IF MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId = ProductsOut[i].TrackingFrameID THEN
				ProdDetails ACCESS ProductsOut[i].Attribute;
			END_IF
			
			IF ADR(ProdDetails) <> 0 THEN		
				ActTrackingObjectDetails ACCESS ADR(ProdDetails);
							
				IF M8 THEN
					ProdDetails.Robot := DEV_Robot;
					ProdDetails.GripperClosed := TRUE;
				END_IF
												
				IF M16 THEN
					ProdDetails.Robot := DEV_Robot;
					ProdDetails.GripperClosed := FALSE;
				END_IF
									
				IF M32 OR M33 OR M34 THEN
					ProdDetails.Robot := DEV_Removed;
					ProdDetails.GripperClosed := FALSE;
				END_IF	
				
			END_IF			
		END_IF
	END_FOR
	
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


ACTION runFUBs:

	MpDelta4Axis_X(MpLink := MpLinkDelta, Parameters := ADR(MpDelta4AxisPar_X));
	MC_BR_GroupHome_X(AxesGroup := MpLinkDelta);
	
	// Tracking of moving objects
	MC_BR_TrackingPathGetFrames_In(TrackingPath := LinkConveyorIn);
	MC_BR_TrackingPathGetFrames_Out(TrackingPath := LinkConveyorOut);
	MC_BR_TrackingStatus_PathGen_0(AxesGroup := MpLinkDelta);
	
	// Program info 
	//	MC_BR_ProgramInfo_0(AxesGroup := MpLinkDelta);
	MC_BR_PathInfo_0(AxesGroup := MpLinkDelta);
	
	// Interpreter Execution
	MC_GroupContinue_0(AxesGroup := MpLinkDelta);
	
	// Toogle Execution - needed cause FUB detects positive edge
	MC_BR_TrackingPathGetFrames_In.Execute := NOT(MC_BR_TrackingPathGetFrames_In.Done);
	MC_BR_TrackingPathGetFrames_Out.Execute := NOT(MC_BR_TrackingPathGetFrames_Out.Done);
	
	// Conditional stop
	MC_BR_ConditionalStop_0(AxesGroup := MpLinkDelta);
	
	IF MpDelta4Axis_X.UpdateDone THEN
		MpDelta4Axis_X.Update := FALSE;
	END_IF
	
	IF NOT(MpDelta4Axis_X.Error) OR NOT(MpDelta4Axis_X.CommandBusy) THEN
		MpDelta4Axis_X.ErrorReset := FALSE;
	END_IF
	
	IF NOT(MC_BR_GroupHome_X.Busy) AND (MC_BR_GroupHome_X.Done OR MC_BR_GroupHome_X.Error) THEN
		MC_BR_GroupHome_X.Execute := FALSE;
	END_IF
		
	IF NOT IPMonitor.Handshake THEN
		IPMonitor.Handshake := TRUE;
	END_IF
	
	IF MC_GroupContinue_0.Done OR MC_GroupContinue_0.Error THEN
		MC_GroupContinue_0.Execute := TRUE;
	END_IF
	
END_ACTION


ACTION updateInTrackingState:
	IF MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId = ProdDetails.TrackingFrameID AND
		MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId <> 0 THEN
		ProdDetails.InTracking := TRUE;
	ELSE
		ProdDetails.InTracking := FALSE;
	END_IF
END_ACTION
	

ACTION updateSceneViewer:
	
	// ------------------------------------------------------------------------------------------------------------------------------------------------		
	// Case Scene Viewer Update Robot 1: Update Positions in Tracking case, to get a Scene Viewer Visu
	// ------------------------------------------------------------------------------------------------------------------------------------------------		
	FOR i := 0 TO MAX_TRACKING_FRAMES DO
		IF MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId <> 0 THEN

			ProdDetails ACCESS 0;
			IF MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId = ProductsIn[i].TrackingFrameID THEN
				ProdDetails ACCESS ProductsIn[i].Attribute;
			END_IF
			
			IF MC_BR_TrackingStatus_PathGen_0.TrackingAdditionalInfo.TrackedFrame.FrameId = ProductsOut[i].TrackingFrameID THEN
				ProdDetails ACCESS ProductsOut[i].Attribute;
			END_IF
			
			IF ADR(ProdDetails) <> 0 THEN
					
				IF ProdDetails.PickPos.X = 0 AND ProdDetails.PickPos.Y = 0 AND ProdDetails.PickPos.Z = 0 AND ProdDetails.GripperClosed THEN
					ProdDetails.PickPosDelta.X := MpDelta4Axis_X.X;
					ProdDetails.PickPosDelta.Y := MpDelta4Axis_X.Y;
					ProdDetails.PickPosDelta.Z := MpDelta4Axis_X.Z;
					ProdDetails.PickPos := ProdDetails.Pos;
						
				END_IF
				IF ProdDetails.GripperClosed THEN
					ProdDetails.IncrementPos.X := (MpDelta4Axis_X.X - ProdDetails.PickPosDelta.X) - (ProdDetails.Pos.X - ProdDetails.PickPos.X);
					ProdDetails.IncrementPos.Y := (MpDelta4Axis_X.Y - ProdDetails.PickPosDelta.Y) - (ProdDetails.Pos.Y - ProdDetails.PickPos.Y);
					ProdDetails.IncrementPos.Z := (MpDelta4Axis_X.Z - ProdDetails.PickPosDelta.Z) - (ProdDetails.Pos.Z - ProdDetails.PickPos.Z);
				END_IF
			END_IF
		END_IF					
	END_FOR
	
				
	// ------------------------------------------------------------------------------------------------------------------------------------------------
	// Highliting of actual object tracked for Scene Viewer visu
	// ------------------------------------------------------------------------------------------------------------------------------------------------
	
	FOR i := 0 TO MAX_TRACKING_FRAMES DO
		IF ProductsIn[i].Attribute <> 0 THEN
			ProdDetails ACCESS ProductsIn[i].Attribute;
			updateInTrackingState;
		END_IF
		
		IF ProductsOut[i].Attribute <> 0 THEN
			ProdDetails ACCESS ProductsOut[i].Attribute;
			updateInTrackingState;
		END_IF
	END_FOR	
	
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