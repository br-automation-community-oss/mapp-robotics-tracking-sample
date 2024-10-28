ACTION DefineLinks:

	// Define Links to the axes of the Robot
	AxQ1 := ADR(gAxisQ1_D4r1100_1);
	AxQ2 := ADR(gAxisQ2_D4r1100_1);
	AxQ3 := ADR(gAxisQ3_D4r1100_1);
	
	// Define Link to the Robot & Conveyor
	MpDeltaName	:= 'gAxesGroup_D4r1100_1';
	MpLinkDelta	:= ADR(gAxesGroup_D4r1100_1);
	LinkConveyorIn := ADR(gTrackingPathConveyor_1);
	LinkConveyorOut := ADR(gTrackingPathConveyor_2);
		
END_ACTION
