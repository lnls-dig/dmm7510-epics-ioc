#!../../bin/linux-x86_64/diagnostics

## You may have to change myexample to something else
## everywhere it appears in this file

< envPaths

cd ${TOP}

# ###### MACRO SUBSTITUTION ###### 

## Naming Convention
epicsEnvSet SEC AS
epicsEnvSet SUB Inj
epicsEnvSet DIS TI
epicsEnvSet DMM DMM
epicsEnvSet DCT DCCT
epicsEnvSet ICT ICT

# Enable/disable module lines
epicsEnvSet DMM1_line ""

# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/diagnosticsApp/Db")

## Register all support components
dbLoadDatabase "dbd/diagnostics.dbd"
diagnostics_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/accessSecurityFile.acf")

${DMM1_line}drvAsynIPPortConfigure ("DMM1", "10.0.18.71:5025 TCP",0,0,0)

## Load record instances

# DMM
${DMM1_line}dbLoadRecords("${TOP}/db/dmm7510.db", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${DMM}, Idx=1, PORT=DMM1")

# Specify save file path
#set_savefile_path("$(TOP)", "autosave/save_files")

# Specify request files directories
#set_requestfile_path("$(TOP)", "autosave/request_files")

# Specify files to be restored, and when
# DMM
#${DMM1_line}set_pass0_restoreFile("autosave_dmm1_NOPROC.sav", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${DMM}, Idx=1")

# Enable/Disable backup files (0->Disable, 1->Enable)
#save_restoreSet_DatedBackupFiles(0)

# Number of copies of .sav files to maintain
#save_restoreSet_NumSeqFiles(0)

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs

# Sequencer STATE MACHINES Initialization

# Create manual trigger for Autosave
# DMM
#${DMM1_line}create_triggered_set("autosave_dmm1_NOPROC.req", "${SEC}-${SUB}:${DIS}-${GDEV}1:save_T", "Sec=${SEC}, Sub=${SUB}, Dis=${DIS}, Dev=${DMM}, Idx=1")

