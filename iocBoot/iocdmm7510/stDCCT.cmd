< envPaths

epicsEnvSet("TOP", "../..")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/dmm7510App/Db")

< DMM7510.config
< DCCT.config

####################################################

## Register all support components
dbLoadDatabase ("${TOP}/dbd/dmm7510.dbd")
dmm7510_registerRecordDeviceDriver pdbbase

< logEnv.config

asSetFilename("$(TOP)/dmm7510App/Db/accessSecurityFile.acf")

drvAsynIPPortConfigure("${PORT}", "${IPADDR}:${IPPORT} TCP",0,0,0)

## Load record instances
dbLoadRecords("${TOP}/db/dmm7510.db", "P=${P}, R=${R}, PORT=${PORT}")
dbLoadRecords("${TOP}/db/dcct.db", "P=${P}, R=${R}, Instrument=${P}${R}, MAX_NUM_READINGS=${MAX_NUM_READINGS}, PORT=${PORT}")

< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs
seq sncDCCT, "P=$(P), R=$(R), Instrument=$(P)$(R)"

# Also, save things every 5 seconds
create_monitor_set("auto_settings_dcct.req", 5, "P=${P}, R=${R}")
set_savefile_name("auto_settings_dcct.req", "auto_settings_${P}${R}.sav")
