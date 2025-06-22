{ config, pkgs, lib, ... }:

{
  # === AUDIO CONFIGURATION - NIXOS 25.05 OPTIMIZED ===
  
  # Disable conflicting audio systems
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
      
      "context.modules" = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            "nice.level" = -15;
            "rt.prio" = 88;
            "rt.time.soft" = 200000;
            "rt.time.hard" = 200000;
          };
        }
        {
          name = "libpipewire-module-protocol-native";
        }
        {
          name = "libpipewire-module-client-node";
        }
        {
          name = "libpipewire-module-adapter";
        }
        {
          name = "libpipewire-module-link-factory";
        }
      ];
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
  ];

  # === UDEV RULES FOR AUDIO DEVICES ===
  services.udev.extraRules = ''
    # Allow users in audio group to access audio devices with low latency
    KERNEL=="controlC[0-9]*", GROUP="audio", MODE="0664"
    SUBSYSTEM=="sound", GROUP="audio", MODE="0664"
    
    # USB audio device rules for better performance
    SUBSYSTEM=="usb", ATTRS{idVendor}=="*", ATTRS{idProduct}=="*", ATTRS{bInterfaceClass}=="01", GROUP="audio"
  '';

  # === USER GROUPS ===
  # Ensure user has proper audio permissions
  users.users.nagih.extraGroups = [ "audio" "pipewire" ];

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

  # === SYSTEMD SERVICE OPTIMIZATIONS ===
  systemd.user.services.pipewire.serviceConfig = {
    # Ensure PipeWire runs with high priority
    Nice = -15;
    IOSchedulingClass = 1;  # Real-time I/O scheduling
    IOSchedulingPriority = 4;
  };

  systemd.user.services.pipewire-pulse.serviceConfig = {
    Nice = -15;
    IOSchedulingClass = 1;
    IOSchedulingPriority = 4;
  };

  systemd.user.services.wireplumber.serviceConfig = {
    Nice = -10;
    IOSchedulingClass = 1;
    IOSchedulingPriority = 6;
  };
}
