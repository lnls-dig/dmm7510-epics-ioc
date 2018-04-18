< envPaths

epicsEnvSet("TOP", "../..")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/dmm7510App/Db")

< DMM7510.config

####################################################

## Register all support components
dbLoadDatabase ("${TOP}/dbd/dmm7510.dbd")
dmm7510_registerRecordDeviceDriver pdbbase

asSetFilename("$(TOP)/dmm7510App/Db/accessSecurityFile.acf")

drvAsynIPPortConfigure("${PORT}", "${IPADDR}:${IPPORT} TCP",0,0,0)

## Load record instances
dbLoadRecords("${TOP}/db/dmm7510.db", "P=${P}, R=${R}, PORT=${PORT}")

#< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Sequencer STATE MACHINES Initialization

# No sequencer program

# Create manual trigger for Autosave
#create_triggered_set("auto_settings_dmm7510.req", "${P}${R}SaveTrg", "P=${P}, R=${R}")
#set_savefile_name("auto_settings_dmm7510.req", "auto_settings_${P}${R}.sav")
