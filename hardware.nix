{ config, pkgs, ... }:

{
  hardware = {

    cpu.intel.updateMicrocode = true;
 
    nvidia = {
      modesetting.enable = false;
      optimus_prime = {
        enable = false;
        nvidiaBusId = "PCI:1:0:0";
        intelBusId = "PCI:0:2:0";
      };
    };

    pulseaudio = {
      enable = true;
      extraModules = [ pkgs.pulseaudio-modules-bt ];
      package = pkgs.pulseaudioFull;
    };

    opengl = {
      driSupport32Bit = true;
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };

    bluetooth.enable = true;
  };
}
