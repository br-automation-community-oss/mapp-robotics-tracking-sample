#include 'ProdDetails.typ'

////////////////////////////////////////////////////////////////////////////////////
// INPUT Variables - configured as Program Elements of the interpreter
	// NextTrackingObjectIn : UDINT;							 Pointer to next object (GCS)

// OUTPUT Variables - configured as Program Elements of the interpreter
	// MaxPickPosIn : LREAL;								 	Maximum Position where robot is able to grab something (BCS)
	// MinPickPosIn : LREAL;								 	Minimum Position where objects are given to the robot (BCS)


VAR CONSTANT
	UpperZLevel : LREAL := 150.0;	// Gripper up position
	LowerZLevel : LREAL := 0.0;		// Gripper down position
	YProductPos : LREAL := 200;		// position in y coordinate where the product should be placed
	
	xStep : LREAL := 0.0;					// step size to get a tangential step for tracking
	yStep : LREAL := 0.1;					// step size to get a tangential step for tracking
	
END_VAR


VAR	
	ActObj : REFERENCE TO ProductDetailsType;
	ParkPos						: McPointType := (Pos:=(X:=-350, 		Y:=-200, 			Z:= UpperZLevel));
	
	PreSynchPosUp				: McPointType := (Pos:=(X:=   0+xStep, 	Y:= 0+yStep, 		Z:= UpperZLevel));
	SynchPosUp					: McPointType := (Pos:=(X:=   0, 		Y:= 0, 				Z:= UpperZLevel));
	SynchPosDown				: McPointType := (Pos:=(X:=   0, 		Y:= 0, 				Z:= LowerZLevel));
	SynchPosForward				: McPointType := (Pos:=(X:= 100, 		Y:= 0, 				Z:= LowerZLevel));
	SynchPosSideward			: McPointType := (Pos:=(X:= 100, 		Y:= 100, 			Z:= LowerZLevel));
	SynchPosUpSideward			: McPointType := (Pos:=(X:= 100, 		Y:= 100, 			Z:= UpperZLevel));
	PostSynchPosUpSideward		: McPointType := (Pos:=(X:= 100-xStep, 	Y:=100-yStep,		Z:= UpperZLevel));
	
	MoveToPark : BOOL := FALSE;
	r1 : LREAL := 20.0;
END_VAR

// The radius is calculate by the half distance between two points this gives the result of a smooth interpolation
FUNCTION getRadius : LREAL
	VAR_INPUT 
		posA : LREAL;
	END_VAR
	getRadius := MAX(20.0, ABS(posA) / 2.0);
END_FUNCTION



PROGRAM _MAIN
	
	EVAL('SERVICE_DATA["EXTENDED_TFA OFF"]', LANGUAGE_BR_GCODE);
	
	// Position init, reset frame in case of restart
	SetPCS(MachineFrame);
	MoveLR(ParkPos);
	
	// Set the manipulation area of the Robot
	MaxPickPosIn := 1400;
	MinPickPosIn := 1100;
	
	REPEAT		
		IF NextTrackingObjectIn <> 0 THEN
			MoveToPark := FALSE;
			ActObj ACCESS NextTrackingObjectIn;							// select the product
			
			Feedrate(50000);
			r1 := getRadius(ActObj.Pos.Y);
			
			PreSynchPosUp := SynchPosUp;
			PostSynchPosUpSideward := SynchPosUpSideward;
			IF ActObj.Pos.Y > 0 THEN
				PreSynchPosUp.Pos.Y := PreSynchPosUp.Pos.Y - yStep;
				PostSynchPosUpSideward.Pos.Y := PostSynchPosUpSideward.Pos.Y - yStep;
			ELSE
				PreSynchPosUp.Pos.Y := PreSynchPosUp.Pos.Y + yStep;
				PostSynchPosUpSideward.Pos.Y := PostSynchPosUpSideward.Pos.Y + yStep;
			END_IF
			
			TrackObjectR(ActObj.TrackingFrameID, PreSynchPosUp, r1, r1);	// track on product
			MoveL(SynchPosUp);
			MoveLR(SynchPosDown);										// move to the take position
			
			SetM(8);													// Scene - start moving the poduct on the belt
			WaitTime(0.04);												// Wait cause delay of gripper
			Feedrate(15000);											// manipulate with reduced feedrate
			MoveL(SynchPosForward);										// move forward on belt
			MoveL(SynchPosSideward);									// move sideward on belt
			
			WaitALAP();													// hold interpreter 
			// open the gripper here
			SetM(16);													// Scene - end of moving the product
			WaitTime(0.04);												// Wait cause delay of gripper
			MoveLR(SynchPosUpSideward);									// move up to change frame
			MoveLR(PostSynchPosUpSideward);									// move up to change frame
			
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