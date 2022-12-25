## SNMP Enum
Service responsible for 

### Nmap scan
```
sudo nmap -sU --open -p 161 $IP -oG snmp_scan.txt
```

### SNMP enum for Windows Systems

**Enumerating entire MIB Database**
```
snmpwalk -c public -v1 -t 10 $IP
```
`-c` is for community string

`-v` specifies SNMP version. Usually versions 1 & 2 are more likely to have vulns

`-t` timeout variable

**Enumerating Windows Users**
```
snmpwalk -c public -v1 $IP 1.3.6.1.4.1.77.1.2.25
```

**Enumerating Running Processes in Windows**
```
snmpwalk -c public -v1 $IP 1.3.6.1.2.1.25.4.2.1.2
```

**Enumerating open TCP ports** 
```
snmpwalk -c public -v1 $IP 1.3.6.1.2.1.6.13.1.3
```
**Enumerating installed softwares**
```
snmpwalk -c public -v1 $IP 1.3.6.1.2.1.25.6.3.1.2
```
