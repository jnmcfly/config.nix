#!/usr/bin/env bash
set -euo pipefail

DISK="/dev/sda"

echo "⚠️  ALLE DATEN AUF $DISK WERDEN GELÖSCHT!"
read -p "Drücke [Enter] zum Fortfahren oder [Strg+C] zum Abbrechen..."

echo "🧹 Partitioniere $DISK..."
parted --script "$DISK" \
  mklabel gpt \
  mkpart primary fat32 1MiB 512MiB \
  set 1 esp on \
  mkpart primary 512MiB 100%

echo "💾 Formatiere EFI und Btrfs..."
mkfs.vfat -F32 "${DISK}1"
mkfs.btrfs -f "${DISK}2"

echo "🧱 Erstelle Btrfs-Subvolumes..."
mount "${DISK}2" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@nix
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@persist
umount /mnt

echo "📁 Mount Subvolumes..."
mount -o compress=zstd,subvol=@ "${DISK}2" /mnt
mkdir -p /mnt/{boot,nix,home,persist}
mount -o compress=zstd,subvol=@nix "${DISK}2" /mnt/nix
mount -o compress=zstd,subvol=@home "${DISK}2" /mnt/home
mount -o compress=zstd,subvol=@persist "${DISK}2" /mnt/persist

mount "${DISK}1" /mnt/boot

echo "✅ Alles bereit. Du kannst jetzt:"
echo "  nixos-generate-config --root /mnt"
echo "  nixos-install --flake /mnt/<pfad-zum-repo>#default"
