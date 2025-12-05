#!../../bin/linux-x86_64/pdu

< envPaths

epicsEnvSet("IOCNAME", "BPC")

cd "${TOP}"

## Register all support components
dbLoadDatabase "dbd/pdu.dbd"
pdu_registerRecordDeviceDriver pdbbase


var("PSCDebug", "5")

# Listen on 0.0.0.0:1234  (pass zero for random port)
# for messages coming from "device" localhost:5000

createPSCUDP("pscudp1", "10.0.142.199", 5000, 1234)
#createPSCUDP("pscudp2", "10.0.142.187", 5000, 1235)

## Load record instances
dbLoadRecords("db/bpc.db","P=$(IOCNAME), NO=1")
#dbLoadRecords("db/bpc.db","P=$(IOCNAME), NO=2")




cd "${TOP}/iocBoot/${IOC}"
iocInit
