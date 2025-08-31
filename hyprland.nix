{pkgs, ...}:

{

  environment.systemPackages = with pkgs; [   
  aquamarine hyprlang
  hyprshot hyprpanel  
  hyprland hyprpolkitagent
  hyprkeys hyprutils 
  hyprpanel hyprgraphics 
  hyprcursor hyprshell
  hyprland-qtutils
  hyprland-protocols
  hyprsunset
  hypridle
  hyprwayland-scanner
  hyprland-qt-support
  nwg-dock-hyprland
  nwg-look nwg-drawer
  notify-desktop
  wlogout wl-clipboard
  imagemagick clipse uwsm
  kanata brightnessctl
  kdePackages.gwenview
  ];

    # Hyprland Fuckery
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  
    programs.hyprlock.enable = true;

    environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";          # for Electron apps
    XCURSOR_THEME = "Bibata-Modern-Ice";  # or any installed theme
    XCURSOR_SIZE = "24";
  };

  
  xdg.portal = {
     enable = true;
  # Only include extra GTK portal for file pickers:
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    xdgOpenUsePortal = true;  # enables xdg-open via portal
  };
}
