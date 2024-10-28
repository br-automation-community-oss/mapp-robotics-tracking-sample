ACTION updateProductData:

	FOR i:=0 TO MAX_TRACKING_FRAMES DO
		IF (Products[i].TrackingFrameID <> 0 AND Products[i].Attribute <> 0) THEN
			ProdDetails ACCESS Products[i].Attribute;
			brsmemcpy(ADR(ProdDetails.Pos), ADR(Products[i].CurrentPosition), SIZEOF(McPosType));
			ProdDetails.This := ADR(ProdDetails);
			ProdDetails.TrackingFrameID := Products[i].TrackingFrameID;
		END_IF			
	END_FOR
	
END_ACTION	

ACTION deleteOutOfScopeProducts:

	FOR i:=0 TO MAX_TRACKING_FRAMES DO
		IF Products[i].Distance >= ControlPanel.Input.DeletePosition THEN // todo: distance as a constant!
			IF (Products[i].Attribute <> 0) THEN
				brsmemset(Products[i].Attribute, 0, SIZEOF(ProductDetailsType));
			END_IF
			MC_BR_TrackingFrameDelete_0.Mode := mcTRKFRM_DELETE_MOD_FRAME;
			MC_BR_TrackingFrameDelete_0.TrackingFrameID	:= Products[i].TrackingFrameID;
			MC_BR_TrackingFrameDelete_0.Execute	:= TRUE;
			EXIT;
		END_IF
	END_FOR
	
END_ACTION	

ACTION addNewObjects:
	
	IF ControlPanel.Input.StartMultipick THEN
		IF createCnt > 1 THEN
			createCnt := 0;
			LastProductPosition := MpAxConveyor.Position;
			RETURN;
		END_IF

		MC_BR_TrackingFrameCreate_0.Parameters.Translation.Y := 80 - UDINT_TO_LREAL(createCnt) * 160;
		createCnt := createCnt + 1;
	ELSE
		LastProductPosition := MpAxConveyor.Position;
		MC_BR_TrackingFrameCreate_0.Parameters.Translation.Y := 0;
		createCnt := 0;
	END_IF;
	
	// Add attributes memory
	FOR i := 0 TO MAX_TRACKING_FRAMES DO
		IF ProductDetails[i].TrackingFrameID = 0 THEN
			brsmemset(ADR(ProductDetails[i]), 0, SIZEOF(ProductDetailsType));
			MC_BR_TrackingFrameCreate_0.Parameters.Attribute := ADR(ProductDetails[i]);
			
			// Change the color by random timestamp		
			IF ControlPanel.Input.StartSorting AND (TIM_ticks() MOD 2) = 1 THEN
				ProductDetails[i].ObjectType := 1;
			END_IF	
			
			EXIT;
		END_IF
	END_FOR
	
	// Add frame in the buffer
	MC_BR_TrackingFrameCreate_0.Parameters.LatchedPath.Position := MpAxConveyor.Position;
	MC_BR_TrackingFrameCreate_0.Execute	:= TRUE;
	
END_ACTION
	
ACTION updateSceneViewerPositions:
	
	FOR i:= 0 TO MAX_TRACKING_FRAMES DO
		
		IF Products[i].Attribute <> 0 THEN
			ProdDetails ACCESS Products[i].Attribute;
			ProductsPosition[i].PositionX := LREAL_TO_REAL(Products[i].CurrentPosition.X + ProdDetails.IncrementPos.X);
			ProductsPosition[i].PositionY := LREAL_TO_REAL(Products[i].CurrentPosition.Y + ProdDetails.IncrementPos.Y) ;
			ProductsPosition[i].PositionZ := LREAL_TO_REAL(Products[i].CurrentPosition.Z + ProdDetails.IncrementPos.Z) ;
			IF ProdDetails.InTracking THEN
				ProductsPosition[i].Material := 4; //yellow
			ELSIF ProdDetails.ObjectType = 1 THEN
				ProductsPosition[i].Material := 2; //blue
			ELSE
				ProductsPosition[i].Material := 1; //red
			END_IF
			ProductsPosition[i].Valid := ProdDetails.Robot <> DEV_Removed;
			ProductsPosition[i].Manipulated := ProdDetails.Robot = DEV_Robot;
		ELSE
			ProductsPosition[i].PositionX := LREAL_TO_REAL(Products[i].CurrentPosition.X);
			ProductsPosition[i].PositionY := LREAL_TO_REAL(Products[i].CurrentPosition.Y);
			ProductsPosition[i].PositionZ := LREAL_TO_REAL(Products[i].CurrentPosition.Z);
			ProductsPosition[i].Material := 1;
			ProductsPosition[i].Valid := Products[i].TrackingFrameID <> 0;
			ProductsPosition[i].Manipulated := FALSE;
		END_IF
	END_FOR
	
END_ACTION

ACTION resetFUBs:
	
		IF (MpAxConveyor.Update AND MpAxConveyor.UpdateDone) OR MpAxConveyor.Error THEN
			MpAxConveyor.Update	:= FALSE;
		END_IF
	
		IF (NOT(MpAxConveyor.MoveActive) AND NOT(MpAxConveyor.CommandBusy)) OR MpAxConveyor.Error THEN
			MpAxConveyor.MoveVelocity := FALSE;
			MpAxConveyor.Update := FALSE;
		END_IF	
	
		IF MpAxConveyor.ErrorReset AND NOT(MpAxConveyor.Error) THEN
			MpAxConveyor.ErrorReset := FALSE;
		END_IF
	
		IF (MpAxConveyor.Home AND MpAxConveyor.IsHomed) OR MpAxConveyor.Error THEN
			MpAxConveyor.Home := FALSE;
		END_IF
	
		IF MC_BR_TrackingFrameCreate_0.Done OR MC_BR_TrackingFrameCreate_0.Error THEN
			MC_BR_TrackingFrameCreate_0.Execute	:= FALSE;
		END_IF
			
		IF MC_BR_TrackingFrameDelete_0.Done OR MC_BR_TrackingFrameDelete_0.Error THEN
			MC_BR_TrackingFrameDelete_0.Execute := FALSE;
		END_IF
	
END_ACTION