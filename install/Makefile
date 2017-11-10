TOP = ..
include $(TOP)/configure/CONFIG

ioc_name=$(shell basename $(realpath ${TOP}))

all:

install:
	$(TOP)/install/install.sh /opt/epics/startup/ioc/${ioc_name} $(TOP)

uninstall:
	$(TOP)/install/uninstall.sh /opt/epics/startup/ioc/${ioc_name} $(TOP)

realuninstall: uninstall

clean:

realclean: clean

distclean: realclean realuninstall

mrproper: clean

