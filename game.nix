{pkgs, ...}:

{
  programs.gamemode.enable = true; # cpu governor for games

  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
  heroic steam winetricks
  wineWowPackages.unstableFull
  umu-launcher protonplus
  lutris
  ];
}
