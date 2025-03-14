
TYPE
	ControlPanelInputs : 	STRUCT  (*Command Buttons*)
		StartSorting : BOOL; (*Run a sorting program*)
		StartPrePalletizing : BOOL; (*Run a pre palleticing application demo*)
		StartPickNPlace : BOOL; (*Run a pick and place application demo*)
		StartPlaceWithConditionalStop : BOOL; (*Rund a place position with conditional stop*)
		StartMultipick : BOOL; (*Rund a multipick application demo*)
		Reset : BOOL; (*Reset Error states*)
		VelocityProduction : REAL; (*Velocity for production [ppm]*)
		ProductGap : REAL; (*Length of the product [mm]*)
		RandomMax : REAL;
		RandomMin : REAL;
		DeletePosition : REAL; (*Position where objects are deleted*)
	END_STRUCT;
	ControlPanelType : 	STRUCT  (*Control Panel*)
		Input : ControlPanelInputs; (*Buttons *)
	END_STRUCT;
END_TYPE

(*Device Interface*)
(*
Enumerators for State Machnie (used at Conveyor and Robot)*)

TYPE
	DeviceStatesListEnum : 
		( (*State of the robot / axis*)
		STATE_WAIT, (*Standby*)
		STATE_INIT, (*Initialization*)
		STATE_PRODUCTION, (*Production*)
		STATE_ERROR, (*Emenrgency*)
		STATE_RESET (*Reset*)
		);
END_TYPE

(*
Product positions for SceneViewer*)

TYPE
	ProdPosType : 	STRUCT  (*Visu position for Scene Viewer*)
		Manipulated : BOOL; (*Display object if manipulated*)
		Valid : BOOL; (*Display object*)
		PositionX : REAL; (*Pos X*)
		PositionY : REAL; (*Pos Y*)
		PositionZ : REAL; (*Pos Z*)
		Material : UDINT; (*Material Color to show Tracking*)
	END_STRUCT;
END_TYPE
