{ config, pkgs, ... }:

{
  # Desktop environment configuration modules
  imports = [
    ./hyprland.nix # Hyprland window manager (basic setup)
    ./audio.nix    # PipeWire audio system with low-latency configuration
    ./graphics.nix # NVIDIA graphics drivers and GPU support
    ./fonts.nix    # System fonts and font configuration
  ];
} 