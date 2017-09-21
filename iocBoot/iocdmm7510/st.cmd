#!../../bin/linux-x86_64/dmm7510

< envPaths

# ####################################################
#		IOC SETTINGS
#
# --------------------------------------------
#  Notes: Edit the macro substitution strings
#  	 to define the IOC basic settings.   
# --------------------------------------------
#
# ####################################################

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

# Enable/disable module lines ----------------
epicsEnvSet DMM_line ""
epicsEnvSet DCCT_line ""
epicsEnvSet ICT_line "#"
# --------------------------------------------

${DCCT_line}epicsEnvSet P "${PDCCT}"
${DCCT_line}epicsEnvSet R "${RDCCT}"
${ICT_line}epicsEnvSet P "${PICT}"
${ICT_line}epicsEnvSet R "${RICT}"

# ####################################################

epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/dmm7510App/Db")

## Register all support components
dbLoadDatabase ("${TOP}/dbd/dmm7510.dbd")
dmm7510_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/dmm7510App/Db/accessSecurityFile.acf")

${DMM_line}drvAsynIPPortConfigure("DMMPORT", "${DMMADDR}:5025 TCP",0,0,0)

## Load record instances

# DMM
${DMM_line}dbLoadRecords("${TOP}/db/dmm7510.db", "P=${PDMM}, R=${RDMM}, PORT=DMMPORT")
${DCCT_line}dbLoadRecords("${TOP}/db/dcct.db", "P=${PDCCT}, R=${RDCCT}, Instrument=${PDMM}${RDMM}")
${ICT_line}dbLoadRecords("${TOP}/db/ict.db", "P=${PICT}, R=${RICT}, Instrument=${PDMM}${RDMM}")

< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Sequencer STATE MACHINES Initialization

# No sequencer program

# Create manual trigger for Autosave
# DCCT
${DCCT_line}create_triggered_set("auto_settings_dcct.req", "${PDCCT}${RDCCT}SaveTrg", "P=${PDCCT}, R=${RDCCT}")
# ICT
${ICT_line}create_triggered_set("auto_settings_ict.req", "${PICT}${RICT}SaveTrg", "P=${PICT}, R=${RICT}")

