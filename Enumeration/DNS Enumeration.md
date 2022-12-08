## DNS Enumeration

### Resolve IP address of Domain
```bash
host www.google.com
```
**OR**

```bash
nslookup google.com
```

### Find Mail Record Entries
Mail records are **names of servers responsible for handling mail for a domain**
```bash
host -t mx google.com
```
### Find Nameserver Entries
Nameserver entries contain names of the servers that host DNS records for a domain
```bash
host -t ns google.com
```

### Find 'A' Record (IP Address of hostname)
'A Records' contain the IP addresses of a hostname
```bash
host -t a google.com
```

### Find Pointer records 
Pointer records are used to find records associated with an **IP Address**
```bash
host -t ptr $IP_ADDRESS
```
### Find Canonical Name records
Canonical names are aliases for other hosts
```bash
host -t -cname $IP_ADDRESS
```

### Find Text records
Text records are arbitrary data that can be used for domain ownership verification
```bash
host -t txt $IP_ADDRESS
```

