#!/bin/bash

check_privileges() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "Error: This script requires root privileges to execute."
        exit 1
    fi
}

print_home_directory() {
	echo "Home Directory: $HOME"
}

list_usernames() {
    echo "Usernames:"
    getent passwd | cut -d: -f1
}

count_users() {
    echo "Number of users: $(getent passwd | wc -l)"
}

find_home_directory() {
    read -p "Enter username: " username
    home_directory=$(getent passwd "$username" | cut -d: -f6)
    echo "Home directory of $username: $home_directory"
}

list_users_by_uid_range() {
    read -p "Enter UID range (e.g., 1000-1010): " uid_range
    echo "Users with UID in range $uid_range:"
    awk -F: '{ if ($3 >= min && $3 <= max) print $1 }' min="${uid_range%-*}" max="${uid_range#*-}" /etc/passwd
}

find_users_with_standard_shells() {
    echo "Users with standard shells (/bin/bash or /bin/sh):"
    getent passwd | awk -F: '{ if ($7 == "/bin/bash" || $7 == "/bin/sh") print $1 }'
}

replace_slash() {
    sed 's/\//\\/g' /etc/passwd > /tmp/passwd_new
    echo "Content with '/' replaced by '\': /tmp/passwd_new"
}

print_private_ip() {
    echo "Private IP: $(hostname -I)"
}

print_public_ip() {
    echo "Public IP: $(curl -s ifconfig.me)"
}

switch_to_john_user() {
    echo "Switched user to john"
    echo "John hom directory:"
    su - john -c "echo ~john"
}



main() {
    check_privileges

    if [ "$1" != "/etc/passwd" ]; then
        echo "Error: Argument 'name' must be the path to /etc/passwd."
        exit 1
    fi

    print_home_directory
    count_users
    find_home_directory
    list_users_by_uid_range
    find_users_with_standard_shells
    replace_slash
    print_private_ip
    print_public_ip
    switch_to_john_user
}

main "$1"
