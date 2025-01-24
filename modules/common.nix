{ config, pkgs, ... }:

{

  time.timeZone = "Europe/Berlin";

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

  programs.zsh.enable = true;

  nixpkgs.config.allowUnfree = true;

  services.openssh.enable = true;

}
