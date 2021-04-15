# dmm7510-epics-ioc

## Overall

This repository contains EPICS IOC support for the Keithley DMM7510 digital multimeter, and also DCCT and ICT measurement application examples using the multimeter.

Most of the multimeter parameters and functions have been mapped to EPICS PVs. The goal of this IOC is to facilitate the process of building application-specific IOCs involving the DMM7510 multimeter, and facilitate multimeter configuration for testing.

Feedbacks and contributions are welcome!

## Documentation

The IOC documentation can be found in *documentation/*. There you can find a manual with the description of all DMM7510 multimeter PVs, and guides to the DCCT and ICT applications.

## Building

To build the IOC, you can follow the standard EPICS build procedure for IOC applications. The following EPICS modules are required:

- Asyn (tested with version 4.26)
- StreamDevice (tested with version 2.7.7)

The path to the required EPICS modules should be configured in the file configure/RELEASE, as the example below:

    SUPPORT=/<path>/<to>/<synApps>
    EPICS_BASE=/<path>/<to>/<epics>/<base>
    ...
    ASYN=$(SUPPORT)/<path to asyn>
    STREAM=<path to stream device>
    CALC=$(SUPPORT)/<path to calc module>
    AUTOSAVE=$(SUPPORT)/<path to autosave>

Afterwards, from the root repository directory, run `make install`. At any time, if a rebuild is required, simply run the following commands: 

    make clean uninstall
    make install

## Running

To run the IOC application, at the iocBoot/iocdmm7510 directory, run:

    ./runGenericCT.sh -i IPADDR -d DEVICE [-p IPPORT] [-P PREFIX1] [-R PREFIX2] [-l EPICS_IOC_LOG_INET] [-L EPICS_IOC_LOG_PORT]

where the options are:

- `-i IPADDR`: device IP address to connect to (required)
- `-p IPPORT`: device IP port number to connect to (default: 5025)
- `-d DEVICE`: device identifier ([DCCT<number>|ICT<number>|DMM<number>]) (required)
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-l EPICS_IOC_LOG_INET`: the IP address of the IOC log server
- `-L EPICS_IOC_LOG_PORT`: the port number of the IOC log server

## Running the OPIs

The *op/opi* directory provide CSS OPIs for easily controlling the multimeter and applications process variables. In order to run the operator interfaces it is necessary to have Control System Studio installed.

## IOC Structure

The IOC directory structure is the following:

- **configure** *(IOC configuration files)*
    - RELEASE *(It is necessary to edit the support modules' paths before building the IOC)*
    - ...
- **dmm7510App** *(Application sources)*
    - **Db** *(The database files can be found here)*
        - dmm7510.db *(DMM7510 multimeter records)*
        - dmm7510.proto *(Protocol file for DMM7510 records used by Stream Device)*
        - dcct.db *(DCCT application records)*
	- ict.db *(ICT application records)*
	- dcct_settings.req *(DCCT application autosave request file)*
	- ict_settings.req *(ict application autosave request file)*
	- accessSecurityFile.acf *(Access security file)*
	- Makefile
    - **src** *(IOC source files)*
    - Makefile
- **documentation**
    - DCCT_App_User_Guide.tex *(DCCT application documentation source)*
    - DMM7510_EPICS_IOC_Guide.tex *(DMM7510 IOC documentation source)*
    - ICT_App_User_Guide.tex *(ICT application documentation source)*
    - DB9_Cable_DMM_NPCT.tex
    - DB9_Cable_DMM_BCM.tex
    - **figs** *(Documentation resources)*
- **iocBoot** *(Boot)*
    - **iocdmm7510**
        - Makefile
        - **autosave** *(Save files are placed here by autosave)*
        - DMM7510.config *(DMM7510 env vars - not in use)*
        - DCCT.config *(DCCT env vars - not in use)*
        - ICT.config *(ICT env vars - not in use)*
        - README
        - runProcServ.sh *(Run runGenericCT.sh in procServ)*
        - save_restore.cmd *(Contain all autosave configurations)*
        - auto_settings_dmm7510.req *(Autosave request file for DMM7510)*
        - auto_settings_dcct.req *(Autosave request file for DCCT)*
        - auto_settings_ict.req *(Autosave request file for ICT)*
        - checkEnv.sh
        - parseCMDOpts.sh
        - runDMM7510.sh *(Run DMM7510 PVs only)*
        - runDCCT.sh *(Run DCCT application and DMM7510 PVs)*
        - runICT.sh *(Run ICT application and DMM7510 PVs)*
        - runGenericCT.sh *(Run DMM, DCCT, or ICT mode depending on the given option)*
        - stDMM7510.cmd *(DMM7510 startup file)*
        - stDCCT.cmd *(DCCT application startup file)*
        - stICT.cmd *(ICT application startup file)*
    - Makefile
- Makefile *(IOC Makefile)*
- op *(Operator Interfaces)*
    - **opi**
        - dmm7510.opi *(DMM7510 OPI)*
        - dcct.opi *(DCCT application OPI)*
        - ict.opi *(ICT application OPI)*
        - ict_raw.opi *(ICT Raw data OPI)*
- install *(Installation scripts)*
- scripts *(General scripts)*
- README.md *(This file)*
