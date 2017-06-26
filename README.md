# dmm7510-epics-ioc

## Overall

This repository contains EPICS IOC support for the Keithley DMM7510 digital multimeter, and also DCCT and ICT applications examples using the multimeter.

Most of the multimeter parameters and functions have been mapped to EPICS PVs. The goal of this IOC is to facilitate the process of building application-specific IOCs involving the DMM7510 multimeter, and facilitate multimeter configuration for testing.

Feedbacks and contributions are welcome!

## Documentation

The IOC documentation can be found in *Doc/*. There you can find a manual with the description of all DMM7510 multimeter PVs, a guide to the DCCT application, and another to the ICT application.

## IOC Structure

- accessSecurityFile.acf *(IOC access file)*
- **autosave** *(Autosave files)*
    - **request_files** *(Autosave request files)*
        - autosave_dcct1.req *(Example DCCT 1 autosave request file)*
        - autosave_ict1.req *(Example ICT 1 autosave request file)*
- **configure** *(IOC configuration files)*
    - CONFIG
    - CONFIG_SITE
    - Makefile
    - RELEASE *(Necessary to edit support modules' paths when first running the IOC)*
    - RULES
    - RULES_DIRS
    - RULES.ioc
    - RULES_TOP
- **dmm7510App** *(Application sources)*
    - **Db** *(The database files can be found here)*
        - dmm7510.db *(DMM7510 multimeter records)*
        - dmm7510.proto *(Protocol file for DMM7510 records used by Stream Device)*
        - dcct.db *(DCCT application records)*
	- ict.db *(ICT application records)*
    - **src** *(IOC source files)*
        - dmm7510Main.cpp
        - Makefile
    - Makefile
- **Doc** *(Documentation)*
    - DCCT_App_User_Guide.tex *(DCCT application documentation source)*
    - DMM7510_EPICS_IOC_Guide.tex *(DMM7510 IOC documentation source)*
    - ICT_App_User_Guide.tex *(ICT application documentation source)*
    - **figs** *(Documentation resources)*
        - dcct-meas-param1-image.pdf
        - dcct-meas-param3-image.pdf
        - ict-meas-param-image.pdf
        - ict-setup-image.pdf
        - logo_lnls.jpg
        - dcct-meas-param2-image.pdf
        - dcct-setup-image.pdf
        - ict-meas-scheme-image.pdf
        - logo_cnpem.jpg
- **iocBoot** *(Boot)*
    - **iocdmm7510**
        - Makefile
        - README
        - st.cmd *(Startup script)*
    - Makefile
- Makefile *(IOC Makefile)*
- OPI *(Operator Interfaces)*
    - **configuration** *(CS-Studio configuration)*
        - **diirt**
            - **datasources**
                - **ca**
                    - ca.xml
                - datasources.xml
    - **CSS** *(CS-Studio OPIs)*
        - dcct.opi *(DCCT Application OPI)*
        - dmm7510.opi *(DMM7510 OPI)*
        - ict.opi *(ICT OPI)*
- README.md *(This file)*

## Initialization

1. In order to run this IOC you need to have **EPICS Base 3.14**, **SynApps 5.8**, and **StreamDevice 2-7-7** installed. The first step when configuring the IOC is making sure that the paths to support modules in the RELEASE file (*configure/RELEASE*) are correct. Set the following lines in the file:

    ```
    SUPPORT=/<path>/<to>/<synApps>
    EPICS_BASE=/<path>/<to>/<epics>/<base>
    ...
    ASYN=$(SUPPORT)/<path to asyn>
    STREAM=<path to stream device>
    CALC=$(SUPPORT)/<path to calc module>
    AUTOSAVE=$(SUPPORT)/<path to autosave>
    ```

2. The second step is to edit the IOC startup script (*iocBoot/iocdmm7510/st.cmd*) to provide the multimeter network address to asynDriver and make sure that the multimeter *.db* file is loaded with the right prefixes and communication port. The *IOC Settings* section, in the beggining of the *st.cmd* file, defines the key macro substitution strings for the script.

    1. Insert the DMM7510 network address in the following line:

        ```
        # DMM7510 IP address -------------------------
        epicsEnvSet DMMADDR "<DMM7510 IP address goes here>"
        # --------------------------------------------
        ```

    2. To define the prefixes for the DMM7510 PVs, edit the following lines:

        ```
        ## Naming Convention for DMM7510 -------------
        # P
        epicsEnvSet PDMM "<DMM7510 P prefix goes here>"
        # R
        epicsEnvSet RDMM "<DMM7510 R prefix goes here>"
        # --------------------------------------------
        ```

    3. To define the prefixes for the DCCT application PVs, edit the following lines:

        ```
        ## Naming Convention for DCCT ----------------
        # P
        epicsEnvSet PDCCT "<DCCT P prefix goes here>"
        # R
        epicsEnvSet RDCCT "<DCCT R prefix goes here>"
        # --------------------------------------------
        ```

    4. To define the prefixes for the ICT application PVs, edit the following lines:

        ```
        ## Naming Convention for ICT ----------------
        # P
        epicsEnvSet PICT "<ICT P prefix goes here>"
        # R
        epicsEnvSet RICT "<ICT R prefix goes here>"
        # --------------------------------------------
        ```

    5. To enable DMM7510 PVs, set *DMM_line* to "":

        ```
        # Enable/disable module lines ----------------
        epicsEnvSet DMM_line ""
        ```
    
    6. To disable DMM7510 PVs, set *DMM_line* to "#":

        ```
        # Enable/disable module lines ----------------
        epicsEnvSet DMM_line "#"
        ```
    
    7. In order to enable DMM7510 and DCCT PVs, set both *DMM_line* and *DCCT_line* to "", and set *ICT_line* to "#" to disable ICT PVs.

        ```
        # Enable/disable module lines ----------------
        epicsEnvSet DMM_line ""
        epicsEnvSet DCCT_line ""
        epicsEnvSet ICT_line "#"
        ```

    8. In order to enable DMM7510 and ICT PVs, set both *DMM_line* and *ICT_line* to "", and set *DCCT_line* to "#" to disable DCCT PVs.

        ```
        # Enable/disable module lines ----------------
        epicsEnvSet DMM_line ""
        epicsEnvSet DCCT_line "#"
        epicsEnvSet ICT_line ""
        ```

3. To build the IOC application, in the IOC top level directory, enter the following shell command:

    ```sh
    $ make clean uninstall install
    ```

4. Go to the startup script directory and make sure that you have permission to run it:

    ```sh
    $ cd iocBoot/iocdmm7510
    $ chmod +x st.cmd
    ```

5. Run the startup script:

    ```sh
    $ ./st.cmd
    ```

## DMM7510 PV Structure

The PVs' structure in this IOC is composed of four parts: Two user-defined prefixes (*P* and *R*), the PV property name and field, and the suffix.

    ```
    $(P)$(R)Prop.FIELD-Suffix
    ```

The prefixes are defined in the *st.cmd* startup script, when loading a *.db* file. The suffixes indicate the PV input type, and can be one of the following:

* SP (Set Point): A non-enumerated value (real number or string). It sets a system parameter.
* RB (Read Back): A non-enumerated value (real number or string). Read-only. It displays the read back value of a parameter, providing confirmation to changes.
* Sel (Selection): Enumerated value. Sets a system parameter.
* Sts (Status): Enumerated value. Read-only. It displays the read back value of an enumerated parameter, providing confirmation to changes.
* Cmd (Command): Binary command. It causes a given action to be executed.

## Running the OPIs

The *OPI/CSS* directory provide OPIs for easily controlling the multimeter and applications process variables. In order to run the operator interfaces it is necessary to have Control System Studio installed. It is recommended to run `cs-studio` in the OPI folder, in order to avoid having to reconfigure CS-Studio preferences.
