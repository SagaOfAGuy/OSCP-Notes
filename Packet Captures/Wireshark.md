## Wireshark

### Install Wireshark
```bash
sudo apt install wireshark
```

### Start Wireshark
```bash
sudo wireshark &
```

### Packet Capture Filtering
Filter by port: `tcp.port == 21` 

![image](https://user-images.githubusercontent.com/68156940/205453198-a3624e59-1066-4cb4-86fc-f3273707b219.png)

Follow TCP Stream - Allows us to see packet stream in TCP

Right-Click packet > Follow > TCP Stream:

![image](https://user-images.githubusercontent.com/68156940/205453669-f90461a1-d50f-41d0-8daa-bd500074f5b9.png)
