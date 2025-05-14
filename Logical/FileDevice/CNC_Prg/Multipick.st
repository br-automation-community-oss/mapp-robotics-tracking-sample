VAR CONSTANT
	UpperZLevel : LREAL := 100.0;	// Gripper up position
	LowerZLevel : LREAL := 0.0;		// Gripper down position
	YProductPos : LREAL := 200;		// position in y coordinate where the product should be placed
END_VAR

VAR	
	ParkPos				: McPointType := (Pos:=(X:=	  0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosUp1			: McPointType := (Pos:=(X:=   -100, Y:= 0, 			Z:= UpperZLevel));
	SynchPosUp2			: McPointType := (Pos:=(X:=   100, Y:= 0, 			Z:= UpperZLevel));
	SynchPosDown1		: McPointType := (Pos:=(X:=   -100, Y:= 0, 			Z:= LowerZLevel));
	SynchPosDown2		: McPointType := (Pos:=(X:=   100, Y:= 0, 			Z:= LowerZLevel));
	StaticMoveDown		: McPointType := (Pos:=(X:=	  0, Y:= 0, 			Z:= 0));
	MoveToPark : BOOL 	:= FALSE;
		
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
			
		TrackObjectR(FrameIn, SynchPosUp2, 50, 50);						// track on product
		MoveLR(SynchPosDown2);											// move to the take position
		SetM(34);														// Scene - remove product from belt, Close the gripper here
		WaitTime(0.04);													// Wait cause delay of gripper
		WaitALAP();
		MoveLR(SynchPosUp2);											// move up to change position
		
		IF TrackingFrameSelect(FrameIn,'Infeed') THEN
			TrackObjectR(FrameIn, SynchPosUp1, 50, 50);	// track on product
			MoveLR(SynchPosDown1);										// move to the take position
			SetM(33);													// Scene - remove product from belt, Close the gripper here
			WaitTime(0.04);												// Wait cause delay of gripper
			MoveLR(SynchPosUp1);										// move up to change position
		END_IF
		
		TrackStopR(FixedPlace, ParkPos, 50, 50);						// Move to the fixed place Position
		MoveLR(StaticMoveDown);											// move to the take position
		SetM(16);														// open the gripper here
		SetM(17);														// open the gripper here
		WaitTime(0.04);													// Wait cause delay of gripper
		MoveLR(ParkPos);												// move to the take position
		WaitALAP();
		
		IF NOT TrackingFrameSelect(FrameIn,'Infeed') THEN				// Need to stop, no objects left
			MoveToPark := TRUE;											// force park position
		END_IF
			
		IF MoveToPark THEN
			MoveLR(ParkPos);											// move to static park position										
			WaitEndMove();												// sync interpreter and program 
			WaitUntil(TrackingFrameSelect(FrameIn,'Infeed'));			// select new product
		END_IF
		
	UNTIL FALSE END_REPEAT;
	
END_PROGRAM 