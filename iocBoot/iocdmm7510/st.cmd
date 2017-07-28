#!../../bin/linux-x86_64/dmm7510

< envPaths

cd ${TOP}

# ####################################################
#		IOC SETTINGS
#
# --------------------------------------------
#  Notes: Edit the macro substitution strings
#  	 to define the IOC basic settings.   
# --------------------------------------------
#
# ####################################################

# ########## Single Device Settings ##########

# DMM7510 IP address -------------------------
epicsEnvSet DMMADDR "10.0.18.54"
# --------------------------------------------

## Naming Convention for DMM7510 -------------
# P
epicsEnvSet PDMM "AS-Inj:TI-DMM-1:"
# R
epicsEnvSet RDMM ""
# --------------------------------------------

## Naming Convention for DCCT ----------------
# P
epicsEnvSet PDCCT "AS-Inj:TI-DCCT-1:"
# R
epicsEnvSet RDCCT ""
# --------------------------------------------

## Naming Convention for ICT -----------------
# P
epicsEnvSet PICT "AS-Inj:TI-ICT-1:"
# R
epicsEnvSet RICT ""
# --------------------------------------------

# ########## Efficiency App Settings #########

# Second DMM7510 IP address ------------------
epicsEnvSet DMM2ADDR "10.0.18.10"
# --------------------------------------------

## Naming Convention for DMM7510 for ICT-2 ---
# P
epicsEnvSet PDMM2 "AS-Inj:TI-DMM-2:"
# R
epicsEnvSet RDMM2 ""
# --------------------------------------------

## Naming Convention for ICT-2 ---------------
# P
epicsEnvSet PICT2 "AS-Inj:TI-ICT-2:"
# R
epicsEnvSet RICT2 ""
# --------------------------------------------

## Naming Convention for Inj Efficiency PVs --
# P
epicsEnvSet PEFF "EFF:"
# R
epicsEnvSet REFF "EFF:"
# --------------------------------------------

## Naming Convention for Eff test PVs --------
# P
epicsEnvSet PTEST "TEST:"
# R
epicsEnvSet RTEST "TEST:"
# --------------------------------------------

# ########## Enable / Disable lines ""/"#" ###

# Enable/disable module lines ----------------
epicsEnvSet DMM_line ""
epicsEnvSet DCCT_line "#"
epicsEnvSet ICT_line ""
epicsEnvSet EFF_line ""
# --------------------------------------------

# ####################################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/dmm7510App/Db")

## Register all support components
dbLoadDatabase "dbd/dmm7510.dbd"
dmm7510_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/accessSecurityFile.acf")

${DMM_line}drvAsynIPPortConfigure("DMMPORT", "${DMMADDR}:5025 TCP",0,0,0)
${EFF_line}drvAsynIPPortConfigure("DMM2PORT", "${DMM2ADDR}:5025 TCP",0,0,0)

## Load record instances

# DMM
${DMM_line}dbLoadRecords("${TOP}/db/dmm7510.db", "P=${PDMM}, R=${RDMM}, PORT=DMMPORT")

# Single device application
${DCCT_line}dbLoadRecords("${TOP}/db/dcct.db", "P=${PDCCT}, R=${RDCCT}, Instrument=${PDMM}${RDMM}")
${ICT_line}dbLoadRecords("${TOP}/db/ict.db", "P=${PICT}, R=${RICT}, Instrument=${PDMM}${RDMM}")

# Efficiency application
${EFF_line}dbLoadRecords("${TOP}/db/dmm7510.db", "P=${PDMM2}, R=${RDMM2}, PORT=DMM2PORT")
${EFF_line}dbLoadRecords("${TOP}/db/ict.db", "P=${PICT2}, R=${RICT2}, Instrument=${PDMM2}${RDMM2}")
${EFF_line}dbLoadRecords("${TOP}/db/eff.db", "P=${PEFF}, R=${REFF}, ict-1-prefix=${PICT}${RICT}, ict-2-prefix=${PICT2}${RICT2}")

# Specify save file path
set_savefile_path("$(TOP)", "autosave")

# Specify request files directories
set_requestfile_path("$(TOP)", "autosave/request_files")

# Specify files to be restored, and when
# DCCT
${DCCT_line}set_pass0_restoreFile("autosave_dcct.sav")
# ICT
${ICT_line}set_pass0_restoreFile("autosave_ict.sav")
# ICT-2
${EFF_line}set_pass0_restoreFile("autosave_ict2.sav")

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
${DCCT_line}create_triggered_set("autosave_dcct.req", "${PDCCT}${RDCCT}SaveTrg", "P=${PDCCT}, R=${RDCCT}")
# ICT
${ICT_line}create_triggered_set("autosave_ict.req", "${PICT}${RICT}SaveTrg", "P=${PICT}, R=${RICT}")
# ICT-2
${EFF_line}create_triggered_set("autosave_ict2.req", "${PICT2}${RICT2}SaveTrg", "P=${PICT2}, R=${RICT2}")
