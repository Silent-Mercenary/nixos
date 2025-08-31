# Nix package manager, settings
{pkgs, ... }:

{
  nix = {
    package = pkgs.nixVersions.git;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      trusted-users = [ "root" "admin" ];
      auto-optimise-store = true;
      log-lines = 50;
      http-connections = 25;
      max-jobs = "auto";
      cores = 12;
      build-cores = 12;
      "download-buffer-size" = "67108864";
      warn-dirty = false;
      keep-outputs = true;
      keep-derivations = true;

      substituters = [
        "https://cache.nixos.org/"
        "https://hyprland.cachix.org"
        "https://chaotic-nyx.cachix.org/"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "chaotic-nyx.cachix.org-1:HfnXSw4pj95iI/n17rIDy40agHj12WfF+Gqk6SonIT8="
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  # Let Nix install unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable firmware blob fetching
  hardware.enableAllFirmware = true;
}


