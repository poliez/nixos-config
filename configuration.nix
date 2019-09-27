# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./hardware.nix
      ./networking.nix
      ./boot.nix
      ./services.nix
      ./users.nix
      ./software.nix 
    ];

  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time.timeZone = "Europe/Amsterdam";

  sound.enable = true;
  
  security.sudo.enable = true;

  fonts = {
    fonts = with pkgs; [
      corefonts # Microsoft free fonts
      fira-code
      inconsolata  # monospaced
      google-fonts
      hack-font
      hasklig
      nerdfonts
      noto-fonts
    ];
    
    fontconfig.defaultFonts.monospace = [ "Ubuntu" ];
  };

  environment.variables.EDITOR = "vim";

  system.stateVersion = "19.03"; # Did you read the comment?

}
