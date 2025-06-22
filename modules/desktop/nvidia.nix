{ config, lib, pkgs, ... }:

let
  # Tự động phát hiện loại GPU để áp dụng cấu hình phù hợp
  gpuInfoPath = "/proc/driver/nvidia/gpus/0000:01:00.0/information";
  gpuInfo = if builtins.pathExists gpuInfoPath then builtins.readFile gpuInfoPath else "";
  isRTX4060 = builtins.match ".*RTX 4060.*" gpuInfo != null;
  isRTX3050Ti = builtins.match ".*RTX 3050.*" gpuInfo != null;
  
  # Desktop vs Laptop detection based on chassis type
  chassisTypePath = "/sys/class/dmi/id/chassis_type";
  isLaptop = let
    chassisType = if builtins.pathExists chassisTypePath then builtins.readFile chassisTypePath else "1";
    # Remove newline and whitespace
    cleanChassisType = lib.strings.removePrefix "\n" (lib.strings.removeSuffix "\n" chassisType);
  in builtins.elem cleanChassisType ["8" "9" "10" "14"];
  
in {
  # Enable hardware acceleration và unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # OpenGL/Graphics configuration  
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    
    extraPackages = with pkgs; [
      # NVIDIA VAAPI driver cho hardware video acceleration
      nvidia-vaapi-driver
      vaapiVdpau
      libvdpau-va-gl
      
      # Vulkan support
      vulkan-loader
      vulkan-validation-layers
      vulkan-tools
      
      # OpenCL support
      ocl-icd
      opencl-headers
    ];
  };

  # Load NVIDIA driver cho Xorg và Wayland
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting bắt buộc cho driver hiện đại và Wayland
    modesetting.enable = true;

    # NVIDIA Open Source Kernel Module (NixOS 25.05 improvements)
    # RTX 4060: Sử dụng open = true (Ada Lovelace architecture)
    # RTX 3050 Ti: open = false cho ổn định (Ampere architecture)
    open = if isRTX4060 then true else false;

    # Power management - quan trọng cho laptop và Wayland
    powerManagement = {
      enable = true;
      # Fine-grained power management cho laptop với Wayland
      finegrained = isLaptop;
    };

    # Enable nvidia-settings
    nvidiaSettings = true;

    # Driver version selection - sử dụng stable cho NixOS 25.05
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    
    # Improved Wayland compatibility
    forceFullCompositionPipeline = false;
  };

  # PRIME configuration cho laptop (dual GPU)
  hardware.nvidia.prime = lib.mkIf isLaptop {
    # Sync mode cho hiệu năng tối đa với Wayland
    sync.enable = true;
    # offload.enable = true;  # Uncomment để dùng offload mode cho battery life
    
    # Bus ID - cần kiểm tra bằng: lspci | grep -E "(VGA|3D)"
    # Mặc định cho laptop Intel + NVIDIA phổ biến
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  # Kernel modules và parameters - NixOS 25.05 optimized
  boot = {
    kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    blacklistedKernelModules = [ "nouveau" ];
    
    kernelParams = [
      # Preserve video memory allocations for better suspend/resume
      "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
      
      # Enable DRM kernel mode setting (essential for Wayland)
      "nvidia-drm.modeset=1"
      
      # Wayland-specific optimizations
      "nvidia.NVreg_EnableGpuFirmware=1"
      
      # Laptop specific: Disable Intel GPU nếu chỉ muốn dùng NVIDIA
      # "module_blacklist=i915"  # Uncomment nếu cần
    ] ++ lib.optionals isLaptop [
      # Laptop power management with Wayland
      "nvidia.NVreg_DynamicPowerManagement=0x02"
    ];
    
    extraModulePackages = [ config.boot.kernelPackages.nvidia_x11 ];
  };

  # System packages - removed duplicates, optimized for NixOS 25.05
  environment.systemPackages = with pkgs; [
    # NVIDIA utilities
    nvidia-container-toolkit
    
    # Development tools
    cudatoolkit
    
    # OpenCL
    ocl-icd
    opencl-headers
    
    # Video acceleration tools
    libva-utils
    vdpauinfo
    
    # Performance monitoring (conditionally include if available)
  ] ++ lib.optionals (pkgs ? nvtopPackages) [ pkgs.nvtopPackages.full or pkgs.nvtopPackages.nvidia ];

  # Udev rules cho NVIDIA power management
  services.udev.extraRules = lib.optionalString isLaptop ''
    # NVIDIA power management for laptops
    SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030000", ATTR{power/control}="auto"
    SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x030200", ATTR{power/control}="auto"
  '';

  # Systemd services cho NVIDIA với Wayland support
  systemd.services = {
    # NVIDIA suspend/resume support for Wayland
    nvidia-suspend = lib.mkIf isLaptop {
      description = "NVIDIA system suspend actions";
      unitConfig.RequiresMountsFor = "/sys";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.systemd}/bin/systemctl set-environment DISPLAY=:0";
      };
      wantedBy = [ "sleep.target" ];
      before = [ "sleep.target" ];
    };
    
    nvidia-resume = lib.mkIf isLaptop {
      description = "NVIDIA system resume actions";
      unitConfig.RequiresMountsFor = "/sys";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/class/vtconsole/vtcon1/bind'";
      };
      wantedBy = [ "sleep.target" ];
      after = [ "sleep.target" ];
    };
  };

  # Specialisation cho gaming vs power saving (laptop only)
  specialisation = lib.mkIf isLaptop {
    gaming = {
      inheritParentConfig = true;
      configuration = {
        hardware.nvidia.prime.sync.enable = lib.mkForce true;
        hardware.nvidia.prime.offload.enable = lib.mkForce false;
        hardware.nvidia.powerManagement.finegrained = lib.mkForce false;
      };
    };
    
    powersave = {
      inheritParentConfig = true;
      configuration = {
        hardware.nvidia.prime.sync.enable = lib.mkForce false;
        hardware.nvidia.prime.offload.enable = lib.mkForce true;
        hardware.nvidia.powerManagement.finegrained = lib.mkForce true;
      };
    };
  };
} 