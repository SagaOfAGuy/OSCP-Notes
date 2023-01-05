# SMB Enumeration

## SMB NSE Script Enumeration

NSE script to enumerate SMB OS version
```
sudo nmap -v -p 139, 445 --script=smb-os-discovery $IP
```
Runs NSE SMB vuln scripts that won't crash the target machine
```
nmap -v -p 139,445 --script=smb-vuln-* --script-args=safe=1 $IP
```
Runs NSE SMB vuln scripts that won't crash the target machine
```
nmap -v -p 139,445 --script=smb-vuln-* --script-args $IP
```
 Runs all NSE SMB scripts against ports 139 and 445 that are SAFE
```
nmap -v -p 139,445 --script=smb-* --script-args=safe=1 $IP
```
 Runs all NSE SMB Scripts against 139/445 regardless of safety
```
nmap -v -p 139,445 --script=smb-* $IP
```
List SMB Shares
```
nmap --script smb-enum-shares -p139,445 $IP
```
Toggle safety argument and look for Vulnerability **MS08-067**. Unsafe means that it may crash the host.
```
sudo nmap -v -p 139,445, --script=smb-vuln-ms08-067 --script-args=unsage=1 $IP
```



## SMBClient 

List shares compatible with NT1 protocol 
```
smbclient --option='client min protocol=NT1' -L $IP  
```
List shares compatible with LANMAN1 protocol
```
smbclient --option='client min protocol=LANMAN1' -L $IP
```
List available SMB Shares 
```
smbclient -L $IP
```
List available SMB Shares (Authenticated)
```
smbclient -L $IP -U user%pass
```
Connect to existing SMB Share
```
smbclient \\\\<ip>\\<sharename>

smbclient //$IP/<sharename>
```
Connect to existing SMB Share (Authenticated)
```
smbclient //$IP/<sharename> -U user%pass
```
Login to SMB as user
```
smbclient --user=$user//$IP/$sharename
```
Download files within smbclient
```
smb: \> get file.txt
```
Download all files within SMB share:
```
smb: \> mget 
```


## SMBMap

List SMB Shares
```
smbmap -H $IP
```
List share with username and password
```
smbmap -H $IP -u $USER -p $PASSWORD
```
List SMB Shares recursively
```
smbmap -H $IP -R
```


## RPClient

Running null session on rpcclient:
```
rpclient -u "" $IP
```
Getting server info:
```
rpclient> srvinfo
```
Enumerating users:
```
rpclient> enumdomusers
```



## Enum4Linux

Scan machine for SMB information: 
```
enum4linux $IP
```


## CrackMapExec

List SMB Shares (Unauthenticated)
```
crackmapexec smb $IP -u '' -p '' --shares
```
List SMB Shares (Authenticated)
```
crackmapexec smb $IP -u 'admin' -p 'password' --shares
```


## NBTScan - Enumerating NetBIOS

Scan host for NetBIOS:
```
sudo nbtscan -r $IP
```
Scan entire subnet for NetBIOS
```
sudo nbtscan -r $IP/24
```


## NMBLookup - Enumerating NetBIOS

Scan host:
```
nmblookup -A $IP
```


## Metasploit - SMB Shares Scanner

SMB Shares Scanner (Unauthenticated)
```
msfconsole -q -x 'use auxiliary/scanner/smb/smb_enumshares; set rhost $IP; exploit'
```
SMB Shares Scanner (Authenticated)
```
msfconsole -q -x 'use auxiliary/scanner/smb/smb_enumshares; set rhost $IP; exploit; set smbuser $USER; set smbpass $PASS'
```



## Finding Samba Version

Script to find Samba server version:
```
#!/bin/sh
#Author: rewardone
#Description:
# Requires root or enough permissions to use tcpdump
# Will listen for the first 7 packets of a null login
# and grab the SMB Version
#Notes:
# Will sometimes not capture or will print multiple
# lines. May need to run a second time for success.
if [ -z $1 ]; then echo "Usage: ./smbver.sh RHOST {RPORT}" && exit; else rhost=$1; fi
if [ ! -z $2 ]; then rport=$2; else rport=139; fi
tcpdump -s0 -n -i tap0 src $rhost and port $rport -A -c 7 2>/dev/null | grep -i "samba\|s.a.m" | tr -d '.' | grep -oP 'UnixSamba.*[0-9a-z]' | tr -d '\n' & echo -n "$rhost: " &
echo "exit" | smbclient -L $rhost 1>/dev/null 2>/dev/null
echo "" && sleep .1
```



## Mounting SMB shares to attack machine

Make sure cifs  and cifs-helper  are installed:
```
sudo apt install cifs cifs-utils
```
Create a directory in /mnt :
```
sudo mkdir -p /mnt/user
```
Mount the Samba share:
```
sudo mount -t cifs //$IP/<share name> /mnt/user
```


## Unmount SMB Share

```
sudo umount -a -t cifs -l
```
