{ config, pkgs, ... }:
{
  # Simple and reliable audio configuration with PipeWire
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Remove JACK to avoid conflicts
    # jack.enable = true;
    
    # Use default wireplumber - no custom configs
    wireplumber.enable = true;
  };
  
  # Essential audio packages only
  environment.systemPackages = with pkgs; [
    pavucontrol     # GUI volume control
    pulseaudio      # CLI tools (pactl, etc.)
    alsa-utils      # ALSA utilities
    pipewire        # PipeWire tools
    wireplumber     # Wireplumber tools
    playerctl       # Media player control
  ];
  
  # Add user to audio group
  users.users.nagih.extraGroups = [ "audio" ];
  
  # Simple systemd socket activation (NixOS default approach)
  systemd.user = {
    # Enable socket activation for automatic startup
    sockets = {
      pipewire.wantedBy = [ "sockets.target" ];
      pipewire-pulse.wantedBy = [ "sockets.target" ];
    };
    
    # Simple service to ensure audio works after login
    services.audio-autostart = {
      description = "Auto-start audio after login";
      after = [ "graphical-session.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScript "audio-autostart" ''
          # Wait for session to be ready
          sleep 2
          
          # Start PipeWire if not running
          if ! ${pkgs.procps}/bin/pgrep -f pipewire >/dev/null 2>&1; then
            ${pkgs.systemd}/bin/systemctl --user start pipewire pipewire-pulse
          fi
          
          # Wait for devices to be detected
          sleep 3
          
          # Set default sink if none is set
          if [ -z "$(${pkgs.pulseaudio}/bin/pactl get-default-sink 2>/dev/null)" ]; then
            # Get first available sink and set as default
            first_sink=$(${pkgs.pulseaudio}/bin/pactl list short sinks | head -n1 | cut -f2)
            if [ -n "$first_sink" ]; then
              ${pkgs.pulseaudio}/bin/pactl set-default-sink "$first_sink"
            fi
          fi
        '';
        RemainAfterExit = true;
      };
    };
  };
}
