{ config, pkgs, ... }:

{
  # === AUDIO SYSTEM CONFIGURATION ===
  
  # Disable legacy PulseAudio (replaced by PipeWire)
  services.pulseaudio.enable = false;
  
  # Enable RealtimeKit for low-latency audio processing
  security.rtkit.enable = true;

  # === PIPEWIRE AUDIO SERVER ===
  services.pipewire = {
    enable = true;              # Enable PipeWire audio server
    alsa.enable = true;         # ALSA compatibility layer
    alsa.support32Bit = true;   # 32-bit ALSA support for older applications
    pulse.enable = true;        # PulseAudio compatibility layer
    jack.enable = true;         # JACK compatibility for professional audio

    # === LOW-LATENCY CONFIGURATION ===
    # Optimized settings for minimal audio latency
    extraConfig.pipewire."92-low-latency" = {
      context.properties = {
        default.clock.rate = 48000;        # Sample rate (48kHz standard)
        default.clock.quantum = 32;        # Buffer size (32 samples = ~0.67ms latency)
        default.clock.min-quantum = 32;    # Minimum buffer size
        default.clock.max-quantum = 32;    # Maximum buffer size
      };
    };
  };

  # === AUDIO UTILITIES ===
  environment.systemPackages = with pkgs; [
    pavucontrol  # PulseAudio Volume Control GUI
    easyeffects  # Audio effects and equalization
    alsa-utils   # ALSA command-line utilities
  ];
} 