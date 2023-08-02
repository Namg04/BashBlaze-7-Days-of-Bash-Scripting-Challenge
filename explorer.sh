#!/bin/bash

#Display welcome message list files and directories
echo "Welcome to the Interactive File and Directory Explorer!"

#List all files and directories in the current path
echo "Listing all files and directories in the current path: $pwd"
ls -al


while true; do

#Character counting
    read -p "Enter a line of text (Press Enter without text to exit):  " input

  
#Check if the input is empty (in case user presses Enter wihtout any text)
# -z is a test operator used to check if the given string is empty

    if [ -z "$input" ]; then
        echo "Exiting the Interactive Explorer. Goodbye!"
        break
    fi

#count & display the number of characters in the entered text
#Symbol(#) is used in context to denite the length of the variable's value.
#So, ${#user_input} returns the number of character in the value of the input variable.

    
    echo "Character Count: ${#input}"

done









