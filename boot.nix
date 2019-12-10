{ config, pkgs, ... }:
{
  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelPackages = pkgs.unstable.linuxPackages_5_3;

    kernelParams = [
       # many parameters are from : https://github.com/JackHack96/dell-xps-9570-ubuntu-respin#manual-respin-procedure
       "acpi_osi=Linux"
       "acpi_rev_override=1"

       # Disable this if it causes on/off loss of ethernet conncetion with external usb ethernet card
       "pcie_aspm=force" # force Active State Power Management (ASPM) even on devices that claim not to support it

       "mem_sleep_default=deep"

       # In scenarios where you are getting unexplained system freeze scenarios, 
       # NMI watchdog interrupt handler will simply kill whatever process happens to be freezing the CPU at the moment. 
       # This way, your CPU gets freed up AND you get a detailed stack trace of why your CPU got frozen up in the first place.
       "nmi_watchhog=1"
    ];

    initrd = {
      kernelModules = [
        "scsi_mod"
      ];
    };

    # scsi_mod.use_blk_mq=1 # optimises the scheduling of IO on disks using multi-cores
    extraModprobeConfig = ''
      options scsi_mod use_blk_mq=1
    '';
    # practical module option when the intel chip is used since initrd
    # options i915 enable_fbc=1 enable_guc_loading=1 enable_guc_submission=1 disable_power_well=0

    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    blacklistedKernelModules = [ "nouveau" ]; # blacklist the opensource nvidia driver that does not work well and might conflict with proprietary nvidia driver

    loader.grub = {
      enable = true;
      version = 2;
      devices = ["nodev"];
      useOSProber = true;
      efiSupport = true;
      copyKernels = true;
    };
  };
}
