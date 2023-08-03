
#!/bin/bash

# Check if a directory path is provided as a command-line argument
if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory_path>"
    exit 1
fi

directory_path="$1"

# Check if the specified directory exists
if [ ! -d "$directory_path" ]; then
    echo "Error: Directory does not exist!"
    exit 1
fi

# Create a timestamp for the backup folder
timestamp=$(date +%Y%-m%-d%)
backup_folder="$directory_path/backup_$timestamp"

# Create a backup folder with the timestamp
backup_folder="$directory_path/backup_$timestamp"

#taking backup
rsync -a "$backup_path/$backup_folder/"

#perform rotation to keep only the last 3 backups
backup_count=$(ls -l "$directory_path/backup_*" | wc -l)

#checking rotation to  take only the last 3 backup
if [ $backup_count -gt 3]; then
	ls -t "$direcory_path"/backup_* |tail -n +4 | xargs -r rm
fi

echo "backup taken!"



