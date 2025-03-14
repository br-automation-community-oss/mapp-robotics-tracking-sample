TYPE
	McPIAGLPDFLGCBREnum :
		( (*G-Code B&R selector setting*)
		mcPIAGLPDFLGCBR_ACT := 0, (*Active - Language in use*)
		mcPIAGLPDFLGCBR_INACT := 1 (*Inactive - Language not in use*)
		);
	McPIAGLADefADefEnum :
		( (*AIL definitions 1-N selector setting*)
		mcPIAGLADAD_F_A := 0, (*File AIL - AIL language definition file*)
		mcPIAGLADAD_DAT_OBJ := 1 (*Data object - Data object*)
		);
	McPIAGLADefADefFAType : STRUCT (*Type mcPIAGLADAD_F_A settings*)
		FileName : McCfgUnboundedArrayType; (*Name of language definition file*)
		FileDevice : STRING[250]; (*File device for language definition files*)
	END_STRUCT;
	McPIAGLADefADefDatObjType : STRUCT (*Type mcPIAGLADAD_DAT_OBJ settings*)
		Name : McCfgUnboundedArrayType; (*Name of data object*)
	END_STRUCT;
	McPIAGLADefADefType : STRUCT
		Type : McPIAGLADefADefEnum; (*AIL definitions 1-N selector setting*)
		FileAIL : McPIAGLADefADefFAType; (*Type mcPIAGLADAD_F_A settings*)
		DataObject : McPIAGLADefADefDatObjType; (*Type mcPIAGLADAD_DAT_OBJ settings*)
	END_STRUCT;
	McPIAGLADefType : STRUCT (*Interpreter language definition*)
		AILDefinitions : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGLPDFLGCBRActType : STRUCT (*Type mcPIAGLPDFLGCBR_ACT settings*)
		FileExtensions : STRING[250]; (*List of file extensions separated by semicolon*)
		AILDefinitions : McPIAGLADefType; (*Interpreter language definition*)
	END_STRUCT;
	McPIAGLPDFLGCBRType : STRUCT (*G-Code B&R programming language*)
		Type : McPIAGLPDFLGCBREnum; (*G-Code B&R selector setting*)
		Active : McPIAGLPDFLGCBRActType; (*Type mcPIAGLPDFLGCBR_ACT settings*)
	END_STRUCT;
	McPIAGLPDFLGCAlt1Enum :
		( (*G-Code Alternative-1 selector setting*)
		mcPIAGLPDFLGCA1_ACT := 0, (*Active - Language in use*)
		mcPIAGLPDFLGCA1_INACT := 1 (*Inactive - Language not in use*)
		);
	McPIAGLPDFLGCAlt1ActType : STRUCT (*Type mcPIAGLPDFLGCA1_ACT settings*)
		FileExtensions : STRING[250]; (*List of file extensions separated by semicolon*)
		AILDefinitions : McPIAGLADefType; (*Interpreter language definition*)
	END_STRUCT;
	McPIAGLPDFLGCAlt1Type : STRUCT (*G-Code Alternative-1 programming language*)
		Type : McPIAGLPDFLGCAlt1Enum; (*G-Code Alternative-1 selector setting*)
		Active : McPIAGLPDFLGCAlt1ActType; (*Type mcPIAGLPDFLGCA1_ACT settings*)
	END_STRUCT;
	McPIAGLPDFLSTEnum :
		( (*Structured text selector setting*)
		mcPIAGLPDFLST_ACT := 0, (*Active - Language in use*)
		mcPIAGLPDFLST_INACT := 1 (*Inactive - Language not in use*)
		);
	McPIAGLPDFLSTActType : STRUCT (*Type mcPIAGLPDFLST_ACT settings*)
		FileExtensionsLocal : STRING[250]; (*List of file extensions separated by semicolon. Declarations are of local scope inside file with this extension.*)
		FileExtensionsGlobal : STRING[250]; (*List of default file extensions separated by semicolon. Declarations are of global (axis group) scope inside file with this extension.*)
		AILDefinitions : McPIAGLADefType; (*Interpreter language definition*)
	END_STRUCT;
	McPIAGLPDFLSTType : STRUCT (*Structured text programming language*)
		Type : McPIAGLPDFLSTEnum; (*Structured text selector setting*)
		Active : McPIAGLPDFLSTActType; (*Type mcPIAGLPDFLST_ACT settings*)
	END_STRUCT;
	McPIAGLPDFLMPLEnum :
		( (*Motion packet log selector setting*)
		mcPIAGLPDFLMPL_ACT := 0, (*Active - Language in use*)
		mcPIAGLPDFLMPL_INACT := 1 (*Inactive - Language not in use*)
		);
	McPIAGLPDFLMPLActType : STRUCT (*Type mcPIAGLPDFLMPL_ACT settings*)
		FileExtensions : STRING[250]; (*List of file extensions separated by semicolon*)
		AILDefinitions : McPIAGLADefType; (*Interpreter language definition*)
	END_STRUCT;
	McPIAGLPDFLMPLType : STRUCT (*Motion packet log programming language*)
		Type : McPIAGLPDFLMPLEnum; (*Motion packet log selector setting*)
		Active : McPIAGLPDFLMPLActType; (*Type mcPIAGLPDFLMPL_ACT settings*)
	END_STRUCT;
	McPIAGLPDFLType : STRUCT (*Predefined languages*)
		GCodeBR : McPIAGLPDFLGCBRType; (*G-Code B&R programming language*)
		GCodeAlternative1 : McPIAGLPDFLGCAlt1Type; (*G-Code Alternative-1 programming language*)
		StructuredText : McPIAGLPDFLSTType; (*Structured text programming language*)
		MotionPacketLog : McPIAGLPDFLMPLType; (*Motion packet log programming language*)
	END_STRUCT;
	McPIAGLCDFLCusLangType : STRUCT
		Name : STRING[250]; (*Language name*)
		AILDefinitions : McPIAGLADefType; (*Interpreter language definition*)
		FileExtensionsLocal : STRING[250]; (*List of file extensions separated by semicolon. Declarations are of local scope inside files with this extension.*)
		FileExtensionsGlobal : STRING[250]; (*List of file extensions separated by semicolon. Declarations are of global (axis group) scope inside files with this extension*)
	END_STRUCT;
	McPIAGLCDFLType : STRUCT
		CustomLanguage : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGLSCSenVarEnum :
		( (*Case sensitive variables selector setting*)
		mcPIAGLSCSV_NOT_USE := 0, (*Not used -*)
		mcPIAGLSCSV_USE := 1 (*Used -*)
		);
	McPIAGLSCSenVarType : STRUCT (*Case sensitivity for all interpreter and process variables*)
		Type : McPIAGLSCSenVarEnum; (*Case sensitive variables selector setting*)
	END_STRUCT;
	McPIAGLSType : STRUCT (*Settings that apply to all languages*)
		CaseSensitiveVariables : McPIAGLSCSenVarType; (*Case sensitivity for all interpreter and process variables*)
	END_STRUCT;
	McPIAGLType : STRUCT (*Languages*)
		PredefinedLanguages : McPIAGLPDFLType; (*Predefined languages*)
		CustomDefinedLanguages : McPIAGLCDFLType;
		Settings : McPIAGLSType; (*Settings that apply to all languages*)
	END_STRUCT;
	McPIAGPEARPVDefAcsEnum :
		( (*Default access selector setting*)
		mcPIAGPEARPVDA_READ_WRITE := 0, (*Read write - ReadWrite access*)
		mcPIAGPEARPVDA_READ_ONLY := 1, (*Read only - ReadOnly access*)
		mcPIAGPEARPVDA_NO_ACS := 2 (*No access - No access*)
		);
	McPIAGPEARPVDefAcsType : STRUCT (*Default access for all proccess variables*)
		Type : McPIAGPEARPVDefAcsEnum; (*Default access selector setting*)
	END_STRUCT;
	McPIAGPVRegExType : STRUCT (*Regular expressions for proccess variable names*)
		RegularExpression : McCfgUnboundedArrayType; (*Regular expression to match variable names*)
	END_STRUCT;
	McPIAGPEARPVAcsRstType : STRUCT (*Process variables with no access*)
		RegularExpressions : McPIAGPVRegExType; (*Regular expressions for proccess variable names*)
		ProcessVariableName : McCfgUnboundedArrayType; (*Name of process variable*)
	END_STRUCT;
	McPIAGPEARPVType : STRUCT (*Process variable access restrictions*)
		DefaultAccess : McPIAGPEARPVDefAcsType; (*Default access for all proccess variables*)
		NoAccess : McPIAGPEARPVAcsRstType; (*Process variables with no access*)
		ReadOnlyAccess : McPIAGPEARPVAcsRstType; (*Process variables with ReadOnly access*)
		ReadWriteAccess : McPIAGPEARPVAcsRstType; (*Process variables with ReadWrite access*)
	END_STRUCT;
	McPIAGPEARFFBDefExeEnum :
		( (*Default execution selector setting*)
		mcPIAGPEARFFBDE_EXE := 0, (*Executable - PLC implementation of function / function block executable*)
		mcPIAGPEARFFBDE_NOT_EXE := 1 (*Not executable - PLC implementation of function / function block not executable*)
		);
	McPIAGPEARFFBDefExeType : STRUCT (*Default*)
		Type : McPIAGPEARFFBDefExeEnum; (*Default execution selector setting*)
	END_STRUCT;
	McPIAGFFBRegExType : STRUCT (*Regular expressions for proccess function / function block names*)
		RegularExpression : McCfgUnboundedArrayType; (*Regular expression to match function / function block names*)
	END_STRUCT;
	McPIAGPEARFFBAcsRstType : STRUCT (*PLC implementation of function / function block can not be executed*)
		RegularExpressions : McPIAGFFBRegExType; (*Regular expressions for proccess function / function block names*)
		FunctionFunctionBlockName : McCfgUnboundedArrayType; (*Name of function / function block*)
	END_STRUCT;
	McPIAGPEARFFBType : STRUCT (*Function / function block access restrictions*)
		DefaultExecution : McPIAGPEARFFBDefExeType; (*Default*)
		NotExecutable : McPIAGPEARFFBAcsRstType; (*PLC implementation of function / function block can not be executed*)
		Executable : McPIAGPEARFFBAcsRstType; (*PLC implementation of function / function block can be executed*)
	END_STRUCT;
	McPIAGPEAcsRstIOsInEnum :
		( (*Mapping of Inputs*)
		mcPIAGPEARII_ALLOW := 0, (*Allow - Mapping of Input is allowed*)
		mcPIAGPEARII_NOT_ALLOW := 1 (*Not Allow - Mapping of Input is not allowed*)
		);
	McPIAGPEAcsRstIOsOutEnum :
		( (*Mapping of Outputs*)
		mcPIAGPEARIO_ALLOW := 0, (*Allow - Mapping of Output is allowed*)
		mcPIAGPEARIO_NOT_ALLOW := 1 (*Not Allow - Mapping of Output is not allowed*)
		);
	McPIAGPEAcsRstIOsType : STRUCT (*Restrictions of IOs mapping*)
		Inputs : McPIAGPEAcsRstIOsInEnum; (*Mapping of Inputs*)
		Outputs : McPIAGPEAcsRstIOsOutEnum; (*Mapping of Outputs*)
	END_STRUCT;
	McPIAGPEAcsRstType : STRUCT
		ProcessVariables : McPIAGPEARPVType; (*Process variable access restrictions*)
		FunctionsFunctionBlocks : McPIAGPEARFFBType; (*Function / function block access restrictions*)
		IOs : McPIAGPEAcsRstIOsType; (*Restrictions of IOs mapping*)
	END_STRUCT;
	McPIAGPEPVAdvSynEnum :
		( (*Synchronization selector setting*)
		mcPIAGPEPVAS_IPSYN := 0, (*Interpreter-synchronous - Interpreter-synchronous*)
		mcPIAGPEPVAS_PATHSYN := 1 (*Path-synchronous - Path-synchronous*)
		);
	McPIAGPEPVAdvSynType : STRUCT (*Synchronization*)
		Type : McPIAGPEPVAdvSynEnum; (*Synchronization selector setting*)
	END_STRUCT;
	McPIAGPEPVAdvRefEnum :
		( (*Reference selector setting*)
		mcPIAGPEPVAR_NO := 0, (*No -*)
		mcPIAGPEPVAR_YES := 1 (*Yes -*)
		);
	McPIAGPEPVAdvRefType : STRUCT (*Variable is a reference*)
		Type : McPIAGPEPVAdvRefEnum; (*Reference selector setting*)
	END_STRUCT;
	McPIAGPEPVAdvType : STRUCT
		Alias : STRING[250]; (*Alternative name of process variable*)
		Synchronization : McPIAGPEPVAdvSynType; (*Synchronization*)
		Reference : McPIAGPEPVAdvRefType; (*Variable is a reference*)
	END_STRUCT;
	McPIAGPEPVType : STRUCT
		ProcessVariableName : STRING[250]; (*Name of the process variable*)
		Advanced : McPIAGPEPVAdvType;
	END_STRUCT;
	McPIAGPEPVSType : STRUCT (*Declaration of process variables*)
		ProcessVariable : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGPEIVAdvArrDimType : STRUCT (*Array dimensions*)
		SizeOfArrayDimemsion : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGPEIVAdvSynEnum :
		( (*Synchronization selector setting*)
		mcPIAGPEIVAS_IPSYN := 0, (*Interpreter-synchronous - Interpreter-synchronous*)
		mcPIAGPEIVAS_PATHSYN := 1 (*Path-synchronous - Path-synchronous*)
		);
	McPIAGPEIVAdvSynType : STRUCT (*Synchronization*)
		Type : McPIAGPEIVAdvSynEnum; (*Synchronization selector setting*)
	END_STRUCT;
	McPIAGPEIVAdvConstEnum :
		( (*Constant selector setting*)
		mcPIAGPEIVAC_NO := 0, (*No -*)
		mcPIAGPEIVAC_YES := 1 (*Yes -*)
		);
	McPIAGPEIVAdvConstYesType : STRUCT (*Type mcPIAGPEIVAC_YES settings*)
		Value : STRING[250]; (*Value of the variable*)
	END_STRUCT;
	McPIAGPEIVAdvConstType : STRUCT (*Variable is a constant*)
		Type : McPIAGPEIVAdvConstEnum; (*Constant selector setting*)
		Yes : McPIAGPEIVAdvConstYesType; (*Type mcPIAGPEIVAC_YES settings*)
	END_STRUCT;
	McPIAGPEIVAdvStgEnum :
		( (*Storage selector setting*)
		mcPIAGPEIVAS_G := 0, (*Global - One global storage for all axis groups*)
		mcPIAGPEIVAS_AX_GRP := 1 (*Axis group - Separate storage for each axis group*)
		);
	McPIAGPEIVAdvStgType : STRUCT (*Data storage of variable*)
		Type : McPIAGPEIVAdvStgEnum; (*Storage selector setting*)
	END_STRUCT;
	McPIAGPEIVAdvType : STRUCT
		ArrayDimensions : McPIAGPEIVAdvArrDimType; (*Array dimensions*)
		Synchronization : McPIAGPEIVAdvSynType; (*Synchronization*)
		Constant : McPIAGPEIVAdvConstType; (*Variable is a constant*)
		Storage : McPIAGPEIVAdvStgType; (*Data storage of variable*)
	END_STRUCT;
	McPIAGPEIVType : STRUCT
		VariableName : STRING[250]; (*Name of the variable*)
		DataType : McCfgVarDatTypType; (*Data type*)
		Advanced : McPIAGPEIVAdvType;
	END_STRUCT;
	McPIAGPEIVSType : STRUCT (*Declaration of variables*)
		InterpreterVariable : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGPEFUNAdvSynEnum :
		( (*Synchronization selector setting*)
		mcPIAGPEFUNAS_IPSYN := 0, (*Interpreter-synchronous - Interpreter-synchronous*)
		mcPIAGPEFUNAS_PATHSYN := 1 (*Path-synchronous - Path-synchronous*)
		);
	McPIAGPEFUNAdvSynType : STRUCT (*Synchronization*)
		Type : McPIAGPEFUNAdvSynEnum; (*Synchronization selector setting*)
	END_STRUCT;
	McPIAGPEFUNAdvExeInSimEnum :
		( (*Function is executed in simulation run of program restart*)
		mcPIAGPEFUNAEIS_NO := 0, (*No*)
		mcPIAGPEFUNAEIS_YES := 1 (*Yes*)
		);
	McPIAGPEFUNAdvRetRefEnum :
		( (*Return type of function is a reference*)
		mcPIAGPEFUNARR_NO := 0, (*No*)
		mcPIAGPEFUNARR_YES := 1 (*Yes*)
		);
	McPIAGPEFUNAdvType : STRUCT
		Synchronization : McPIAGPEFUNAdvSynType; (*Synchronization*)
		ExecuteInSimulation : McPIAGPEFUNAdvExeInSimEnum; (*Function is executed in simulation run of program restart*)
		RetReference : McPIAGPEFUNAdvRetRefEnum; (*Return type of function is a reference*)
	END_STRUCT;
	McPIAGPEFUNArgRefEnum :
		( (*Argument pass by reference*)
		mcPIAGPEFUNAR_NO := 0, (*No*)
		mcPIAGPEFUNAR_YES := 1 (*Yes*)
		);
	McPIAGPEFUNArgType : STRUCT
		Name : STRING[250]; (*Argument name*)
		DataType : McCfgVarDatTypType; (*Data type*)
		Reference : McPIAGPEFUNArgRefEnum; (*Argument pass by reference*)
	END_STRUCT;
	McPIAGPEFUNType : STRUCT
		FunctionName : STRING[250]; (*Name of function*)
		FunctionReturnType : McCfgFunDatTypType; (*Return data type of function*)
		Advanced : McPIAGPEFUNAdvType;
		Argument : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGPEFUNSType : STRUCT (*Declaration of functions*)
		Function : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGPEFBAdvExeInSimEnum :
		( (*Function block is executed in simulation run of program restart*)
		mcPIAGPEFBAEIS_NO := 0, (*No*)
		mcPIAGPEFBAEIS_YES := 1 (*Yes*)
		);
	McPIAGPEFBAdvType : STRUCT
		ExecuteInSimulation : McPIAGPEFBAdvExeInSimEnum; (*Function block is executed in simulation run of program restart*)
	END_STRUCT;
	McPIAGPEFBOutRlEnum :
		( (*Output rules selector setting*)
		mcPIAGPEFBOR_PLCOPEN := 0, (*PLCOpen - Predifined for PLC_Open FB: BUSY Condition= ($busy == 1), ERROR Condition= ($error == 1)*)
		mcPIAGPEFBOR_BUR := 1, (*BuR - Predifined for BuR FB: BUSY Condition= ($status == 65535), ERROR Condition= ($status <> 0 AND $status <> 65535)*)
		mcPIAGPEFBOR_USR := 2 (*User - User defined output rules definition*)
		);
	McPIAGPEFBOutRlUsrType : STRUCT (*Type mcPIAGPEFBOR_USR settings*)
		BUSYCondition : STRING[250]; (*BUSY condition for Function block*)
		ERRORCondition : STRING[250]; (*ERROR condition for Function block*)
	END_STRUCT;
	McPIAGPEFBOutRlType : STRUCT (*Output rules definition*)
		Type : McPIAGPEFBOutRlEnum; (*Output rules selector setting*)
		User : McPIAGPEFBOutRlUsrType; (*Type mcPIAGPEFBOR_USR settings*)
	END_STRUCT;
	McPIAGPEFBType : STRUCT
		FunctionBlockName : STRING[250]; (*Name of Function block*)
		Advanced : McPIAGPEFBAdvType;
		OutputRules : McPIAGPEFBOutRlType; (*Output rules definition*)
	END_STRUCT;
	McPIAGPEFBSType : STRUCT (*Declaration of function blocks*)
		FunctionBlock : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGPEFBIAdvSynEnum :
		( (*Synchronization selector setting*)
		mcPIAGPEFBIAS_IPSYN := 0, (*Interpreter-synchronous - Interpreter-synchronous*)
		mcPIAGPEFBIAS_PATHSYN := 1 (*Path-synchronous - Path-synchronous*)
		);
	McPIAGPEFBIAdvSynType : STRUCT (*Synchronization*)
		Type : McPIAGPEFBIAdvSynEnum; (*Synchronization selector setting*)
	END_STRUCT;
	McPIAGPEFBIAdvBlkEnum :
		( (*Executing other code waiting for Function block to complete*)
		mcPIAGPEFBIAB_NO := 0, (*No*)
		mcPIAGPEFBIAB_YES := 1 (*Yes*)
		);
	McPIAGPEFBIAdvType : STRUCT
		Alias : STRING[250]; (*Alternative name of Function block instance*)
		Synchronization : McPIAGPEFBIAdvSynType; (*Synchronization*)
		Blocking : McPIAGPEFBIAdvBlkEnum; (*Executing other code waiting for Function block to complete*)
	END_STRUCT;
	McPIAGPEFBIType : STRUCT
		ProcessVariableName : STRING[250]; (*Name of process variable as Function block instance*)
		Advanced : McPIAGPEFBIAdvType;
	END_STRUCT;
	McPIAGPEFBISType : STRUCT (*Declaration of process variable as Function block instance*)
		FunctionBlockInstance : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGPEType : STRUCT (*Program elements*)
		AccessRestrictions : McPIAGPEAcsRstType;
		ProcessVariables : McPIAGPEPVSType; (*Declaration of process variables*)
		InterpreterVariables : McPIAGPEIVSType; (*Declaration of variables*)
		Functions : McPIAGPEFUNSType; (*Declaration of functions*)
		FunctionBlocks : McPIAGPEFBSType; (*Declaration of function blocks*)
		FunctionBlockInstance : McPIAGPEFBISType; (*Declaration of process variable as Function block instance*)
	END_STRUCT;
	McPIAGIECDeclIECDeclEnum :
		( (*IEC declarations 1-N selector setting*)
		mcPIAGIDID_F_TYP := 0, (*File .typ - IEC type declaration file*)
		mcPIAGIDID_F_VAR := 1, (*File .var - IEC variable declaration file*)
		mcPIAGIDID_F_FUN := 2, (*File .fun - IEC function/function block declaration file*)
		mcPIAGIDID_DAT_OBJ := 3 (*Data object - Data object*)
		);
	McPIAGIECDeclIECDeclFtypType : STRUCT (*Type mcPIAGIDID_F_TYP settings*)
		FileName : McCfgUnboundedArrayType; (*Name of IEC file*)
		FileDevice : STRING[250]; (*IEC file device*)
	END_STRUCT;
	McPIAGIECDeclIECDeclFvarType : STRUCT (*Type mcPIAGIDID_F_VAR settings*)
		FileName : McCfgUnboundedArrayType; (*Name of IEC file*)
		FileDevice : STRING[250]; (*IEC file device*)
	END_STRUCT;
	McPIAGIECDeclIECDeclFfunType : STRUCT (*Type mcPIAGIDID_F_FUN settings*)
		FileName : McCfgUnboundedArrayType; (*Name of IEC file*)
		FileDevice : STRING[250]; (*IEC file device*)
	END_STRUCT;
	McPIAGIECDeclIECDeclDatObjType : STRUCT (*Type mcPIAGIDID_DAT_OBJ settings*)
		Name : McCfgUnboundedArrayType; (*Name of data object*)
	END_STRUCT;
	McPIAGIECDeclIECDeclType : STRUCT
		Type : McPIAGIECDeclIECDeclEnum; (*IEC declarations 1-N selector setting*)
		Filetyp : McPIAGIECDeclIECDeclFtypType; (*Type mcPIAGIDID_F_TYP settings*)
		Filevar : McPIAGIECDeclIECDeclFvarType; (*Type mcPIAGIDID_F_VAR settings*)
		Filefun : McPIAGIECDeclIECDeclFfunType; (*Type mcPIAGIDID_F_FUN settings*)
		DataObject : McPIAGIECDeclIECDeclDatObjType; (*Type mcPIAGIDID_DAT_OBJ settings*)
	END_STRUCT;
	McPIAGIECDeclType : STRUCT (*IEC declarations loaded at Interpreter start-up*)
		IECDeclarations : McCfgUnboundedArrayType;
	END_STRUCT;
	McPIAGSMemType : STRUCT
		MemoryPartitionSize : UDINT; (*Size of physical memory partition [kB]*)
		ReservedMemoryStart : UDINT; (*Allocated (reserved) memory when Interpreter starts [MB]*)
		MaximumMemoryConsumption : UDINT; (*Maximum memory consumption limit for the Interpreter [%]*)
	END_STRUCT;
	McPIAGSPrgLdType : STRUCT
		FileSizeSwitchFileXLMode : UDINT; (*Size of a file for automatic switching program to file XL mode. [MB]*)
		LoadedLines : UDINT; (*Number of lines loaded at once during one interaction of Interpreter background task.*)
		LoadedLinesProgramExecution : UDINT; (*Number of lines loaded at once during one interaction of Interpreter background task when running another program.*)
		ParsedLines : UDINT; (*Number of lines parsed at once during one interaction of Interpreter background task.*)
		ParsedLinesProgramExecution : UDINT; (*Number of lines parsed at once during one interaction of Interpreter background task when running another program.*)
	END_STRUCT;
	McPIAGSPrgExeType : STRUCT
		ExecutedOpcodeInstructions : UDINT; (*Maximum number of opcode instructions executed at once during one interaction of Interpreter background task.*)
		StackSizeMainThread : UDINT; (*Stack size for the Interpreter main execution thread. [B]*)
		StackSizeCyclicThread : UDINT; (*Stack size for Interpreter cyclic execution thread [B]*)
		StackSizePathSynchThread : UDINT; (*Stack size for Interpreter path-synchronous execution thread [B]*)
		StackSizeDebugThread : UDINT; (*Stack size for Interpreter debug execution thread [B]*)
	END_STRUCT;
	McPIAGSCmdQueType : STRUCT
		CommandQueueSize : UDINT; (*Size (number of commands) of input command queue*)
	END_STRUCT;
	McPIAGSMPQueAxGrpLaModEnum :
		( (*Lookahead mode selector setting*)
		mcPIAGSMPQAGLM_ANY := 0, (*Any - Any type of NC block generated motion packet (e.g. G01, G70)*)
		mcPIAGSMPQAGLM_MOT := 1 (*Motion - Only NC blocks that cause motion (e.g. G01 X10, non G70).*)
		);
	McPIAGSMPQueAxGrpLaModType : STRUCT (*Specify which type of NC-blocks should count as lookahead.*)
		Type : McPIAGSMPQueAxGrpLaModEnum; (*Lookahead mode selector setting*)
	END_STRUCT;
	McPIAGSMPQueAxGrpType : STRUCT (*Motion packet queue for one Axis group*)
		MotionPacketQueueSize : UDINT; (*Maximum number of packets in the motion packet queue.*)
		LookaheadMinimumBlocks : UDINT; (*Interpreter process minimum number of NC-blocks that generate motion packets.*)
		LookaheadMaximumBlocks : UDINT; (*Interpreter process maximum number of NC-blocks that generate motion packets.*)
		LookaheadMode : McPIAGSMPQueAxGrpLaModType; (*Specify which type of NC-blocks should count as lookahead.*)
		NumberPathSynchExecutions : UDINT; (*Maximum number of path synchronous execution that Interpreter keeps in memory*)
	END_STRUCT;
	McPIAGSType : STRUCT (*System settings*)
		Memory : McPIAGSMemType;
		ProgramLoader : McPIAGSPrgLdType;
		ProgramExecution : McPIAGSPrgExeType;
		CommandQueue : McPIAGSCmdQueType;
		MotionPacketQueue : McPIAGSMPQueAxGrpType; (*Motion packet queue for one Axis group*)
	END_STRUCT;
	McCfgPrgIntAxGrpType : STRUCT (*Main data type corresponding to McCfgTypeEnum mcCFG_PRG_IP_AXGRP*)
		Languages : McPIAGLType; (*Languages*)
		ProgramElements : McPIAGPEType; (*Program elements*)
		IECDeclarations : McPIAGIECDeclType; (*IEC declarations loaded at Interpreter start-up*)
		System : McPIAGSType; (*System settings*)
	END_STRUCT;
END_TYPE