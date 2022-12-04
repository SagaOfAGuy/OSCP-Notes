#!/bin/bash 
read -p "Enter username: " username 
read -p "Enter group: " group 

# Both not found 
! $(grep -q $username /etc/passwd) && ! $(grep -q $group /etc/group) && echo "Both are not found - why are you even asking me this?" && exit 

# only one found 
$(grep -q $username /etc/passwd) && ! $(grep -q $group /etc/group) && echo "One exists one does not. You figure out which." && exit

! $(grep -q $username /etc/passwd) && $(grep -q $group /etc/group) && echo "One exists one does not. You figure out which." && exit

# Membership
$(groups $group | grep -q $username) && echo "Membership valid!" || echo "Membership invalid but available to join" && exit
