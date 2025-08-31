# Boot
{pkgs, ...}:

{
  # Bootloader + linux package + Mod probe
  boot = {
    loader = {
       efi.canTouchEfiVariables = true;
       systemd-boot.enable = true;
       systemd-boot.configurationLimit = 5;
      };
    initrd.systemd.enable = true;

  	kernelPackages = pkgs.linuxPackages_latest;
    
    plymouth = {
      enable = true;
      theme = "nixos-bgrt";
      themePackages = with pkgs; [
        nixos-bgrt-plymouth
      ];
    };

   
    
    # Shuts up fucking systemd-initrd
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet" # disables systemd shit
      "splash" # enables plymouth
      "boot.shell_on_fail" # if boot fails, boot to shell
      "udev.log_priority=3"  # udev logs errors anc critical failure
      "rd.systemd.show_status=auto" # if boot freezes brings up systemd status
      "intel_iommu=on"  # VM optimizations
      "iommu=pt"  # Puts devices into passthrough mode for minimal overhead
      "random.trust_cpu=on"  # Trusts CPU randomness
    ];
  };

    # Zram
  zramSwap ={
    enable = true;
    algorithm = "zstd";
  };

    # Set your time zone.
  time.timeZone = "America/Toronto";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";
}
