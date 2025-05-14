VAR CONSTANT
	UpperZLevel : LREAL := 100.0;	// Gripper up position
	LowerZLevel : LREAL := 0.0;		// Gripper down position
	YProductPos : LREAL := 200;		// position in y coordinate where the product should be placed
END_VAR


VAR	
	ParkPos				: McPointType := (Pos:=(X:=	  0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosUp			: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosDown		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= LowerZLevel));
	StaticMoveDown		: McPointType := (Pos:=(X:=	  0, Y:= 0, 			Z:= 0));
	MoveToPark : BOOL := FALSE;
		
	FrameIn : McTrkFrmIdentType;
	FrameOut : McTrkFrmIdentType;
END_VAR


PROGRAM _MAIN
	
	// Position init, reset frame in case of restart
	SetPCS(MachineFrame);
	MoveLR(ParkPos);
	WaitEndMove();
	
	WaitUntil(TrackingFrameSelect(FrameIn,'Infeed'));				    // hold interpreter until a new frame is available 
	REPEAT		
		MoveToPark := FALSE;
			
		TrackObjectR(FrameIn, SynchPosUp, 50, 50);						// track on product
		MoveLR(SynchPosDown);											// move to the take position
		WaitALAP();														// hold interpreter
		// Close the gripper here	
		SetM(32);														// Scene - remove product from belt
		WaitTime(0.04);													// Wait until gripper opens
		MoveLR(SynchPosUp);												// move up to change frame
		
		IF TrackingFrameGetAttribute(FrameIn) = 1 THEN					// sort out objects of type 1					
			TrackStopR(FixedPlace, ParkPos, 50, 50);					// Move to the fixed place Position
			MoveLR(StaticMoveDown);										// move to the take position
			SetM(16);													// open the gripper here
			WaitTime(0.04);												// Wait until gripper opens
			MoveLR(ParkPos);											// move to the take position
			WaitALAP();
			
			IF NOT TrackingFrameSelect(FrameIn,'Infeed') THEN				// Need to stop, no objects left
				MoveToPark := TRUE;										// force park position
			END_IF
			
		ELSE
			
			WaitUntil(TrackingFrameSelect(FrameOut,'Outfeed'));			// hold interpeter until place frame has been selected
			TrackObjectR(FrameOut, SynchPosUp, 50, 50);	// move to place position
			MoveLR(SynchPosDown);										// move down on place position
			WaitALAP();													// hold interpreter 
			
			SetM(16);													// Scene - place product on belt, Open the gripper here
			WaitTime(0.04);												// Wait until gripper opens
			MoveLR(SynchPosUp);											// move up to change frame
			
			IF NOT TrackingFrameSelect(FrameIn,'Infeed') THEN			// Need to stop, no objects left
				TrackStopR(MachineFrame, ParkPos, 50, 50);				// Move to a static frame
				MoveToPark := TRUE;										// force park position
			END_IF

		END_IF
		
		IF MoveToPark THEN
			MoveLR(ParkPos);											// move to static park position										
			WaitEndMove();												// sync interpreter and program 
			WaitUntilSync(TrackingFrameSelect(FrameIn,'Infeed'));		// hold interpreter until a new frame is available 
		END_IF
		
	UNTIL FALSE END_REPEAT;
	
END_PROGRAM 