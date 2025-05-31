#!/bin/bash

# Ensure gum is installed
command -v gum >/dev/null 2>&1 || {
  echo "gum is required. Install it from https://github.com/charmbracelet/gum"
  exit 1
}

# Step 1: List block devices
DEVICES=$(lsblk -dno NAME,SIZE,MODEL | awk '{print "/dev/" $1 " (" $2 " - " $3 ")"}')
DEVICE_SELECTION=$(echo "$DEVICES" | gum choose --header="Select the USB device to format:")
DEVICE=$(echo "$DEVICE_SELECTION" | awk '{print $1}')

[ -z "$DEVICE" ] && echo "No device selected. Exiting." && exit 1

# Step 2: Confirm data deletion
gum confirm "⚠️  All data on $DEVICE will be erased. Continue?" || exit 1

# Step 3: Choose partition table type
LABEL=$(gum choose --header="Select partition table type: " gpt msdos)
sudo parted -s "$DEVICE" mklabel "$LABEL"

# Step 4: Ask how many partitions
PART_COUNT=$(gum input --prompt="How many partitions do you want to create? " --placeholder="1")
[[ ! "$PART_COUNT" =~ ^[0-9]+$ ]] && echo "Invalid number." && exit 1

# Step 5: Loop through and create partitions
START="1MiB"
for ((i = 1; i <= PART_COUNT; i++)); do
  echo "Creating partition $i..."

  END=$(gum input --prompt="Enter END for partition $i (e.g., 512MiB, 100%) " --placeholder="100%")
  [ -z "$END" ] && echo "No end entered. Exiting." && exit 1

  sudo parted -s "$DEVICE" mkpart primary "$START" "$END"

  # Get the last partition (newly created)
  PARTITION=$(lsblk -lnpo NAME "$DEVICE" | tail -n 1)

  # Select format
  FORMAT=$(gum choose --header="Select filesystem for partition $i: " ext4 fat32 ntfs exfat)
  LABEL_NAME=$(gum input --prompt="Enter label for partition $i (optional) " --placeholder="MyUSB")

  # Format
  echo "Formatting $PARTITION as $FORMAT..."

  case "$FORMAT" in
  ext4)
    sudo mkfs.ext4 -L "$LABEL_NAME" "$PARTITION"
    ;;
  fat32)
    sudo mkfs.vfat -F 32 -n "$LABEL_NAME" "$PARTITION"
    ;;
  ntfs)
    sudo mkfs.ntfs -f -L "$LABEL_NAME" "$PARTITION"
    ;;
  exfat)
    sudo mkfs.exfat -n "$LABEL_NAME" "$PARTITION"
    ;;
  *)
    echo "Unsupported format: $FORMAT"
    exit 1
    ;;
  esac

  START="$END"
done

gum style --foreground="green" --bold "✅ USB device $DEVICE has been successfully formatted."
