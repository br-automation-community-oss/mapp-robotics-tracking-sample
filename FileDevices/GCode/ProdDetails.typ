
TYPE
	ProductDetailsType : 	STRUCT  (*Additional data added as attributes to every tracking object*)
		This : UDINT; (*Adress to the memory - debugging*)
		GripperClosed : BOOL; (*Gripper is close, product in manipulation*)
		TrackingFrameID : UDINT; (*tracking frame id*)
		PickPosDelta : McPosType;
		PickPos : McPosType; (*position where gripper has been closed*)
		IncrementPos : McPosType; (*change in position on frame*)
		Pos : McPosType; (*Actual Position of object*)
		ObjectType : USINT; (*Classification of the object (red / blue)*)
		InTracking : BOOL; (*Object is now active in Tracking*)
		Robot : DevicesListEnum; (*type of robot manipulated the object*)
	END_STRUCT;
	DevicesListEnum : 
		( (*device definition of manipulating robots and axis*)
		DEV_Conveyor := 0, (*object id for conveyor*)
		DEV_Robot := 1, (*id for robot 1*)
		DEV_Removed := 2 (*marked as removed and do not show in scene*)
		);
END_TYPE
