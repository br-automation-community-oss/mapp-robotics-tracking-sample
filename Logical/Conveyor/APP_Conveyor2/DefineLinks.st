
ACTION DefineLinks: 
	LinkTrackingPath := ADR(gTrackingPathConveyor_2);
	LinkAxis := ADR(gAxis_Conveyor_2);
	
	Reset ACCESS ADR(ControlPanel.Input.Reset);
	Start ACCESS ADR(ControlPanel.Input.StartMultipick);
	yRange := 0;
				
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
