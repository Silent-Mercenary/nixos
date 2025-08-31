{...}:

{
    # Fish Shell
  programs.fish = {
  enable = true;
  shellAliases = {
    # Nix Aliases
    sudo   = "doas";
    snrs   = "sudo nixos-rebuild switch";
    snrt   = "sudo nixos-rebuild test";
    # Shell Conveniences 
    cd     = "z";
    nano   = "micro";
    # Distrobox
    arch   = "distrobox enter arch";
    fedora = "distrobox enter fedora";
    kali   = "distrobox enter kali";
    ubuntu = "distrobox enter ubuntu";
    };
  };
}
