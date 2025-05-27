
ACTION DefineLinks: 
	LinkTrackingPath := ADR(gTrackingPathConveyor_2);
	LinkAxis := ADR(gAxis_Conveyor_2);
	Period := 100000.0;
	
	Reset := ControlPanel.Input.Reset;
	Start :=
		(ControlPanel.Input.StartMultipick OR 
		ControlPanel.Input.StartPickNPlace OR 
		ControlPanel.Input.StartPlaceWithConditionalStop OR 
		ControlPanel.Input.StartPrePalletizing OR 
		ControlPanel.Input.StartSorting OR
		ControlPanel.Input.StartMultipickRandom);
	
	Multipick := ControlPanel.Input.StartMultipick;
	ProductGap := ControlPanel.Input.ProductGap;
	SetVelocity := ControlPanel.Input.VelocityProduction;
	RandomCreation := ControlPanel.Input.StartMultipickRandom;
	
END_ACTION
