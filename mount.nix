{pkgs, ...}:

{
  boot.initrd.luks.devices."luks-18fdc559-ca5c-454f-9159-0ee50290f6b0".device = "/dev/disk/by-uuid/18fdc559-ca5c-454f-9159-0ee50290f6b0";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/EFA4-1FD1";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/34241b6f-81dc-4635-8ae4-9e77ab911986"; }
    ];

	fileSystems."/" = {
     device = "/dev/disk/by-uuid/00fe1d1f-32e9-443d-b6ed-9f5b65da3df3";
     fsType = "btrfs";
     options = [
      "subvol=@"
      "noatime"
      "compress=zstd:3"
      "ssd"
      "space_cache=v2"
      "discard=async"
    ];
  };

	fileSystems."/mnt/08a8a9a1-4f76-4ec6-b088-9aa20a6235e2" = {
     device = "/dev/disk/by-uuid/08a8a9a1-4f76-4ec6-b088-9aa20a6235e2";
     fsType = "btrfs";
     options = [
      "noatime"
      "compress=zstd:3"
      "ssd"
      "discard=async"
      "space_cache=v2"
      "users"
      "nofail"
      "x-gvfs-show"
      "x-gvfs-name=Archive-FS"
      "exec"
	    ];
	  };
	  
	services.btrfs.autoScrub = {
	  enable = true;
	  interval = "monthly";
	  };

	 services.fstrim.enable = true;
   services.smartd.enable = true;


    environment.systemPackages = with pkgs; [
    	btrfs-progs btrfs-assistant
    ];
}
