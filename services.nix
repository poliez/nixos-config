{ config, pkgs, ... }:
{
  services = {
    openssh.enable = true;

    # hardware management services
    fstrim.enable = true; # ssd disk optimisation
    tlp.enable = true; # energy/temperature management 
    thermald.enable = true; # thermal optimisation for intel cpu
    printing.enable = true; # enable CUPS to print documents

    locate.enable = true; # periodically updatedb
    localtime.enable = true;

    dbus.packages = with pkgs; [ 
      gnome3.dconf 
      gnome2.GConf 
    ];

    gnome3.gnome-documents.enable = false;   
 
    xserver = {
      enable = true;
      autorun = true;
      layout = "it";
      videoDrivers = [ "intel" ];
      libinput.enable = true;

      displayManager.gdm = {
        enable = true;
        wayland = true;
      };

      desktopManager = {
        xterm.enable = false;
        gnome3.enable = true;
        default = "gnome3";
      };

      windowManager = {
        xmonad.enable = true;
        default = "xmonad";
      };
    };
  };
}
