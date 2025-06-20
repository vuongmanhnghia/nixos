{ config, lib, pkgs, ... }:

{
  # Enable firmware updates
  services.fwupd.enable = true;
  
  # CPU microcode updates
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
  # Enable redistributable firmware
  hardware.enableRedistributableFirmware = true;
  
  # USB automounting
  services.udisks2.enable = true;
  
  # TRIM support for SSDs
  services.fstrim.enable = true;
  
  # Hardware acceleration
  hardware.graphics = {
    enable = true;
    
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
  
  # Printing support
  services.printing = {
    enable = true;
    drivers = with pkgs; [ 
      hplip 
      canon-cups-ufr2 
      gutenprint 
    ];
  };
  
  # Scanner support
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
} 