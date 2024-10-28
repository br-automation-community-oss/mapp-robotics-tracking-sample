#include 'ProdDetails.typ'

////////////////////////////////////////////////////////////////////////////////////
// INPUT Variables - configured as Program Elements of the interpreter
	// NextTrackingObjectIn : UDINT;							 Pointer to next object (GCS)
	// NextTrackingObjectOut : UDINT;							 Pointer to next object (GCS)

// OUTPUT Variables - configured as Program Elements of the interpreter
	// MaxPickPosIn : LREAL;								 	Maximum Position where robot is able to grab something (BCS)
	// MinPickPosIn : LREAL;								 	Minimum Position where objects are given to the robot (BCS)
	// MaxPickPosOut : LREAL;								 	Maximum Position where robot is able to place something (BCS)
	// MinPickPosOut : LREAL;								 	Minimum Position where objects are placed by the robot (BCS)


VAR CONSTANT
	UpperZLevel : LREAL := 100.0;	// Gripper up position
	LowerZLevel : LREAL := 0.0;		// Gripper down position
	YProductPos : LREAL := 200;		// position in y coordinate where the product should be placed
END_VAR


VAR	
	ActObj : REFERENCE TO ProductDetailsType;
	ParkPos				: McPointType := (Pos:=(X:=-100, Y:=100, 			Z:= UpperZLevel));
	SynchPosUp			: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosDown		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= LowerZLevel));
	MoveToPark : BOOL := FALSE;
END_VAR


PROGRAM _MAIN
	
	// Position init, reset frame in case of restart
	SetPCS(MachineFrame);
	MoveLR(ParkPos);
	
	// Set the manipulation area of the Robot
	MaxPickPosIn := 1400;
	MinPickPosIn := 400;
	MaxPickPosOut := 1700;
	MinPickPosOut := 700;
	
	REPEAT		
		IF NextTrackingObjectIn <> 0 THEN
			MoveToPark := FALSE;
			
			ActObj ACCESS NextTrackingObjectIn;							// select the product
			TrackObjectR(ActObj.TrackingFrameID, SynchPosUp, 50, 50);	// track on product
			MoveLR(SynchPosDown);										// move to the take position
			WaitALAP();													// hold interpreter
			SetM(32);													// Scene - remove product from belt, close gripper
			WaitTime(0.04);												// Wait cause delay of gripper
			
			MoveLR(SynchPosUp);											// move up to change frame
			WaitUntil(NextTrackingObjectOut <> 0);						// hold interpeter until place frame has been selected
			ActObj ACCESS NextTrackingObjectOut;						// change memory reference
			TrackObjectR(ActObj.TrackingFrameID, SynchPosUp, 50, 50);	// move to place position
			MoveLR(SynchPosDown);										// move down on place position
			WaitALAP();													// hold interpreter 
			SetM(16);													// Scene - place product on belt, open gripper
			WaitTime(0.04);												// Wait cause delay of gripper
			
			MoveLR(SynchPosUp);											// move up to change frame
			IF NextTrackingObjectIn = 0 THEN							// Need to stop, no objects left
				TrackStopR(MachineFrame, ParkPos, 50, 50);				// Move to a static frame
				MoveToPark := TRUE;										// force park position
			END_IF
				
		ELSE
			MoveToPark := TRUE;											// force park position, there is nothing to take
		END_IF
		
		IF MoveToPark THEN
			MoveLR(ParkPos);											// move to static park position										
			WaitEndMove();												// sync interpreter and program 
			WaitIp();													// hold interpreter until a new frame is available 
		END_IF
		
	UNTIL FALSE END_REPEAT;
	
END_PROGRAM 