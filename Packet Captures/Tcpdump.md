## TCPdump
Command-line tool to capture packets 

### Analyzed captured pcap file
```bash
sudo tcpdump -r $FILE.pcap
```

### Filter pcap files
```bash
sudo tcpdump -n -r $FILE.pcap|awk -F" " '{print $5}' | sort | uniq -c | head
```

### Filter by Host
```bash
sudo tcpdump -n src host $IP -r $FILE.pcap
```

### Filter by Destination
```bash
sudo tcpdump -n dst host $IP -r $FILE.pcap
```
### Filter by Port 
```bash
sudo tcpdump -n port $PORT -r $FILE.pcap
```

### Filter packet
```bash
sudo tcpdump -nX -r $FILE.pcap
```
