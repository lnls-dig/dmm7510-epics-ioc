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

1. The first step when configuring the IOC is making sure that the paths to support modules in the RELEASE file (*configure/RELEASE*) are correct.

2. The second step is to edit the IOC startup script (*iocBoot/iocdmm7510/st.cmd*) to provide the multimeter network address to asynDriver and make sure that the multimeter *.db* file is loaded with the right prefixes and communication port.

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

The DMM7510 PVs are composed of four parts: The user-defined prefix, the PV property name, the property field, and the suffix.

```
$(P)$(R)Prop.FIELD-Suffix
```
*P* and *R* can be set in the *st.cmd* file, when loading the *.db* file. The PV suffix indicates its input type, as follows:
* SP (Set Point): A non-enumerated value (real number or string). It sets a system parameter.
* RB (Read Back): A non-enumerated value (real number or string). Read-only. It displays the read back value of a parameter, providing confirmation to changes.
* Sel (Selection): Enumerated value. Sets a system parameter.
* Sts (Status): Enumerated value. Read-only. It displays the read back value of an enumerated parameter, providing confirmation to changes.
* Cmd (Command): Binary command. It causes a given action to be executed.

## DCCT and ICT Applications PV Structure

The PVs for the DCCT and ICT applications follow the DISCS Collaboration naming convention, which is adopted by the Sirius Light Source.

```
$(Sec)-$(Sub):$(Dis)-$(Dev)$(Idx):Prop.FIELD-Suffix
```

The prefix macro substitution strings are defined by *Sec*, *Sub*, *Dis*, *Dev*, and *Idx*. When *Idx* is used, a *-* character should be added before the number in order to follow the convention.

## Running the OPIs

The *OPI/CSS* directory provide OPIs for easily controlling the multimeter and applications process variables. In order to run the operator interfaces it is necessary to have Control System Studio installed. It is recommended to run `cs-studio` in the OPI folder, in order to avoid having to reconfigure CS-Studio preferences.
