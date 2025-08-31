{pkgs, ...}:

{
  environment.systemPackages = with pkgs; [

  # Comms
  signal-desktop legcord
  thunderbird valent
  
  # Terminal Emulators + extensions/Prefrences
  kitty # goto terminal 
  ghostty # sex appeal maxed out 
  alacritty
  fish

  # Networking/Git
  curl git wget

  # codecs
  ffmpeg-full
  gst_all_1.gst-plugins-good
  gst_all_1.gst-plugins-bad
  gst_all_1.gst-plugins-ugly
  gst_all_1.gst-libav

  # System tools 
  nvtopPackages.full
  btop htop nmap micro
  fastfetch sbctl
  lm_sensors 
  gnome-firmware
  gnome-disk-utility
  pciutils
  powerstat
  tailscale  
  bat fd fzf
  bluez file
  zoxide
  linux-wifi-hotspot
  gapless 
  vlc mpv cmus
  gh acpi gparted
  dmidecode
  figlet
  mission-center
  cyberchef
  android-tools

  fusePackages.fuse_2  fuse fuse3
  # Office Suite
  libreoffice-fresh
  hunspell

  # Browsers
  floorp
  
  # IDEs
  zed-editor
  vscodium
  
  # DEV tools
  gcc gnumake pkg-config cmake
  ninja autoconf automake libtool
  gettext glibc gdb strace lldb
  clang rustc cargo rust-analyzer
  llvm unzip unrar

  # Cargo pkgs 
  sshs
  zellij
  bluetuith
  
  # Thunar + Plugins
  kdePackages.ark
  udiskie
  xarchiver
  gvfs

  # File Syncs
  nextcloud-client
  davfs2
  
  # Security
  bitwarden-desktop
  polkit_gnome
  
  # Sudo replacement
  doas-sudo-shim
  doas 
  
  # Virtualization
  virt-manager
  
  # Containerization
  docker podman
  distrobox docker-compose
  nvidia-container-toolkit
  
  # XDG portal
  xdg-desktop-portal
  xdg-desktop-portal-hyprland
  xdg-desktop-portal-gtk 
  
  # Sound shit
  alsa-utils
  sof-firmware
  pavucontrol
  mpv vlc
  
  # Theming
  bibata-cursors
  sweet
  papirus-icon-theme
  afterglow-cursors-recolored

  # OBS
  obs-studio
  obs-studio-plugins.obs-vkcapture
  obs-studio-plugins.obs-pipewire-audio-capture
  
  # Dev Shit because why the fuck now
  icu
  

  #Nix Exclusive
  nixd
  nil
  nix-tree
  nix-output-monitor
  nix-init
  nixpkgs-fmt
  cachix
  ];

  fonts.fontDir.enable = true;
  fonts = {
  enableDefaultPackages = true;
  packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    
   ];
   fontconfig.enable = true;
  };

  programs.file-roller.enable = true;

  programs.xfconf.enable = true;
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman thunar-media-tags-plugin thunar-vcs-plugin];
  };

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  # Firefox Browser (replace with Zen Browser when it fucking get ported)
  programs.firefox.enable = true;


  programs.seahorse.enable = true;


  programs.kdeconnect = {
  enable = true;
  package = pkgs.valent;
  };
}
