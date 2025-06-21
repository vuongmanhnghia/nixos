{ lib, ... }:

let
  # Try to import secrets.nix, fallback to empty set if file doesn't exist
  secretsPath = ../secrets.nix;
  secrets = if builtins.pathExists secretsPath 
    then import secretsPath 
    else {
      syncthing = {
        guiPassword = "CHANGE_ME";
        devices = {
          laptop = "CHANGE_ME";
          desktop = "CHANGE_ME";
        };
      };
    };
in
{
  inherit secrets;
  
  # Helper function to get syncthing config
  getSyncthingConfig = username: {
    gui = {
      address = "127.0.0.1:8384";
      user = username;
      password = secrets.syncthing.guiPassword;
    };
    
    devices = {
      "laptop" = { id = secrets.syncthing.devices.laptop; };
      "desktop" = { id = secrets.syncthing.devices.desktop; };
    };
  };
} 