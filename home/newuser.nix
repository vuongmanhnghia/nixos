{ config, pkgs, ... }:

{
  imports = [ ./default.nix ];

  # User info
  home.username = "newuser";
  home.homeDirectory = "/home/newuser";
  home.stateVersion = "25.05";

  # User-specific Git config
  programs.git = {
    userName = "New User";
    userEmail = "newuser@example.com";
  };

  # User-specific packages
  home.packages = with pkgs; [
    # Different tools for this user
    libreoffice
    gimp
    firefox
  ];

  # Additional shell aliases for this user
  programs.bash.shellAliases = {
    docs = "cd ~/Documents";
    pics = "cd ~/Pictures";
  };
}
