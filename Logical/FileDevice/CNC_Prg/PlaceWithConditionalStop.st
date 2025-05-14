VAR CONSTANT
	UpperZLevel : LREAL := 100.0;	// Gripper up position
	LowerZLevel : LREAL := 0.0;		// Gripper down position
	YProductPos : LREAL := 200;		// position in y coordinate where the product should be placed
END_VAR
	
VAR	
	ParkPos				: McPointType := (Pos:=(X:=	  0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosUp			: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosDown		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= LowerZLevel));
	StaticMoveDown		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= -100));
	StaticMoveUp		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= 100));
	
	FrameIn : McTrkFrmIdentType;
	FrameOut : McTrkFrmIdentType;
END_VAR


PROGRAM _MAIN
	
	// Position init, reset frame in case of restart
	SetPCS(MachineFrame);
	MoveLR(ParkPos);
	WaitEndMove();
	
	WaitUntil(TrackingFrameSelect(FrameIn,'Infeed'));				// hold interpreter until a new frame is available 
	REPEAT		

		TrackObjectR(FrameIn, SynchPosUp, 50, 50);					// track on product
		MoveLR(SynchPosDown);										// move to the take position
		// Close the gripper here
		SetM(32);													// Scene - remove product from belt
		WaitTime(0.04);												// Wait until gripper closes
		MoveLR(SynchPosUp);											// move up to change position
		
		TrackStopR(FixedPlace, ParkPos, 50, 50);					// Move to the fixed place Position
		ConditionalStop(123);										// Stop movement if place position is not valid
		Relative();													// use relative positions
		MoveLR(StaticMoveDown);										// move to the take position
		WaitEndMove();												// wait to go on with interpreter here
		SetM(16);													// open the gripper here
		WaitTime(0.04);												// Wait until gripper opens
		MoveLR(StaticMoveUp);										// move to the take position
		Absolute();
		
		IF NOT TrackingFrameSelect(FrameIn,'Infeed') THEN			// Need to stop, no objects left
			MoveLR(ParkPos);										// move to static park position										
			WaitEndMove();											// sync interpreter and program 
			WaitUntil(TrackingFrameSelect(FrameIn,'Infeed'));		// hold interpreter until a new frame is available 
		END_IF
		
	UNTIL FALSE END_REPEAT;
	
END_PROGRAM 