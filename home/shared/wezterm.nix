{ config, pkgs, lib, ... }:

{
  # === WEZTERM TERMINAL CONFIGURATION ===
  programs.wezterm = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };

  # === ENVIRONMENT AND DEFAULT TERMINAL SETUP ===
  home.sessionVariables = {
    TERMINAL = "wezterm";
    TERM = "wezterm";
  };

  # === FILE ASSOCIATIONS ===
  xdg.mimeApps.defaultApplications = {
    "application/x-terminal" = "org.wezfurlong.wezterm.desktop";
    "x-scheme-handler/terminal" = "org.wezfurlong.wezterm.desktop";
  };

  # === FONTS FOR WEZTERM (minimal to avoid conflicts) ===
  home.packages = with pkgs; [
    # Only the specific font used by WezTerm
    nerd-fonts.inconsolata     # Match the font in wezterm.lua - this is the only one needed
  ];

  # === FILE COPYING ===
  xdg.configFile."wezterm/wezterm.lua".source = ../../dotfiles/wezterm/wezterm.lua;
  xdg.configFile."wezterm/bg".source = ../../dotfiles/wezterm/bg;

  # === DESKTOP INTEGRATION ===
  xdg.desktopEntries."wezterm-here" = {
    name = "WezTerm Here";
    comment = "Open WezTerm in current directory";
    exec = "wezterm start --cwd %f";
    icon = "org.wezfurlong.wezterm";
    type = "Application";
    categories = [ "System" "TerminalEmulator" ];
  };

  # === GNOME INTEGRATION ===
  dconf.settings = {
    "org/gnome/desktop/applications/terminal" = {
      exec = "wezterm";
      exec-arg = "start";
    };
  };
}
