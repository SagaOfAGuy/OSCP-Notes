#!/bin/bash

# Script that finds JS files. Parameter is $1 which should be the filename
grep -oE [T].*[.][jJ][sS] $1|awk -F "/" '{print $NF}'|sort -u
