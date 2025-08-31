{pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./boot.nix
      ./mount.nix
      ./fish.nix
      ./game.nix
      ./hyprland.nix
      ./nix.nix
      ./nvidia+intel.nix
      ./pkgs.nix
      ./services.nix
      ./virtualization.nix
      ./jellyfin.nix
      ./searXNG.nix
    ];





  hardware.bluetooth = { 
  	enable = true; # enables support for Bluetooth
  	powerOnBoot = true;  # powers up the default Bluetooth controller on boot
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.admin = {
    isNormalUser = true;
    description = "admin";
    extraGroups = [ "networkmanager" "wheel" "audio" "docker" "libvirtd"];
    shell = pkgs.fish;
  };


security.doas.enable = true;
security.sudo.enable = false;
security.doas.extraRules = [{
  groups = ["wheel"];
  keepEnv = true; 
  persist = true;
  noLog = true;  
  }];
  
  #Networking + Firewall + Hostname
  networking = {
    hostName = "nixstation"; # Define your hostname.
    networkmanager.enable = true;
    firewall = { 
  	  enable = true;
 	   allowedTCPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];  
  	  allowedUDPPortRanges = [ 
      { from = 1714; to = 1764; } # KDE Connect
    ];
  	  interfaces."tailscale0".allowedTCPPorts = [ 22 ]; 
      trustedInterfaces = [ "tailscale0" ]; 
    };    
  };
  # Firewall Settings per interface
  #networking.firewall.interfaces."wlp2s0".allowedTCPPorts = [ 80 443 ];
  #networking.firewall.interfaces."wlp2s0".allowedUDPPorts = [ ... ];
  # networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ 22 ];
   
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";      # for Firefox
  };

  # Custom Env Variables
  environment.etc."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Sweet-mars-v40
  '';

  environment.etc."gtk-4.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Sweet-mars-v40
  '';

  system.stateVersion = "25.11"; # Did you read the comment?
}
