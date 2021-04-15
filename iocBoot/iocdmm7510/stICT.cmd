< envPaths

epicsEnvSet("TOP","../..")
epicsEnvSet("STREAM_PROTOCOL_PATH", "$(TOP)/dmm7510App/Db")

< DMM7510.config
< ICT.config

####################################################

## Register all support components
dbLoadDatabase ("${TOP}/dbd/dmm7510.dbd")
dmm7510_registerRecordDeviceDriver pdbbase

< logEnv.config

asSetFilename("$(TOP)/dmm7510App/Db/accessSecurityFile.acf")

drvAsynIPPortConfigure("${PORT}", "${IPADDR}:${IPPORT} TCP",0,0,0)

## Load record instances
dbLoadRecords("${TOP}/db/dmm7510.db", "P=${P}, R=${R}, PORT=${PORT}")
dbLoadRecords("${TOP}/db/ict.db", "P=${P}, R=${R}, Instrument=${P}${R}")

< save_restore.cmd

## Run this to trace the stages of iocInit
#traceIocInit

iocInit

## Start any sequence programs

# Auxiliary tasks
seq sncDMM7510, "P=$(P), R=$(R)"

# Create manual trigger for Autosave
create_triggered_set("auto_settings_ict.req", "${P}${R}SaveTrg", "P=${P}, R=${R}")
# Also, save things every 30 seconds
create_monitor_set("auto_settings_ict.req", 30, "P=${P}, R=${R}")
set_savefile_name("auto_settings_ict.req", "auto_settings_${P}${R}.sav")
