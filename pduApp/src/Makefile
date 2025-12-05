TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = pdu
# pdu.dbd will be created and installed
DBD += pdu.dbd

# pdu.dbd will be made up from these files:
pdu_DBD += base.dbd

# Include dbd files from all support applications:
pdu_DBD += pscCore.dbd

# Add all the support libraries needed by this IOC
pdu_LIBS += pscCore 

# pdu_registerRecordDeviceDriver.cpp derives from pdu.dbd
pdu_SRCS += pdu_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
pdu_SRCS_DEFAULT += pduMain.cpp
pdu_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#pdu_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
pdu_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

