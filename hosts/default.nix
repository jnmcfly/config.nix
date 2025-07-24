{ config, pkgs, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../users.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "hyprnix";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "de_DE.UTF-8";
  console.keyMap = "de";

  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = false;
  programs.zsh.enable = true;

  programs.hyprland.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";        # sicherer: kein Root-Login
      PasswordAuthentication = true; # optional (du kannst auch nur SSH-Key erlauben)
    };
  };

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  system.stateVersion = "23.11";
}
