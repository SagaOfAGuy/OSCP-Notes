## NFS Enumeration

### Scanning via Nmap
```
sudo nmap -v -p 111 $IP
```

### Scanning via Nmap with NSE script
```
sudo nmap -sV -p 111 --script=rpcinfo $IP
```

```
sudo nmap -sV -p 111 --script nfs* $IP
```

### Mount NFS share
1. Mount NFS share
```
sudo mount -o nolock $IP:/$SHARE_PATH
```
2. If we still can't view the path mounted, create user that has the same UID as specified in the permissions output via `ls -aril`

```
sudo useradd -u $UID $USER
```
3. Become created user, and see if you can view the restricted file
```
su $USER
```
