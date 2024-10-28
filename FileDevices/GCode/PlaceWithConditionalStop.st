#include 'ProdDetails.typ'

////////////////////////////////////////////////////////////////////////////////////
// INPUT Variables - configured as Program Elements of the interpreter
	// NextTrackingObjectIn : UDINT;							 Pointer to next object (GCS)

// OUTPUT Variables - configured as Program Elements of the interpreter
	// MaxPickPosIn : LREAL;								 	Maximum Position where robot is able to grab something (BCS)
	// MinPickPosIn : LREAL;								 	Minimum Position where objects are given to the robot (BCS)


VAR CONSTANT
	UpperZLevel : LREAL := 100.0;	// Gripper up position
	LowerZLevel : LREAL := 0.0;		// Gripper down position
	YProductPos : LREAL := 200;		// position in y coordinate where the product should be placed
END_VAR


VAR	
	ActObj : REFERENCE TO ProductDetailsType;
	ParkPos				: McPointType := (Pos:=(X:=	  0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosUp			: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= UpperZLevel));
	SynchPosDown		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= LowerZLevel));
	StaticMoveDown		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= -100));
	StaticMoveUp		: McPointType := (Pos:=(X:=   0, Y:= 0, 			Z:= 100));
	MoveToPark : BOOL 	:= FALSE;
END_VAR


PROGRAM _MAIN
	
	// Position init, reset frame in case of restart
	SetPCS(MachineFrame);
	MoveLR(ParkPos);
	
	// Set the manipulation area of the Robot
	MaxPickPosIn := 1400;
	MinPickPosIn := 200;
	
	REPEAT		
		IF NextTrackingObjectIn <> 0 THEN
			MoveToPark := FALSE;
			
			ActObj ACCESS NextTrackingObjectIn;							// select the product
			TrackObjectR(ActObj.TrackingFrameID, SynchPosUp, 50, 50);	// track on product
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
			
			IF NextTrackingObjectIn = 0 THEN							// Need to stop, no objects left
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