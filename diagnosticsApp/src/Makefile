TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS BELOW HERE

#=============================
# Build an IOC support library
LIBRARY_IOC += diagnosticsSupport

# Link locally-provided code into the support library,
# rather than directly into the IOC application.
# This is required for Windows DLL builds.
diagnosticsSupport_SRCS += initTrace.c

diagnosticsSupport_LIBS += $(EPICS_BASE_IOC_LIBS)

#=============================
# Build the IOC application
PROD_IOC = diagnostics

# diagnostics.dbd will be created and installed
DBD += diagnostics.dbd

# diagnostics.dbd will include these files:
diagnostics_DBD += base.dbd
diagnostics_DBD += initTrace.dbd

# diagnostics_registerRecordDeviceDriver.cpp derives from diagnostics.dbd
diagnostics_SRCS += diagnostics_registerRecordDeviceDriver.cpp

# Build the main IOC entry point where needed
diagnostics_SRCS_DEFAULT += diagnosticsMain.cpp
diagnostics_SRCS_vxWorks += -nil-

# Link in the code from our support library
diagnostics_LIBS += diagnosticsSupport

# To build SNL programs, SNCSEQ must be defined
# in the <top>/configure/RELEASE file
ifneq ($(SNCSEQ),)
    # Build sncExample into diagnosticsSupport
    sncExample_SNCFLAGS += +r
    diagnostics_DBD += sncExample.dbd
    diagnosticsSupport_SRCS += sncExample.stt
    diagnosticsSupport_LIBS += seq pv
    diagnostics_LIBS += seq pv

    # Build sncProgram as a standalone program
    PROD_HOST += sncProgram
    sncProgram_SNCFLAGS += +m
    sncProgram_SRCS += sncProgram.st
    sncProgram_LIBS += seq pv
    sncProgram_LIBS += $(EPICS_BASE_HOST_LIBS)
endif

# Finally link IOC to the EPICS Base libraries
diagnostics_LIBS += $(EPICS_BASE_IOC_LIBS)

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD EXTRA GNUMAKE RULES BELOW HERE

diagnostics_DBD += drvAsynIPPort.dbd
diagnostics_DBD += drvVxi11.dbd
diagnostics_DBD += stream.dbd
diagnostics_DBD += calcSupport.dbd
diagnostics_DBD += asSupport.dbd

diagnostics_LIBS += asyn
diagnostics_LIBS += stream
diagnostics_LIBS += calc
diagnostics_LIBS += autosave
