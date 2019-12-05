{ config, pkgs, ... }:
{
  users = {
    defaultUserShell = pkgs.zsh;
    users.poliez = {
      isNormalUser = true;
      home = "/home/poliez";
      useDefaultShell = true;
      description = "Paolo Anastagi";
      extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    };
  };
}
