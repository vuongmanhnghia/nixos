{ config, pkgs, lib, ... }:

{
  # === TMUX CONFIGURATION - USING EXTERNAL tmux.conf ===
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    historyLimit = 100000;
    keyMode = "vi";
    escapeTime = 0;
    aggressiveResize = true;
    
    # === ESSENTIAL PLUGINS ONLY ===
    plugins = with pkgs.tmuxPlugins; [
      # Theme plugin
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_status_style "basic"
        '';
      }
      
      # Session management
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-save-bash-history 'on'
          set -g @resurrect-processes 'ssh,mosh,~nvim'
          set -g @resurrect-save 'S'
          set -g @resurrect-restore 'R'
        '';
      }
      
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
          set -g @continuum-boot 'on'
          set -g @continuum-systemd-start-cmd 'new-session -d'
        '';
      }
      
      # Utility plugins
      yank
      better-mouse-mode
      sensible
    ];

    # === MINIMAL EXTRA CONFIG - LET tmux.conf HANDLE THE REST ===
    extraConfig = ''
      # Source the main tmux configuration file
      source-file ~/.config/tmux/tmux.conf
      
      # Wayland clipboard integration
      if-shell 'test -n "$WAYLAND_DISPLAY"' {
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
        bind P run 'wl-paste | tmux load-buffer - && tmux paste-buffer'
      }
      
      # Performance optimizations
      set -g focus-events on
      set -g default-command "$SHELL"
      
      # SSH session indicator
      if-shell '[ "$SSH_CONNECTION" != "" ]' {
        set -g status-bg red
        set -g status-fg white
        set -g window-status-current-style "bg=red,fg=white,bold"
      }
    '';
  };

  # === COPY tmux.conf TO THE CORRECT LOCATION ===
  xdg.configFile."tmux/tmux.conf".source = ../../dotfiles/tmux/tmux.conf;
  
  # === TMUX-RELATED PACKAGES ===
  home.packages = with pkgs; [
    tmux
    tmuxp
    teamocil
    ranger
    btop
    lazygit
    wl-clipboard
    xclip
    curl
  ];

  # === TMUX SESSION CONFIGURATIONS ===
  xdg.configFile."tmuxp/dev.yaml".text = ''
    session_name: dev
    start_directory: ~/Workspaces/Dev
    windows:
      - window_name: editor
        start_directory: ~/Workspaces/Dev
        panes:
          - nvim
      - window_name: terminal
        start_directory: ~/Workspaces/Dev
        panes:
          - clear
      - window_name: git
        start_directory: ~/Workspaces/Dev
        panes:
          - lazygit    curl

      - window_name: system
        panes:
          - btop
  '';

  xdg.configFile."tmuxp/web.yaml".text = ''
    session_name: web
    start_directory: ~/Workspaces/Dev/Web
    windows:
      - window_name: editor
        start_directory: ~/Workspaces/Dev/Web
        panes:
          - nvim
      - window_name: server
        start_directory: ~/Workspaces/Dev/Web
        panes:
          - echo "Ready for web development"
      - window_name: browser
        panes:
          - echo "Browser testing terminal"
  '';

  # === TMUX SCRIPT DIRECTORY ===
  xdg.configFile."tmux/scripts/.keep".text = "# Directory for custom tmux scripts";
}
