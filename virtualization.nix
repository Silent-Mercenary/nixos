{ pkgs, ... }:

{
  # Enable Docker with NVIDIA GPU support
  virtualisation.docker = {
    enable = true;
    storageDriver = "btrfs"; # or "btrfs" if your root is btrfs
    daemon.settings = {
      userland-proxy = false;
      experimental = true;

      # NVIDIA runtime injection
      runtimes.nvidia = {
        path = "${pkgs.nvidia-container-toolkit}/bin/nvidia-container-runtime";
      };

      default-runtime = "runc"; # keep runc as default
    };
  };

  # Enable NVIDIA Container Toolkit (for Docker & Podman)
  hardware.nvidia-container-toolkit.enable = true;

  # Enable Podman (optionally with Docker CLI compatibility)
  virtualisation.podman = {
    enable = true;
    dockerCompat = false;  # true if you want `docker` CLI to work
    defaultNetwork.settings.dns_enabled = true;
  };


    virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      ovmf.enable = true;
    };
  };


 
  systemd.services.libvirt-default-network = {
    description = "Activate libvirt default NAT network";
      after = [ "libvirtd.service" ];
      wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${pkgs.libvirt}/bin/virsh net-start default";
          ExecStop = "${pkgs.libvirt}/bin/virsh net-destroy default";
        User = "root";
    };
  };
   
  networking.firewall.trustedInterfaces = [ "virbr0" ];


}
