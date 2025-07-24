{ config, pkgs, ... }:

{
  home.username = "jn";
  home.homeDirectory = "/home/jn";
  home.stateVersion = "23.11";

  programs.home-manager.enable = true;

  programs.zsh.enable = true;
  programs.starship.enable = true;

  programs.alacritty.enable = true;

  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      monitor = [ "eDP-1,1920x1080@60,0x0,1" ];
      exec-once = [
        "waybar &"
        "nm-applet &"
        "blueman-applet &"
        "dunst &"
        "hyprpaper &"
      ];
      input.kb_layout = "de";
    };
  };

  home.packages = with pkgs; [
    firefox
    kitty
    rofi-wayland
    grim
    slurp
    wl-clipboard
    pavucontrol
    brightnessctl
    playerctl
    swaylock
    swayidle
    networkmanagerapplet
    blueman
    neovim
    git
    unzip
    jq
    dunst
    hyprpaper
  ];

  services.dunst.enable = true;
  services.hyprpaper.enable = true;
  programs.waybar.enable = true;
}
