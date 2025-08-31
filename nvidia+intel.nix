{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "modesetting" "nvidia" ];

  boot.kernelParams = [ "nvidia-drm.modeset=1" ];


  hardware = {
  	
    graphics = {
      enable = true;

      extraPackages = with pkgs; [
        mesa
        libglvnd
        intel-media-driver
        intel-vaapi-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        vulkan-loader
        vulkan-tools
        nvidia-vaapi-driver
      ];
    };

    nvidia-container-toolkit.enable = true;
    nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      nvidiaSettings = true;
      open = false;
      dynamicBoost.enable = false;
      videoAcceleration = true;
      #nvidiaPersistenced = true;      
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      prime = {
        offload= {
        enable = true;
        enableOffloadCmd = true;
         };
        
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  environment.sessionVariables = {
  # _GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
  # LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  environment.systemPackages = with pkgs; [
    glxinfo
    vulkan-tools
    mesa-demos
    cudatoolkit
    ffmpeg_6-full
  ];
}
