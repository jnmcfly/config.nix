{ config, pkgs, ... }:

{
  users.users.jn = {
    isNormalUser = true;
    description = "jn";
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.zsh;
  };
}
