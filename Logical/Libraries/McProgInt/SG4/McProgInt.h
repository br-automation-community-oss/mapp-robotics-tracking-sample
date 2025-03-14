/* Automation Studio generated header file */
/* Do not edit ! */
/* McProgInt 6.4.5582 */

#ifndef _MCPROGINT_
#define _MCPROGINT_
#ifdef __cplusplus
extern "C" 
{
#endif
#ifndef _McProgInt_VERSION
#define _McProgInt_VERSION 6.4.5582
#endif

#include <bur/plctypes.h>

#ifndef _BUR_PUBLIC
#define _BUR_PUBLIC
#endif

#ifdef _SG4
#include <McBase.h>
#endif
 
#ifdef _SG3
#include <McBase.h>
#endif
 
#ifdef _SGC
#include <McBase.h>
#endif

/* Datatypes and datatypes of function blocks */
typedef enum McPIAGLPDFLGCBREnum
{	mcPIAGLPDFLGCBR_ACT = 0,
	mcPIAGLPDFLGCBR_INACT = 1
} McPIAGLPDFLGCBREnum;

typedef enum McPIAGLADefADefEnum
{	mcPIAGLADAD_F_A = 0,
	mcPIAGLADAD_DAT_OBJ = 1
} McPIAGLADefADefEnum;

typedef enum McPIAGLPDFLGCAlt1Enum
{	mcPIAGLPDFLGCA1_ACT = 0,
	mcPIAGLPDFLGCA1_INACT = 1
} McPIAGLPDFLGCAlt1Enum;

typedef enum McPIAGLPDFLSTEnum
{	mcPIAGLPDFLST_ACT = 0,
	mcPIAGLPDFLST_INACT = 1
} McPIAGLPDFLSTEnum;

typedef enum McPIAGLPDFLMPLEnum
{	mcPIAGLPDFLMPL_ACT = 0,
	mcPIAGLPDFLMPL_INACT = 1
} McPIAGLPDFLMPLEnum;

typedef enum McPIAGLSCSenVarEnum
{	mcPIAGLSCSV_NOT_USE = 0,
	mcPIAGLSCSV_USE = 1
} McPIAGLSCSenVarEnum;

typedef enum McPIAGPEARPVDefAcsEnum
{	mcPIAGPEARPVDA_READ_WRITE = 0,
	mcPIAGPEARPVDA_READ_ONLY = 1,
	mcPIAGPEARPVDA_NO_ACS = 2
} McPIAGPEARPVDefAcsEnum;

typedef enum McPIAGPEARFFBDefExeEnum
{	mcPIAGPEARFFBDE_EXE = 0,
	mcPIAGPEARFFBDE_NOT_EXE = 1
} McPIAGPEARFFBDefExeEnum;

typedef enum McPIAGPEAcsRstIOsInEnum
{	mcPIAGPEARII_ALLOW = 0,
	mcPIAGPEARII_NOT_ALLOW = 1
} McPIAGPEAcsRstIOsInEnum;

typedef enum McPIAGPEAcsRstIOsOutEnum
{	mcPIAGPEARIO_ALLOW = 0,
	mcPIAGPEARIO_NOT_ALLOW = 1
} McPIAGPEAcsRstIOsOutEnum;

typedef enum McPIAGPEPVAdvSynEnum
{	mcPIAGPEPVAS_IPSYN = 0,
	mcPIAGPEPVAS_PATHSYN = 1
} McPIAGPEPVAdvSynEnum;

typedef enum McPIAGPEPVAdvRefEnum
{	mcPIAGPEPVAR_NO = 0,
	mcPIAGPEPVAR_YES = 1
} McPIAGPEPVAdvRefEnum;

typedef enum McPIAGPEIVAdvSynEnum
{	mcPIAGPEIVAS_IPSYN = 0,
	mcPIAGPEIVAS_PATHSYN = 1
} McPIAGPEIVAdvSynEnum;

typedef enum McPIAGPEIVAdvConstEnum
{	mcPIAGPEIVAC_NO = 0,
	mcPIAGPEIVAC_YES = 1
} McPIAGPEIVAdvConstEnum;

typedef enum McPIAGPEIVAdvStgEnum
{	mcPIAGPEIVAS_G = 0,
	mcPIAGPEIVAS_AX_GRP = 1
} McPIAGPEIVAdvStgEnum;

typedef enum McPIAGPEFUNAdvSynEnum
{	mcPIAGPEFUNAS_IPSYN = 0,
	mcPIAGPEFUNAS_PATHSYN = 1
} McPIAGPEFUNAdvSynEnum;

typedef enum McPIAGPEFUNAdvExeInSimEnum
{	mcPIAGPEFUNAEIS_NO = 0,
	mcPIAGPEFUNAEIS_YES = 1
} McPIAGPEFUNAdvExeInSimEnum;

typedef enum McPIAGPEFUNAdvRetRefEnum
{	mcPIAGPEFUNARR_NO = 0,
	mcPIAGPEFUNARR_YES = 1
} McPIAGPEFUNAdvRetRefEnum;

typedef enum McPIAGPEFUNArgRefEnum
{	mcPIAGPEFUNAR_NO = 0,
	mcPIAGPEFUNAR_YES = 1
} McPIAGPEFUNArgRefEnum;

typedef enum McPIAGPEFBAdvExeInSimEnum
{	mcPIAGPEFBAEIS_NO = 0,
	mcPIAGPEFBAEIS_YES = 1
} McPIAGPEFBAdvExeInSimEnum;

typedef enum McPIAGPEFBOutRlEnum
{	mcPIAGPEFBOR_PLCOPEN = 0,
	mcPIAGPEFBOR_BUR = 1,
	mcPIAGPEFBOR_USR = 2
} McPIAGPEFBOutRlEnum;

typedef enum McPIAGPEFBIAdvSynEnum
{	mcPIAGPEFBIAS_IPSYN = 0,
	mcPIAGPEFBIAS_PATHSYN = 1
} McPIAGPEFBIAdvSynEnum;

typedef enum McPIAGPEFBIAdvBlkEnum
{	mcPIAGPEFBIAB_NO = 0,
	mcPIAGPEFBIAB_YES = 1
} McPIAGPEFBIAdvBlkEnum;

typedef enum McPIAGIECDeclIECDeclEnum
{	mcPIAGIDID_F_TYP = 0,
	mcPIAGIDID_F_VAR = 1,
	mcPIAGIDID_F_FUN = 2,
	mcPIAGIDID_DAT_OBJ = 3
} McPIAGIECDeclIECDeclEnum;

typedef enum McPIAGSMPQueAxGrpLaModEnum
{	mcPIAGSMPQAGLM_ANY = 0,
	mcPIAGSMPQAGLM_MOT = 1
} McPIAGSMPQueAxGrpLaModEnum;

typedef struct McProgIntIpMonitorType
{	plcbit Handshake;
	plcbit Reserve[3];
	plcstring StatusMsg[264];
	plcstring LastErrorMsg[120];
	unsigned short LastErrorCode;
	unsigned short LoadedProgCount;
	plcstring ProgName[264];
	plcstring NcblockL2[264];
	plcstring NcblockL1[264];
	plcstring Ncblock[264];
	plcstring NcblockN1[264];
	plcstring NcblockN2[264];
	unsigned long CurLineNum;
	unsigned long CurBlockNum;
	unsigned long LoadFreadTime;
	unsigned long LoadPrepTime;
	unsigned long LoadSepLinesTime;
	unsigned long LoadParseTime;
	unsigned long LoadParseLexTime;
	unsigned long BreakpointCount;
	unsigned long IpvarAccessCount;
	unsigned long ExecTime;
	unsigned long IdleTime;
	unsigned long NumParallelEvents;
	unsigned long ParallelCycleCount;
	plcstring ParallelActionText[12][264];
	unsigned long ParallelEvalCount[12];
	unsigned long ParallelExecCount[12];
	unsigned long NumFubsExecIpsynch;
	unsigned long NumFubsExecPpsynch;
	plcstring Callstack[12][264];
	unsigned long SharedMem_size;
	unsigned long IpMemSize;
	unsigned long IpCurFileMemSize;
	unsigned long SysFreeMem;
	unsigned long ReadingLineNum;
	unsigned long TranslatingLineNuM;
	unsigned long GeneratingAilLineNum;
	unsigned long ParsingAilLineNum;
	plcbit ParallelEnabled;
	plcbit ParallelRdisableSet;
	plcbit StopAtM1;
	plcbit Unused;
	plcstring CurProgFileName[264];
	plcstring CurProgName[264];
} McProgIntIpMonitorType;

typedef struct McProgIntFileMonitorEntryType
{	plcstring (*Name)[264];
	plcstring (*PathName)[264];
	plcstring (*DirName)[264];
	plcstring (*DeviceName)[264];
	unsigned long ProgramNumber;
	unsigned long StorageType;
	unsigned long TimeStamp;
	plcbit PrecompiledLCF;
	struct McProgIntFileMonitorEntryType* Next;
} McProgIntFileMonitorEntryType;

typedef struct McProgIntFileMonitorAccessType
{	plcbit Valid;
	struct McProgIntFileMonitorEntryType* First;
} McProgIntFileMonitorAccessType;

typedef struct McProgIntFileMonitorLineType
{	plcstring Name[32];
	unsigned long ProgramNumber;
	unsigned long StorageType;
} McProgIntFileMonitorLineType;

typedef struct McProgIntFileMonitorType
{	plcbit Handshake;
	unsigned long SetOffset;
	unsigned long Offset;
	struct McProgIntFileMonitorLineType File[32];
	struct McProgIntFileMonitorAccessType DirectAccess;
} McProgIntFileMonitorType;

typedef double McSlaveAxisType[15];

typedef struct McPointType
{	struct McPosType Pos;
	struct McOrientType Orient;
	McSlaveAxisType SlaveAxis;
} McPointType;

typedef double McJointAxisType[6];

typedef struct McAxisTargetType
{	McJointAxisType JointAxis;
	McSlaveAxisType SlaveAxis;
} McAxisTargetType;

typedef struct McLatchPositionsType
{	plcbit TriggerEvent;
	unsigned long CoordSystem;
	double Position[15];
} McLatchPositionsType;

typedef struct McPIAGLADefADefFAType
{	struct McCfgUnboundedArrayType FileName;
	plcstring FileDevice[251];
} McPIAGLADefADefFAType;

typedef struct McPIAGLADefADefDatObjType
{	struct McCfgUnboundedArrayType Name;
} McPIAGLADefADefDatObjType;

typedef struct McPIAGLADefADefType
{	enum McPIAGLADefADefEnum Type;
	struct McPIAGLADefADefFAType FileAIL;
	struct McPIAGLADefADefDatObjType DataObject;
} McPIAGLADefADefType;

typedef struct McPIAGLADefType
{	struct McCfgUnboundedArrayType AILDefinitions;
} McPIAGLADefType;

typedef struct McPIAGLPDFLGCBRActType
{	plcstring FileExtensions[251];
	struct McPIAGLADefType AILDefinitions;
} McPIAGLPDFLGCBRActType;

typedef struct McPIAGLPDFLGCBRType
{	enum McPIAGLPDFLGCBREnum Type;
	struct McPIAGLPDFLGCBRActType Active;
} McPIAGLPDFLGCBRType;

typedef struct McPIAGLPDFLGCAlt1ActType
{	plcstring FileExtensions[251];
	struct McPIAGLADefType AILDefinitions;
} McPIAGLPDFLGCAlt1ActType;

typedef struct McPIAGLPDFLGCAlt1Type
{	enum McPIAGLPDFLGCAlt1Enum Type;
	struct McPIAGLPDFLGCAlt1ActType Active;
} McPIAGLPDFLGCAlt1Type;

typedef struct McPIAGLPDFLSTActType
{	plcstring FileExtensionsLocal[251];
	plcstring FileExtensionsGlobal[251];
	struct McPIAGLADefType AILDefinitions;
} McPIAGLPDFLSTActType;

typedef struct McPIAGLPDFLSTType
{	enum McPIAGLPDFLSTEnum Type;
	struct McPIAGLPDFLSTActType Active;
} McPIAGLPDFLSTType;

typedef struct McPIAGLPDFLMPLActType
{	plcstring FileExtensions[251];
	struct McPIAGLADefType AILDefinitions;
} McPIAGLPDFLMPLActType;

typedef struct McPIAGLPDFLMPLType
{	enum McPIAGLPDFLMPLEnum Type;
	struct McPIAGLPDFLMPLActType Active;
} McPIAGLPDFLMPLType;

typedef struct McPIAGLPDFLType
{	struct McPIAGLPDFLGCBRType GCodeBR;
	struct McPIAGLPDFLGCAlt1Type GCodeAlternative1;
	struct McPIAGLPDFLSTType StructuredText;
	struct McPIAGLPDFLMPLType MotionPacketLog;
} McPIAGLPDFLType;

typedef struct McPIAGLCDFLCusLangType
{	plcstring Name[251];
	struct McPIAGLADefType AILDefinitions;
	plcstring FileExtensionsLocal[251];
	plcstring FileExtensionsGlobal[251];
} McPIAGLCDFLCusLangType;

typedef struct McPIAGLCDFLType
{	struct McCfgUnboundedArrayType CustomLanguage;
} McPIAGLCDFLType;

typedef struct McPIAGLSCSenVarType
{	enum McPIAGLSCSenVarEnum Type;
} McPIAGLSCSenVarType;

typedef struct McPIAGLSType
{	struct McPIAGLSCSenVarType CaseSensitiveVariables;
} McPIAGLSType;

typedef struct McPIAGLType
{	struct McPIAGLPDFLType PredefinedLanguages;
	struct McPIAGLCDFLType CustomDefinedLanguages;
	struct McPIAGLSType Settings;
} McPIAGLType;

typedef struct McPIAGPEARPVDefAcsType
{	enum McPIAGPEARPVDefAcsEnum Type;
} McPIAGPEARPVDefAcsType;

typedef struct McPIAGPVRegExType
{	struct McCfgUnboundedArrayType RegularExpression;
} McPIAGPVRegExType;

typedef struct McPIAGPEARPVAcsRstType
{	struct McPIAGPVRegExType RegularExpressions;
	struct McCfgUnboundedArrayType ProcessVariableName;
} McPIAGPEARPVAcsRstType;

typedef struct McPIAGPEARPVType
{	struct McPIAGPEARPVDefAcsType DefaultAccess;
	struct McPIAGPEARPVAcsRstType NoAccess;
	struct McPIAGPEARPVAcsRstType ReadOnlyAccess;
	struct McPIAGPEARPVAcsRstType ReadWriteAccess;
} McPIAGPEARPVType;

typedef struct McPIAGPEARFFBDefExeType
{	enum McPIAGPEARFFBDefExeEnum Type;
} McPIAGPEARFFBDefExeType;

typedef struct McPIAGFFBRegExType
{	struct McCfgUnboundedArrayType RegularExpression;
} McPIAGFFBRegExType;

typedef struct McPIAGPEARFFBAcsRstType
{	struct McPIAGFFBRegExType RegularExpressions;
	struct McCfgUnboundedArrayType FunctionFunctionBlockName;
} McPIAGPEARFFBAcsRstType;

typedef struct McPIAGPEARFFBType
{	struct McPIAGPEARFFBDefExeType DefaultExecution;
	struct McPIAGPEARFFBAcsRstType NotExecutable;
	struct McPIAGPEARFFBAcsRstType Executable;
} McPIAGPEARFFBType;

typedef struct McPIAGPEAcsRstIOsType
{	enum McPIAGPEAcsRstIOsInEnum Inputs;
	enum McPIAGPEAcsRstIOsOutEnum Outputs;
} McPIAGPEAcsRstIOsType;

typedef struct McPIAGPEAcsRstType
{	struct McPIAGPEARPVType ProcessVariables;
	struct McPIAGPEARFFBType FunctionsFunctionBlocks;
	struct McPIAGPEAcsRstIOsType IOs;
} McPIAGPEAcsRstType;

typedef struct McPIAGPEPVAdvSynType
{	enum McPIAGPEPVAdvSynEnum Type;
} McPIAGPEPVAdvSynType;

typedef struct McPIAGPEPVAdvRefType
{	enum McPIAGPEPVAdvRefEnum Type;
} McPIAGPEPVAdvRefType;

typedef struct McPIAGPEPVAdvType
{	plcstring Alias[251];
	struct McPIAGPEPVAdvSynType Synchronization;
	struct McPIAGPEPVAdvRefType Reference;
} McPIAGPEPVAdvType;

typedef struct McPIAGPEPVType
{	plcstring ProcessVariableName[251];
	struct McPIAGPEPVAdvType Advanced;
} McPIAGPEPVType;

typedef struct McPIAGPEPVSType
{	struct McCfgUnboundedArrayType ProcessVariable;
} McPIAGPEPVSType;

typedef struct McPIAGPEIVAdvArrDimType
{	struct McCfgUnboundedArrayType SizeOfArrayDimemsion;
} McPIAGPEIVAdvArrDimType;

typedef struct McPIAGPEIVAdvSynType
{	enum McPIAGPEIVAdvSynEnum Type;
} McPIAGPEIVAdvSynType;

typedef struct McPIAGPEIVAdvConstYesType
{	plcstring Value[251];
} McPIAGPEIVAdvConstYesType;

typedef struct McPIAGPEIVAdvConstType
{	enum McPIAGPEIVAdvConstEnum Type;
	struct McPIAGPEIVAdvConstYesType Yes;
} McPIAGPEIVAdvConstType;

typedef struct McPIAGPEIVAdvStgType
{	enum McPIAGPEIVAdvStgEnum Type;
} McPIAGPEIVAdvStgType;

typedef struct McPIAGPEIVAdvType
{	struct McPIAGPEIVAdvArrDimType ArrayDimensions;
	struct McPIAGPEIVAdvSynType Synchronization;
	struct McPIAGPEIVAdvConstType Constant;
	struct McPIAGPEIVAdvStgType Storage;
} McPIAGPEIVAdvType;

typedef struct McPIAGPEIVType
{	plcstring VariableName[251];
	struct McCfgVarDatTypType DataType;
	struct McPIAGPEIVAdvType Advanced;
} McPIAGPEIVType;

typedef struct McPIAGPEIVSType
{	struct McCfgUnboundedArrayType InterpreterVariable;
} McPIAGPEIVSType;

typedef struct McPIAGPEFUNAdvSynType
{	enum McPIAGPEFUNAdvSynEnum Type;
} McPIAGPEFUNAdvSynType;

typedef struct McPIAGPEFUNAdvType
{	struct McPIAGPEFUNAdvSynType Synchronization;
	enum McPIAGPEFUNAdvExeInSimEnum ExecuteInSimulation;
	enum McPIAGPEFUNAdvRetRefEnum RetReference;
} McPIAGPEFUNAdvType;

typedef struct McPIAGPEFUNArgType
{	plcstring Name[251];
	struct McCfgVarDatTypType DataType;
	enum McPIAGPEFUNArgRefEnum Reference;
} McPIAGPEFUNArgType;

typedef struct McPIAGPEFUNType
{	plcstring FunctionName[251];
	struct McCfgFunDatTypType FunctionReturnType;
	struct McPIAGPEFUNAdvType Advanced;
	struct McCfgUnboundedArrayType Argument;
} McPIAGPEFUNType;

typedef struct McPIAGPEFUNSType
{	struct McCfgUnboundedArrayType Function;
} McPIAGPEFUNSType;

typedef struct McPIAGPEFBAdvType
{	enum McPIAGPEFBAdvExeInSimEnum ExecuteInSimulation;
} McPIAGPEFBAdvType;

typedef struct McPIAGPEFBOutRlUsrType
{	plcstring BUSYCondition[251];
	plcstring ERRORCondition[251];
} McPIAGPEFBOutRlUsrType;

typedef struct McPIAGPEFBOutRlType
{	enum McPIAGPEFBOutRlEnum Type;
	struct McPIAGPEFBOutRlUsrType User;
} McPIAGPEFBOutRlType;

typedef struct McPIAGPEFBType
{	plcstring FunctionBlockName[251];
	struct McPIAGPEFBAdvType Advanced;
	struct McPIAGPEFBOutRlType OutputRules;
} McPIAGPEFBType;

typedef struct McPIAGPEFBSType
{	struct McCfgUnboundedArrayType FunctionBlock;
} McPIAGPEFBSType;

typedef struct McPIAGPEFBIAdvSynType
{	enum McPIAGPEFBIAdvSynEnum Type;
} McPIAGPEFBIAdvSynType;

typedef struct McPIAGPEFBIAdvType
{	plcstring Alias[251];
	struct McPIAGPEFBIAdvSynType Synchronization;
	enum McPIAGPEFBIAdvBlkEnum Blocking;
} McPIAGPEFBIAdvType;

typedef struct McPIAGPEFBIType
{	plcstring ProcessVariableName[251];
	struct McPIAGPEFBIAdvType Advanced;
} McPIAGPEFBIType;

typedef struct McPIAGPEFBISType
{	struct McCfgUnboundedArrayType FunctionBlockInstance;
} McPIAGPEFBISType;

typedef struct McPIAGPEType
{	struct McPIAGPEAcsRstType AccessRestrictions;
	struct McPIAGPEPVSType ProcessVariables;
	struct McPIAGPEIVSType InterpreterVariables;
	struct McPIAGPEFUNSType Functions;
	struct McPIAGPEFBSType FunctionBlocks;
	struct McPIAGPEFBISType FunctionBlockInstance;
} McPIAGPEType;

typedef struct McPIAGIECDeclIECDeclFtypType
{	struct McCfgUnboundedArrayType FileName;
	plcstring FileDevice[251];
} McPIAGIECDeclIECDeclFtypType;

typedef struct McPIAGIECDeclIECDeclFvarType
{	struct McCfgUnboundedArrayType FileName;
	plcstring FileDevice[251];
} McPIAGIECDeclIECDeclFvarType;

typedef struct McPIAGIECDeclIECDeclFfunType
{	struct McCfgUnboundedArrayType FileName;
	plcstring FileDevice[251];
} McPIAGIECDeclIECDeclFfunType;

typedef struct McPIAGIECDeclIECDeclDatObjType
{	struct McCfgUnboundedArrayType Name;
} McPIAGIECDeclIECDeclDatObjType;

typedef struct McPIAGIECDeclIECDeclType
{	enum McPIAGIECDeclIECDeclEnum Type;
	struct McPIAGIECDeclIECDeclFtypType Filetyp;
	struct McPIAGIECDeclIECDeclFvarType Filevar;
	struct McPIAGIECDeclIECDeclFfunType Filefun;
	struct McPIAGIECDeclIECDeclDatObjType DataObject;
} McPIAGIECDeclIECDeclType;

typedef struct McPIAGIECDeclType
{	struct McCfgUnboundedArrayType IECDeclarations;
} McPIAGIECDeclType;

typedef struct McPIAGSMemType
{	unsigned long MemoryPartitionSize;
	unsigned long ReservedMemoryStart;
	unsigned long MaximumMemoryConsumption;
} McPIAGSMemType;

typedef struct McPIAGSPrgLdType
{	unsigned long FileSizeSwitchFileXLMode;
	unsigned long LoadedLines;
	unsigned long LoadedLinesProgramExecution;
	unsigned long ParsedLines;
	unsigned long ParsedLinesProgramExecution;
} McPIAGSPrgLdType;

typedef struct McPIAGSPrgExeType
{	unsigned long ExecutedOpcodeInstructions;
	unsigned long StackSizeMainThread;
	unsigned long StackSizeCyclicThread;
	unsigned long StackSizePathSynchThread;
	unsigned long StackSizeDebugThread;
} McPIAGSPrgExeType;

typedef struct McPIAGSCmdQueType
{	unsigned long CommandQueueSize;
} McPIAGSCmdQueType;

typedef struct McPIAGSMPQueAxGrpLaModType
{	enum McPIAGSMPQueAxGrpLaModEnum Type;
} McPIAGSMPQueAxGrpLaModType;

typedef struct McPIAGSMPQueAxGrpType
{	unsigned long MotionPacketQueueSize;
	unsigned long LookaheadMinimumBlocks;
	unsigned long LookaheadMaximumBlocks;
	struct McPIAGSMPQueAxGrpLaModType LookaheadMode;
	unsigned long NumberPathSynchExecutions;
} McPIAGSMPQueAxGrpType;

typedef struct McPIAGSType
{	struct McPIAGSMemType Memory;
	struct McPIAGSPrgLdType ProgramLoader;
	struct McPIAGSPrgExeType ProgramExecution;
	struct McPIAGSCmdQueType CommandQueue;
	struct McPIAGSMPQueAxGrpType MotionPacketQueue;
} McPIAGSType;

typedef struct McCfgPrgIntAxGrpType
{	struct McPIAGLType Languages;
	struct McPIAGPEType ProgramElements;
	struct McPIAGIECDeclType IECDeclarations;
	struct McPIAGSType System;
} McCfgPrgIntAxGrpType;

typedef double McRotationMatrixType[9];






#ifdef __cplusplus
};
#endif
#endif /* _MCPROGINT_ */

