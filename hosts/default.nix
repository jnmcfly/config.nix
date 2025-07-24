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

  # NVIDIA (proprietär)
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # NVIDIA + Wayland Compatibility
  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_DRM_NO_ATOMIC = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
  };

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  # Hyprland (Wayland-Session)
  services.xserver.enable = true;
  services.xserver.displayManager.sddm = {
    enable = true;
    autoLogin.enable = true;       # optional
    autoLogin.user = "jn";         # setze auf deinen Benutzernamen
  };
  services.xserver.desktopManager.plasma5.enable = false;

  programs.hyprland.enable = true;

  # Shell & Terminal
  programs.zsh.enable = true;

  # Audio
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

  # SSH
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true; # oder false, falls du nur Keys willst
    };
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  system.stateVersion = "23.11";
}