{ config, pkgs, lib, ... }:

{
  # === AUDIO CONFIGURATION - NIXOS 25.05 OPTIMIZED & FIXED ===
  
  # Disable conflicting audio systems (sound.enable removed - no longer supported)
  services.pulseaudio.enable = false;
  
  # Enable realtime scheduling for audio
  security.rtkit.enable = true;
  
  # PipeWire - Modern audio server with low latency
  services.pipewire = {
    enable = true;
    
    # Enable compatibility layers
    alsa.enable = true;
    alsa.support32Bit = true;  # For Steam and 32-bit games
    pulse.enable = true;       # PulseAudio compatibility
    jack.enable = true;        # Professional audio (optional)
    
    # === LOW LATENCY CONFIGURATION ===
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        # Optimal settings for gaming and real-time audio
        "default.clock.rate" = 48000;           # 48kHz sample rate
        "default.clock.quantum" = 32;           # 32 samples buffer
        "default.clock.min-quantum" = 32;       # Minimum buffer size
        "default.clock.max-quantum" = 8192;     # Maximum buffer size for compatibility
        
        # Memory allocation settings
        "core.daemon" = true;
        "core.name" = "pipewire-0";
        
        # Logging level (reduce for performance)
        "log.level" = 2;  # 0=off, 1=error, 2=warn, 3=info, 4=debug, 5=trace
      };
      
      # Remove context.modules section - let PipeWire load its default modules
      # This prevents conflicts with modules that are already loaded
    };
    
    # WirePlumber configuration for session management
    wireplumber = {
      enable = true;
      
      # Custom WirePlumber configuration for optimal performance
      extraConfig."51-disable-suspension" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              {
                # Disable node suspension for gaming/streaming
                "node.name" = "~alsa_output.*";
              }
            ];
            actions = {
              update-props = {
                "session.suspend-timeout-seconds" = 0;
              };
            };
          }
        ];
      };

      # Hardware detection and automatic configuration
      extraConfig."50-hardware-detection" = {
        "monitor.alsa.rules" = [
          {
            matches = [
              { "device.name" = "~alsa_card.*"; }
            ];
            actions = {
              update-props = {
                # Enable all available profiles
                "api.alsa.use-acp" = true;
                "api.alsa.ignore-dB" = false;
                # Proper device detection
                "device.profile-set" = "default.conf";
              };
            };
          }
        ];
      };
    };
  };

  # === AUDIO PACKAGES ===
  environment.systemPackages = with pkgs; [
    # Audio control and monitoring
    pavucontrol          # PulseAudio volume control GUI
    pulsemixer          # Terminal-based audio mixer
    alsa-utils          # ALSA utilities (aplay, amixer, etc.)
    
    # PipeWire utilities
    pipewire            # PipeWire tools
    wireplumber         # Session manager
    
    # Audio codecs and plugins
    pulseaudio          # For compatibility tools
    
    # Professional audio tools (optional)
    qjackctl           # JACK connection manager
    carla              # Audio plugin host
    
    # System audio info
    inxi               # System information (includes audio)
    
    # Additional audio utilities for troubleshooting
    sox                 # Sound processing
    ffmpeg             # Audio/video processing
  ];

  # === HARDWARE SUPPORT ===
  # Enable sound hardware detection
  hardware = {
    # Enable all audio hardware
    graphics.enable = true;  # For HDMI audio
    
    # USB audio support
    usb-modeswitch.enable = true;
    
    # Bluetooth audio support
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };
  };

  # === UDEV RULES FOR AUDIO DEVICES ===
  services.udev.extraRules = ''
    # Allow users in audio group to access audio devices with low latency
    KERNEL=="controlC[0-9]*", GROUP="audio", MODE="0664"
    SUBSYSTEM=="sound", GROUP="audio", MODE="0664"
    
    # USB audio device rules for better performance
    SUBSYSTEM=="usb", ATTRS{idVendor}=="*", ATTRS{idProduct}=="*", ATTRS{bInterfaceClass}=="01", GROUP="audio"
    
    # Real-time priority for audio devices
    KERNEL=="rtc0", GROUP="audio", MODE="0664"
    
    # Allow audio group to access timer
    KERNEL=="timer", GROUP="audio", MODE="0664"
  '';

  # === USER GROUPS ===
  # Ensure user has proper audio permissions
  users.users.nagih.extraGroups = [ "audio" "pipewire" "rtkit" ];

  # === ENVIRONMENT VARIABLES ===
  # Audio-specific environment variables
  environment.sessionVariables = {
    # PipeWire session management
    PIPEWIRE_LATENCY = "32/48000";  # 32 samples at 48kHz
    
    # Pulse compatibility
    PULSE_RUNTIME_PATH = "/run/user/$(id -u)/pulse";
    
    # JACK compatibility
    JACK_DEFAULT_SERVER = "pipewire";
  };

  # === SYSTEMD SERVICE OPTIMIZATIONS - FIXED ===
  # Remove problematic IOScheduling settings that cause IOPRIO errors
  # Instead use nice values and proper resource management
  
  systemd.user.services.pipewire.serviceConfig = {
    # Use nice instead of IOScheduling to avoid IOPRIO errors
    Nice = -15;
    # Remove IOSchedulingClass and IOSchedulingPriority to fix the error
    # IOSchedulingClass = 1;  # REMOVED - This causes IOPRIO errors
    # IOSchedulingPriority = 4;  # REMOVED - This causes IOPRIO errors
    
    # Resource limits
    LimitRTPRIO = 95;
    LimitMEMLOCK = "infinity";
  };

  systemd.user.services.pipewire-pulse.serviceConfig = {
    Nice = -15;
    # Remove IOScheduling settings
    LimitRTPRIO = 95;
    LimitMEMLOCK = "infinity";
  };

  systemd.user.services.wireplumber.serviceConfig = {
    Nice = -10;
    # Remove IOScheduling settings
    LimitRTPRIO = 85;
    LimitMEMLOCK = "infinity";
  };

  # === BOOT MODULES FOR AUDIO ===
  boot.kernelModules = [
    "snd-seq"
    "snd-rawmidi"
    "snd-hda-intel"
    "snd-usb-audio"
  ];

  # === ADDITIONAL SYSTEM CONFIGURATION ===
  # Enable dbus for proper audio session management
  services.dbus.enable = true;
  
  # Ensure proper XDG runtime directory
  security.pam.services.login.enableGnomeKeyring = true;
}
