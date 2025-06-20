{ config, pkgs, ... }:

{
  # Gaming applications - only gaming-specific packages
  home.packages = with pkgs; [
    # Steam and tools
    steam
    protonup-qt
    winetricks
    protontricks
    
    # Game launchers
    lutris
    heroic
    bottles
    
    # Emulation
    retroarch
    dolphin-emu
    pcsx2
    
    # Performance monitoring (gaming-specific)
    mangohud
    goverlay
    
    # Voice chat (gaming-focused)
    discord
    teamspeak_client
    
    # Streaming tools
    obs-studio
    obs-studio-plugins.wlrobs
    
    # Game development
    godot_4
    blender
  ];
  
  # Gaming-specific configurations
  xdg.configFile = {
    "MangoHud/MangoHud.conf".text = ''
      toggle_hud=Shift_R+F12
      toggle_logging=Shift_L+F2
      upload_log=F5
      reload_cfg=Shift_L+F4
      
      # Performance
      fps
      frametime=0
      cpu_stats
      gpu_stats
      cpu_temp
      gpu_temp
      
      # Display
      position=top-left
      background_alpha=0.4
      font_size=24
      
      # Colors
      gpu_color=2e9762
      cpu_color=2e97cb
      vram_color=ad64c1
      ram_color=c26693
      engine_color=eb5b5b
      io_color=a491d3
      frametime_color=00ff00
      background_color=020202
      text_color=ffffff
    '';
  };
  
  # Performance optimizations
  home.sessionVariables = {
    # Gaming optimizations
    __GL_THREADED_OPTIMIZATIONS = "1";
    __GL_SHADER_DISK_CACHE = "1";
    __GL_SHADER_DISK_CACHE_PATH = "$HOME/.cache/nv";
    
    # Steam optimizations
    STEAM_RUNTIME_PREFER_HOST_LIBRARIES = "0";
    STEAM_RUNTIME_HEAVY = "1";
  };
} 