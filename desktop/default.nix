{ config, pkgs, ... }:

{
  # Desktop environment configuration modules
  imports = [
    ./gnome.nix    # GNOME desktop environment with modern extensions
    ./audio.nix    # PipeWire audio system with low-latency configuration
    ./graphics.nix # NVIDIA graphics drivers and GPU support
    ./fonts.nix    # System fonts and font configuration
  ];
} 