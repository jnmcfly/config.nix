{ config, lib, pkgs, modulesPath, ... }:

{
  fileSystems."/" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd" ];
  };

  fileSystems."/nix" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd" ];
  };

  fileSystems."/home" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd" ];
  };

  fileSystems."/persist" = {
    device = "/dev/sda2";
    fsType = "btrfs";
    options = [ "subvol=@persist" "compress=zstd" ];
  };

  fileSystems."/boot" = {
    device = "/dev/sda1";
    fsType = "vfat";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
