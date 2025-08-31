{
  description = "A SecureBoot-enabled NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    copyparty = {
      url = "github:9001/copyparty";
    };
  };

  outputs = { nixpkgs, lanzaboote, copyparty, ... }: {
    nixosConfigurations = {
      nixstation = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./mount.nix
          ./configuration.nix

          lanzaboote.nixosModules.lanzaboote # Secureboot Stack

          ({ pkgs, lib, ... }: {

            environment.systemPackages = [
              pkgs.sbctl
            ];

            boot.loader.systemd-boot.enable = lib.mkForce false;

            boot.lanzaboote = {
              enable = true;
              pkiBundle = "/var/lib/sbctl";
            };
          })

          # Copyparty integration
          ({ pkgs, ... }: {
            # Import the Copyparty NixOS module
            imports = [ copyparty.nixosModules.default ];

            # Add the overlay so the package is available
            nixpkgs.overlays = [ copyparty.overlays.default ];

            # Optional: install globally
            environment.systemPackages = [ pkgs.copyparty ];

            # Enable and configure the service
            services.copyparty.enable = false;
            services.copyparty.settings = {
              i = "0.0.0.0";
              p = [ 3210 3211 ];
              no-reload = true;
            };
            services.copyparty.accounts = {
              ed.password = "password";
            };
            services.copyparty.volumes = {
              "/" = {
                path = "/srv/copyparty";
                access = {
                  r = "";
                  rw = [ "ed" ];
                };
                flags = { fk = 4; scan = 60; e2d = true; };
              };
            };
            services.copyparty.openFilesLimit = 8192;
          })
        ];
      };
    };
  };
}
