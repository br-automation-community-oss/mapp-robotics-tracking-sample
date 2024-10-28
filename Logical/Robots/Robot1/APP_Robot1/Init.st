PROGRAM _INIT
	
	// This action defines the links to the conveyeor and the robot
	DefineLinks;
	
	MpDelta4Axis_X.Override					:= 100;
	MpDelta4AxisPar_X.ProgramName			:= '';
	
	// M-Functions triggered in Interpreter Program
	M8;
	M16;
	
	MC_BR_TrackingPathGetFrames_In.Parameters.CoordSystem		:= mcACS;
	MC_BR_TrackingPathGetFrames_In.Parameters.DataAddress 		:= ADR(ProductsIn);
	MC_BR_TrackingPathGetFrames_In.Parameters.GetMode			:= mcTRKPATH_GET_MOD_ALL_FRAMES;
	MC_BR_TrackingPathGetFrames_In.Parameters.InfoMode			:= mcTRKPATH_INFO_MOD_ALL;
	MC_BR_TrackingPathGetFrames_In.Parameters.NumberOfFrames 	:= SIZEOF(ProductsIn)/SIZEOF(McTrkFrmInfoType);
	MC_BR_TrackingPathGetFrames_In.Parameters.TrackingFrameID 	:= 0;
	
		
	MC_BR_TrackingPathGetFrames_Out.Parameters.CoordSystem		:= mcACS;
	MC_BR_TrackingPathGetFrames_Out.Parameters.DataAddress 		:= ADR(ProductsOut);
	MC_BR_TrackingPathGetFrames_Out.Parameters.GetMode			:= mcTRKPATH_GET_MOD_ALL_FRAMES;
	MC_BR_TrackingPathGetFrames_Out.Parameters.InfoMode			:= mcTRKPATH_INFO_MOD_ALL;
	MC_BR_TrackingPathGetFrames_Out.Parameters.NumberOfFrames 	:= SIZEOF(ProductsOut)/SIZEOF(McTrkFrmInfoType);
	MC_BR_TrackingPathGetFrames_Out.Parameters.TrackingFrameID 	:= 0;
	
	MC_BR_TrackingStatus_PathGen_0.Enable := TRUE;
	
	MC_BR_ConditionalStop_0.Enable := TRUE;
	MC_BR_ConditionalStop_0.Identifier := 123;
	MC_BR_ConditionalStop_0.Deactivate := TRUE;
	MC_BR_ConditionalStop_0.Reactivate := FALSE;
	
	
	MC_BR_PathInfo_0.Enable := TRUE;
	
END_PROGRAM