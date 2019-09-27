{ config, pkgs, ... }:
{
  networking.hostName = "nixps"; # Define your hostname.
  networking.networkmanager.enable = true;
}
