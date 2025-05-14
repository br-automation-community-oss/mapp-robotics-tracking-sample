
ACTION DefineLinks: 
	LinkTrackingPath := ADR(gTrackingPathConveyor_1);
	LinkAxis := ADR(gAxis_Conveyor_1);
	Period := 100000.0;
	
	Reset ACCESS ADR(ControlPanel.Input.Reset);
	Start ACCESS ADR(ControlPanel.Input.StartMultipick);
	yRange := 0;
	
	IF ControlPanel.Input.StartMultipick THEN
		yRange := 160;
	END_IF
	
	IF ControlPanel.Input.StartPickNPlace THEN
		Start ACCESS ADR(ControlPanel.Input.StartPickNPlace);
	END_IF
				
	IF ControlPanel.Input.StartPlaceWithConditionalStop THEN
		Start ACCESS ADR(ControlPanel.Input.StartPlaceWithConditionalStop);
	END_IF
				
	IF ControlPanel.Input.StartPrePalletizing THEN
		Start ACCESS ADR(ControlPanel.Input.StartPrePalletizing);
	END_IF
					
	IF ControlPanel.Input.StartSorting THEN
		Start ACCESS ADR(ControlPanel.Input.StartSorting);
	END_IF
	
END_ACTION
