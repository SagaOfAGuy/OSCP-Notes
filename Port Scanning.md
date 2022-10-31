# NMAP Scanning

## Manual Scanning
https://nmap.org/book/
- Fast Full System Scan - Top 20 ports
```bash
sudo nmap --max-retries 2 -A -sV -sC -sU -sT -Pn $IP --version-intensity 0 --script=*enum --top-ports 20 | tee fullscan.txt
```
- Full System Scan - Top 20 ports
```bash
sudo nmap -A -sV -sC -sU -sT -Pn $IP --version-intensity 0 --script=*enum --top-ports 20 | tee fullscan.txt
```
- Fast Full System Scan - Top 100 ports
```bash
sudo nmap --max-retries 2 -A -sV -sC -sU -sT -Pn $IP --version-intensity 0 --script=*enum --top-ports 100 | tee fullscan.txt
```
- Full System Scan - Top 100 ports
```bash
sudo nmap -A -sV -sC -sU -sT -Pn $IP --version-intensity 0 --script=*enum --top-ports 100 | tee fullscan.txt
```




## Rustscan
https://github.com/RustScan/RustScan

1. Install `rustscan` package
```bash
wget https://github.com/RustScan/RustScan/archive/refs/tags/2.1.0.zip
```
2. Install package into `dpkg`
```bash
dpkg -i $FILE
```
3. Confirm** `rustscan` works
```bash
rustscan --version
```
<ins>Examples</in>

```
rustscan -a $IP | tee fullscan.txt
```

## Autorecon
https://github.com/Tib3rius/AutoRecon

Install `autorecon`
```bash
python3 -m pip install git+https://github.com/Tib3rius/AutoRecon.git
```
<ins>Examples</ins>

Default Scan
```bash
autorecon $IP 
```

## NmapAutomator
https://github.com/21y4d/nmapAutomator

Install `nmapAutomator`
```bash
git clone https://github.com/21y4d/nmapAutomator.git
sudo ln -s $(pwd)/nmapAutomator/nmapAutomator.sh /usr/local/bin/
```
<ins>Examples</ins>

Scan everything
```bash
nmapAutomator -H $IP -t all 
```
