PROGRAM _INIT
	
	DefineLinks;
	
	// Set Default Parameters of the Tracking Frames
	MC_BR_TrackingFrameCreate_0.Parameters.Attribute	:= 0;
	MC_BR_TrackingFrameCreate_0.Parameters.Translation.X := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Translation.Y := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Translation.Z := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Angle1 := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Angle2 := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Angle3 := 0.0;
	MC_BR_TrackingFrameCreate_0.Parameters.Orientation.Type := 0;
	
	MC_BR_TrackingFrameDelete_0.Mode :=  mcTRKFRM_DELETE_MOD_ALL;

END_PROGRAM