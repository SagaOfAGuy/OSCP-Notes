## Bash Scripting

### Creating Bash Scripts
Create file: 
```bash
cat file.sh
```

Make it reference `bash` interpreter
```bash
echo "#!/bin/bash" >> file.sh
```

Make executable: 
```bash
chmod +x file.sh
```

### Script Arguments
Example bash script calling arguments: 
```bash
#!/bin/bash

echo "The first two arguments are $1 and $2"
```
**NOTE:** *`$1` and `$2` refer to the first 2 parameters of the script*

Run script with the 2 parameters: 
```bash
./arg.sh hello there
```

### Reading User Input
```bash
#!/bin/bash
# Prompt the user for credentials

read -p 'Username: ' username
read -sp 'Password: ' password

echo "Thanks, your creds are as follows: " $username " and " $password
```
**NOTE:** *The `read -p 'Username: ' username` part of the script reads in the `username` variable*

**NOTE:** *The `read -sp 'Password: ' password` reads in the `password` field silently*

### If/Else/Elif Statements
```bash
#!/bin/bash
age=16
if [ $age -gt 16 ];
then
  echo "You are over 16"
elif [ $age -eq 16 ];
then
  echo "You are exactly 16"
else
  echo "You are not over 16"
fi
```
### Logical Operators

| Operator      | Effect        |
| ------------- | ------------- |
| COMMAND1 && COMMAND2            | COMMAND2 only runs *only if* COMMAND1 runs successfully  |
| COMMAND1 \|\| COMMAND2           | COMMAND2 run *only if* COMMAND1 fails  |


### Loops
 
For Loops
```bash
for num in $(seq 1 10); do
  echo $num
done
```

**OR**

```bash
for num in ${1..10}; do
  echo $num
done
```

While Loops
```bash
counter=1

while [ $counter -lt 10 ];
do
  echo $counter
  ((counter++))
done
```

### Functions
Can use functions to encapsulate bash code
```bash
function method() { 
  echo "Hello"
}

# Call the method below
method
```



