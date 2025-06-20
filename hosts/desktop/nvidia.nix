{ config, pkgs, ... }:

{
  # NVIDIA configuration
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    # Modesetting is required
    modesetting.enable = true;
    
    # Enable power management (experimental)
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    
    # Use open source kernel module (experimental)
    open = false;
    
    # Enable the Nvidia settings menu
    nvidiaSettings = true;
    
    # Use the production driver
    package = config.boot.kernelPackages.nvidiaPackages.production;
    
    # Prime sync for laptops with dual GPU (uncomment if needed)
    # prime = {
    #   sync.enable = true;
    #   nvidiaBusId = "PCI:1:0:0";
    #   intelBusId = "PCI:0:2:0";
    # };
  };
  
  # Graphics
  hardware.graphics = {
    enable = true;
    
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  
  # CUDA support (uncomment if needed)
  # nixpkgs.config.cudaSupport = true;
  
  # Environment variables
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
  };
} 