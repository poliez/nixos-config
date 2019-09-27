{ config, pkgs, ... }:
{
  users.users.poliez = {
    isNormalUser = true;
    home = "/home/poliez";
    description = "Paolo Anastagi";
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
  };
}
