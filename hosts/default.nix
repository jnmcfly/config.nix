{ config, pkgs, ... }:

{
  imports = [
    ../hardware-configuration.nix
    ../users.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

# Aktiviert proprietären NVIDIA-Treiber
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false; # false = proprietary, true = open kernel mod (wenn supported)
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.variables = {
    # Für Wayland mit NVIDIA
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
  };

  # Wichtig für Wayland auf NVIDIA
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

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
