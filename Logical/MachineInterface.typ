
TYPE
	ControlPanelInputs : 	STRUCT  (*Command Buttons*)
		StartSorting : BOOL; (*Run a sorting program*)
		StartPrePalletizing : BOOL; (*Run a pre palleticing application demo*)
		StartPickNPlace : BOOL; (*Run a pick and place application demo*)
		StartPlaceWithConditionalStop : BOOL; (*Rund a place position with conditional stop*)
		StartMultipick : BOOL; (*Rund a multipick application demo*)
		Reset : BOOL; (*Stop Execute*)
		VelocityProduction : REAL; (*Velocity for production [ppm]*)
		ProductGap : REAL; (*Length of the product [mm]*)
		DeletePosition : REAL; (*Position where objects are deleted*)
	END_STRUCT;
	ControlPanelType : 	STRUCT  (*Control Panel*)
		Input : ControlPanelInputs; (*Buttons *)
	END_STRUCT;
END_TYPE
