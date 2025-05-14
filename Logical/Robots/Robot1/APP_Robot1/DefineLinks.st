ACTION DefineLinks:

	// Define Link to the Robot & Conveyor
	NameAxesGroup	:= 'gAxesGroup_D4r1100_1';
	LinkAxesGroup	:= ADR(gAxesGroup_D4r1100_1);
	
	LinkTrackingPath := ADR(gTrackingPathConveyor_1);
	NameTrackingPath := 'gTrackingPathConveyor_1';
	LinkAxisTrackingPath := ADR(gAxis_Conveyor_1);
	
	
	Reset ACCESS ADR(ControlPanel.Input.Reset);
	Start ACCESS ADR(ControlPanel.Input.StartMultipick);
	MC_BR_MoveProgram_X.Name := 'Multipick.st';
	
	IF ControlPanel.Input.StartPickNPlace THEN
		MC_BR_MoveProgram_X.Name := 'PickNPlace.st';
		Start ACCESS ADR(ControlPanel.Input.StartPickNPlace);
	END_IF
				
	IF ControlPanel.Input.StartPlaceWithConditionalStop THEN
		MC_BR_MoveProgram_X.Name := 'PlaceWithConditionalStop.st';
		Start ACCESS ADR(ControlPanel.Input.StartPlaceWithConditionalStop);
	END_IF
				
	IF ControlPanel.Input.StartPrePalletizing THEN
		MC_BR_MoveProgram_X.Name := 'PrePalletizing.st';
		Start ACCESS ADR(ControlPanel.Input.StartPrePalletizing);
	END_IF
					
	IF ControlPanel.Input.StartSorting THEN
		MC_BR_MoveProgram_X.Name := 'Sorting.st';
		Start ACCESS ADR(ControlPanel.Input.StartSorting);
	END_IF

END_ACTION