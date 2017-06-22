#!../../bin/linux-x86_64/dmm7510

< envPaths

cd ${TOP}

# ###### MACRO SUBSTITUTION ###### 

## Naming Convention for DMM
epicsEnvSet DMSEC AS
epicsEnvSet DMSUB Inj
epicsEnvSet DMDIS TI
epicsEnvSet DMDEV DMM

## Naming Convention for DCCT
epicsEnvSet DCSEC AS
epicsEnvSet DCSUB Inj
epicsEnvSet DCDIS TI
epicsEnvSet DCDEV DCCT

## Naming Convention for ICT
epicsEnvSet ICSEC AS
epicsEnvSet ICSUB Inj
epicsEnvSet ICDIS TI
epicsEnvSet ICDEV ICT

# Enable/disable module lines
epicsEnvSet DMM1_line ""
epicsEnvSet DCCT1_line "#"
epicsEnvSet ICT1_line ""

# ################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/dmm7510App/Db")

## Register all support components
dbLoadDatabase "dbd/dmm7510.dbd"
dmm7510_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/accessSecurityFile.acf")

${DMM1_line}drvAsynIPPortConfigure("DMM1", "10.0.18.71:5025 TCP",0,0,0)

## Load record instances

# DMM
${DMM1_line}dbLoadRecords("${TOP}/db/dmm7510.db", "P=${DMSEC}-${DMSUB}:, R=${DMDIS}-${DMDEV}1:, PORT=DMM1")
${DCCT1_line}dbLoadRecords("${TOP}/db/dcct.db", "Sec=${DCSEC}, Sub=${DCSUB}, Dis=${DCDIS}, Dev=${DCDEV}, Idx=1, Instrument=${DMSEC}-${DMSUB}:${DMDIS}-${DMDEV}1")
${ICT1_line}dbLoadRecords("${TOP}/db/ict.db", "Sec=${ICSEC}, Sub=${ICSUB}, Dis=${ICDIS}, Dev=${ICDEV}, Idx=1, Instrument=${DMSEC}-${DMSUB}:${DMDIS}-${DMDEV}1")

# Specify save file path
set_savefile_path("$(TOP)", "autosave")

# Specify request files directories
set_requestfile_path("$(TOP)", "autosave/request_files")

# Specify files to be restored, and when
# DCCT
${DCCT1_line}set_pass0_restoreFile("autosave_dcct1.sav")
# ICT
${ICT1_line}set_pass0_restoreFile("autosave_ict1.sav")

# Enable/Disable backup files (0->Disable, 1->Enable)
save_restoreSet_DatedBackupFiles(0)

# Number of copies of .sav files to maintain
save_restoreSet_NumSeqFiles(0)

## Run this to trace the stages of iocInit
#traceIocInit

cd ${TOP}/iocBoot/${IOC}
iocInit

## Start any sequence programs

# Sequencer STATE MACHINES Initialization

# No sequencer program

# Create manual trigger for Autosave
# DCCT
${DCCT1_line}create_triggered_set("autosave_dcct1.req", "${DCSEC}-${DCSUB}:${DCDIS}-${DCDEV}1:SaveTrg", "Sec=${DCSEC}, Sub=${DCSUB}, Dis=${DCDIS}, Dev=${DCDEV}, Idx=1")
# ICT
${ICT1_line}create_triggered_set("autosave_ict1.req", "${ICSEC}-${ICSUB}:${ICDIS}-${ICDEV}1:SaveTrg", "Sec=${ICSEC}, Sub=${ICSUB}, Dis=${ICDIS}, Dev=${ICDEV}, Idx=1")

