{ config, pkgs, ... }:

{
  # Boot configuration
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        
        # Giới hạn số lượng boot entries hiển thị
        configurationLimit = 5;  # Chỉ hiển thị 5 options gần nhất
        
        # Cho phép chỉnh sửa kernel parameters
        editor = false;  # true nếu muốn edit boot params
        
        # Console resolution
        consoleMode = "auto";  # "auto", "max", "0", "1", "2"
      };
      
      # Tự động chọn entry mặc định sau timeout
      timeout = 5;  # 5 giây (hoặc null để chờ vô hạn) 
      
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";  # Hoặc "/boot/efi" tùy setup
      };
    };
    
    # Kernel parameters
    kernelParams = [ "quiet" "splash" ];
    
    # Enable Plymouth for boot splash
    plymouth.enable = true;
    
    # Kernel modules
    kernelModules = [ ];
    extraModulePackages = [ ];
  };
  
  # Auto cleanup
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";  # 2 tuần
    };
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
  };
  
  # Cleanup script
  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "cleanup" ''
      sudo nix profile wipe-history --profile /nix/var/nix/profiles/system --older-than 7d
      sudo nix store gc
      sudo nix store optimise
    '')
  ];
}
