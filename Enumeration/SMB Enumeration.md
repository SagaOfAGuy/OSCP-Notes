# SMB Enumeration

### Scan for NetBIOS services
NetBIOS listens on ports 139 and 445:
```
sudo nmap -v -p 139,445 -oG smb.txt $IP
```
### Scan for NetBIOS using nbtscan
Using `nbtscan`:
```
sudo nbtscan -r $IP/24
```
### Using Nmap SMB NSE Scripts
Using NSE scripts:
```
sudo nmap -v -p 139,445 --script=smb-os-discovery $IP
```
Toggle safety argument and look for Vulnerability **MS08-067**. Unsafe means that it may crash the host.
```
sudo nmap -v -p 139,445, --script=smb-vuln-ms08-067 --script-args=unsage=1 $IP
```

