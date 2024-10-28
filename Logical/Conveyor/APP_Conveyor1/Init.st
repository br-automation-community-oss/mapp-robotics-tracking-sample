PROGRAM _INIT
	
	DefineLinks;
	
	// Configure Frame Buffer, to get actual pointer to Products --> Check state of Products
	MC_BR_TrackingPathGetFrames_0.Parameters.CoordSystem := mcACS;
	MC_BR_TrackingPathGetFrames_0.Parameters.DataAddress := ADR(Products);
	MC_BR_TrackingPathGetFrames_0.Parameters.GetMode	:= mcTRKPATH_GET_MOD_ALL_FRAMES;
	MC_BR_TrackingPathGetFrames_0.Parameters.InfoMode	:= mcTRKPATH_INFO_MOD_ALL;
	MC_BR_TrackingPathGetFrames_0.Parameters.NumberOfFrames := MAX_TRACKING_FRAMES;
	MC_BR_TrackingPathGetFrames_0.Parameters.TrackingFrameID := 0;
	
	// Set Default Parameters of the Tracking Frames
	MC_BR_TrackingFrameCreate_0.Parameters.Attribute	:= 0;
	MC_BR_TrackingFrameCreate_0.Parameters.Translation.X := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Translation.Y := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Translation.Z := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Angle1 := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Angle2 := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Angle3 := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Type := 0;
	
	// Belt Position of fixed tracking frame
	ParkPosition := 0;
	
END_PROGRAM