#!/bin/bash

#Function to display usage information and available options

function usage {
        echo "usage: $0 [OPTIONS]"
        echo "Options:"
        echo " -c, --create Create a new user account"
        echo " -d, --delete Delete an existing user account"
        echo " -r, --reset  Reset the password of an existing user account"
        echo " -l, --list   Lias all user accounts on the system"
        echo " -h, --help   Display help message"
}

# Function to create new user account

function create_user_account {
    read -p "Enter new username: " username

   #check if user already exist
   if id "$username" &>/dev/null; then
        echo "The username '$username' already exists. Please add a different username!"
            
    else
        #prompt for password
        read -p "Enter the password for '$username': " password
        
        #create new user account
        useradd -m "$username" --create-home --password "$password"
        echo "User Account '$username' created successfully"
    fi
}

#Function to delete an existing user account

function delete_user_account {
    read -p "Enter the username to delete: " username

    #check if the user exists already
    if id "$username" &>/dev/null; then
        userdel -r "$username" 
        echo "User Account '$username' deleted."
    else
        echo "Username '$username' does not exist."
    fi
}

#Function to reset password for existing user account

function reset_password {
    read -p "Enter username to reset password: " username

    #check if user exists already
    if id "$username" &>/dev/null; then

        #promt for password
        read -p "Enter the new password for $username: " password

        #set new password
        echo "$username:$password" | chpasswd
        echo "Password for user account '$username' reset successfully."
    else
        echo "Username does not exist."
    fi
}

#Function to list all user accounts on the system

function list_users {
    echo "User accounts in the system:"
    # awk to print usernames and UIDs from /etc/passwd
    cat /etc/passwd | awk -F: '{ print "- " $1 " (UID: "$3 ")" }'
}


# If no arguments are provided or if the -h or --help option is given
if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage
    exit 0
fi


#Command line argument parsing
while [ $# -gt 0 ]; do
    case "$1" in
    -c|--create)
        create_user_account
        ;;
    -d|--delete)
        delete_user_account
        ;;
    -r|--reset)
        reset_password
        ;;
    -l|--list)
        list_users
        ;;
    -h|--help)
        display_usage
        ;;
    *)
        echo " Invalid option '$1'. Use '--help' to see available options."
        exit 1
        ;;
    esac
    shift
done


