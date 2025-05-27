VAR CONSTANT
	UpperZLevel : LREAL := 100.0;	// Gripper up position
	LowerZLevel : LREAL := 0.0;		// Gripper down position
	YProductPos : LREAL := 200;		// position in y coordinate where the product should be placed
END_VAR

VAR	
	ParkPos				: McPointType := (Pos:=(X:=-100, Y:=100, 			Z:= UpperZLevel));
	SynchPosUp			: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosDown		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= LowerZLevel));
	SynchPosForward		: McPointType := (Pos:=(X:= 100, Y:= 0, 			Z:= LowerZLevel));
	SynchPosSideward	: McPointType := (Pos:=(X:= 100, Y:= 100, 			Z:= LowerZLevel));
	SynchPosUpSideward	: McPointType := (Pos:=(X:= 100, Y:= 100, 			Z:= UpperZLevel));
		
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
		// close the gripper here
		SetM(32);													// Scene - start moving the poduct on the belt
		WaitTime(0.04);												// Wait cause delay of gripper
		WaitALAP();
		TrackingFrameSetAttribute(FrameIn, 0);						// Hide Object
		
		Feedrate(15000);											// manipulate with reduced feedrate
		MoveL(SynchPosForward);										// move forward on belt
		MoveL(SynchPosSideward);									// move sideward on belt
		
		SetM(16);													// open the gripper here
		SetM(40);													// Scene - end of moving the product
		WaitTime(0.04);												// Wait cause delay of gripper
		WaitALAP();													// hold interpreter 
		MoveLR(SynchPosUpSideward);									// move up to change frame
		
		IF NOT TrackingFrameSelect(FrameIn,'Infeed') THEN			// Need to stop, no objects left
			TrackStopR(MachineFrame, ParkPos, 50, 50);				// Move to a static frame							
			WaitEndMove();											// sync interpreter and program 
			WaitUntil(TrackingFrameSelect(FrameIn,'Infeed'));		// hold interpreter until a new frame is available 
		END_IF
		
	UNTIL FALSE END_REPEAT;
	
END_PROGRAM 