{ config, pkgs, ... }:

{
  system.stateVersion = "24.11";

  time.timeZone = "Europe/Berlin";
  console.keyMap = "de";
  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  fileSystems."/" = {
    device = "/dev/disk/by-label/os";
    fsType = "btrfs";
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/boot" = {
    device = "/dev/disk/by-label/BOOT";
    fsType = "vfat";
  };

  users.users.jn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    _1password-gui
    calibre
    cava
    curl
    discord
    docker
    docker-compose
    dunst
    easyeffects
    git
    git-extras
    hyprland
    hyprland-protocols
    kitty
    lazydocker
    lazygit
    lunarvim
    neovim
    obsidian
    oh-my-zsh
    prusa-slicer
    spotify
    tty-clock
    vscode
    waybar
    wget
    wofi
    yazi
    yubioath-flutter
    zsh
  ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.openssh.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.defaultSession = "hyprland";
  services.xserver = { enable = true; };

}
