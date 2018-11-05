TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

#=============================
# Build an IOC support library
LIBRARY_IOC += dmm7510Support

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
# This is required for Windows DLL builds.
dmm7510Support_SRCS += initTrace.c

dmm7510Support_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application
PROD_IOC = dmm7510

# dmm7510.dbd will be created and installed
DBD += dmm7510.dbd

# dmm7510.dbd will include these files:
dmm7510_DBD += menuScan.dbd
dmm7510_DBD += base.dbd
dmm7510_DBD += initTrace.dbd

# dmm7510_registerRecordDeviceDriver.cpp derives from dmm7510.dbd
dmm7510_SRCS += dmm7510_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
dmm7510_SRCS_DEFAULT += dmm7510Main.cpp
dmm7510_SRCS_vxWorks += -nil-

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncDMM7510 into dmm7510Support
    sncDMM7510_SNCFLAGS += +r
    dmm7510_DBD += sncDMM7510.dbd
    dmm7510Support_SRCS += sncDMM7510.stt
    dmm7510Support_LIBS += seq pv
    dmm7510_LIBS += seq pv

    # Build sncDMM7510Program as a standalone program
    PROD_HOST += sncDMM7510Program
    sncDMM7510Program_SNCFLAGS += +m
    sncDMM7510Program_SRCS += sncDMM7510Program.st
    sncDMM7510Program_LIBS += seq pv
    sncDMM7510Program_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Link in the code from our support library
dmm7510_LIBS += dmm7510Support

# Finally link IOC to the EPICS Base libraries
dmm7510_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

dmm7510_DBD += drvAsynIPPort.dbd
dmm7510_DBD += drvVxi11.dbd
dmm7510_DBD += stream.dbd
dmm7510_DBD += calcSupport.dbd
dmm7510_DBD += asSupport.dbd

dmm7510_LIBS += asyn
dmm7510_LIBS += stream
dmm7510_LIBS += calc
dmm7510_LIBS += autosave
