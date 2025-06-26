{ config, pkgs, lib, ... }:

{
  # === MODERN TMUX CONFIGURATION 2025 ===
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";          # Enable 256 color support
    historyLimit = 100000;               # Large scrollback buffer
    keyMode = "vi";                      # Vi-style key bindings
    customPaneNavigationAndResize = true; # Enable custom navigation
    escapeTime = 0;                      # Remove escape delay
    aggressiveResize = true;             # Aggressive resize for better multi-client support
    
    # === MODERN TMUX PREFIX ===
    prefix = "C-Space";                  # Space is easier to reach than 'b'
    
    # === ESSENTIAL PLUGINS FOR PRODUCTIVITY ===
    plugins = with pkgs.tmuxPlugins; [
      # === VISUAL ENHANCEMENT ===
      {
        plugin = catppuccin;
        extraConfig = ''
          # === CATPPUCCIN THEME CONFIGURATION ===
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_status_style "basic"
          set -g @catppuccin_status_modules_right "directory user host session"
          set -g @catppuccin_status_modules_left ""
          set -g @catppuccin_window_left_separator ""
          set -g @catppuccin_window_right_separator " "
          set -g @catppuccin_window_middle_separator " █"
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_default_fill "number"
          set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_fill "number"
          set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
          set -g @catppuccin_status_left_separator  " "
          set -g @catppuccin_status_right_separator " "
          set -g @catppuccin_status_right_separator_inverse "no"
          set -g @catppuccin_status_fill "icon"
          set -g @catppuccin_status_connect_separator "no"
          set -g @catppuccin_directory_text "#{b:pane_current_path}"
          set -g @catppuccin_date_time_text "%H:%M"
        '';
      }
      
      # === NAVIGATION AND WORKFLOW ===
      {
        plugin = vim-tmux-navigator;
        extraConfig = ''
          # === VIM-TMUX NAVIGATOR CONFIGURATION ===
          # Smart pane switching with awareness of Vim splits
          # C-h, C-j, C-k, C-l for seamless navigation
          set -g @vim_navigator_mapping_left "C-h"
          set -g @vim_navigator_mapping_down "C-j"
          set -g @vim_navigator_mapping_up "C-k"
          set -g @vim_navigator_mapping_right "C-l"
          set -g @vim_navigator_mapping_prev ""
        '';
      }
      
      # === SESSION MANAGEMENT ===
      {
        plugin = resurrect;
        extraConfig = ''
          # === TMUX RESURRECT CONFIGURATION ===
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-save-bash-history 'on'
          set -g @resurrect-processes 'ssh,mosh,~nvim'
          
          # Save more session details
          set -g @resurrect-save 'S'
          set -g @resurrect-restore 'R'
        '';
      }
      
      {
        plugin = continuum;
        extraConfig = ''
          # === TMUX CONTINUUM CONFIGURATION ===
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
          set -g @continuum-boot 'on'
          
          # Automatic tmux start
          set -g @continuum-systemd-start-cmd 'new-session -d'
        '';
      }
      
      # === PRODUCTIVITY ENHANCEMENTS ===
      {
        plugin = tmux-fzf;
        extraConfig = ''
          # === TMUX-FZF CONFIGURATION ===
          TMUX_FZF_LAUNCH_KEY="C-f"
          TMUX_FZF_ORDER="session|window|pane|command|keybinding|clipboard|process"
          TMUX_FZF_PANE_FORMAT="[#{window_name}] #{pane_current_command}  [#{pane_width}x#{pane_height}] [history #{history_size}/#{history_limit}, #{history_bytes} bytes] #{?pane_active,[active],[inactive]}"
        '';
      }
      
      yank
      better-mouse-mode
      sensible
      pain-control
      
      # === ADDITIONAL MODERN PLUGINS ===
      # Removed tmux-weather as it's not available in pkgs.tmuxPlugins
    ];

    # === COMPREHENSIVE TMUX CONFIGURATION ===
    extraConfig = ''
      # === TERMINAL AND COLOR SETTINGS ===
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"
      
      # === MOUSE SUPPORT ===
      set -g mouse on
      
      # === WINDOW AND PANE SETTINGS ===
      set -g base-index 1              # Start windows at 1
      set -g pane-base-index 1         # Start panes at 1
      set -g renumber-windows on       # Renumber windows when one is closed
      set -g automatic-rename on       # Automatically rename windows
      set -g automatic-rename-format '#{b:pane_current_path}'
      
      # === SESSION SETTINGS ===
      set -g detach-on-destroy off     # Don't exit from tmux when closing a session
      set -g set-titles on             # Set terminal title
      set -g set-titles-string "#I:#W"
      
      # === VISUAL SETTINGS ===
      set -g monitor-activity on       # Monitor for activity
      set -g visual-activity off       # Don't show visual notification
      set -g bell-action none          # Disable bell
      
      # === STATUS BAR CONFIGURATION ===
      set -g status on
      set -g status-interval 5
      set -g status-position bottom
      set -g status-justify left
      
      # === UNBIND DEFAULT KEYS ===
      unbind C-b    # Remove default prefix
      unbind %      # Remove default horizontal split
      unbind '"'    # Remove default vertical split
      unbind x      # Remove default pane kill
      
      # === MODERN KEY BINDINGS ===
      
      # Prefix key
      bind C-Space send-prefix
      
      # === PANE MANAGEMENT ===
      # Intuitive pane splitting
      bind | split-window -h -c "#{pane_current_path}"
      bind \\ split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"
      
      # Pane resizing (repeatable)
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # Pane management
      bind x kill-pane                     # Kill pane
      bind X kill-window                   # Kill window
      bind q display-panes                 # Display pane numbers
      bind m resize-pane -Z                # Toggle pane zoom
      
      # === WINDOW MANAGEMENT ===
      # New window in current path
      bind c new-window -c "#{pane_current_path}"
      bind C new-window
      
      # Window navigation
      bind -r p previous-window
      bind -r n next-window
      bind Tab last-window
      
      # Window moving
      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1
      
      # === SESSION MANAGEMENT ===
      bind s choose-tree -Zs              # Session switcher
      bind S new-session                  # New session
      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      
      # === COPY MODE (VI-STYLE) ===
      setw -g mode-keys vi
      bind Enter copy-mode                 # Enter copy mode
      bind -T copy-mode-vi v send-keys -X begin-selection
      bind -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      bind -T copy-mode-vi Escape send-keys -X cancel
      bind -T copy-mode-vi H send-keys -X start-of-line
      bind -T copy-mode-vi L send-keys -X end-of-line
      
      # === QUICK ACTIONS ===
      # Quick pane commands
      bind o select-pane -t :.+           # Switch to next pane
      bind O select-pane -t :.-           # Switch to previous pane
      
      # === DEVELOPMENT HELPERS ===
      # Quick editor access
      bind e new-window -n "editor" "nvim"
      bind E split-window -h "nvim"
      
      # Quick file browser
      bind f new-window -n "files" "ranger"
      bind F split-window -h "ranger"
      
      # Git status in new pane
      bind g split-window -v -c "#{pane_current_path}" "git status && echo 'Press any key to close...' && read"
      
      # === PRODUCTIVITY SHORTCUTS ===
      # Notes and todos (using current date)
      bind N split-window -h "nvim ~/Documents/notes/$(date +'%Y-%m-%d').md"
      bind T split-window -h "nvim ~/Documents/todos/$(date +'%Y-%m-%d').md"
      
      # Quick system monitor
      bind M new-window -n "monitor" "btop"
      
      # === ADVANCED FEATURES ===
      # Nested tmux session support
      bind -n C-t new-window -a
      bind -n S-left  prev
      bind -n S-right next
      bind -n S-C-left  swap-window -t -1 \; previous-window
      bind -n S-C-right swap-window -t +1 \; next-window
      
      # === WAYLAND CLIPBOARD INTEGRATION ===
      if-shell 'test -n "$WAYLAND_DISPLAY"' {
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
        bind p run 'wl-paste | tmux load-buffer - && tmux paste-buffer'
      }
      
      # === ENVIRONMENT IMPROVEMENTS ===
      set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins/"
      
      # === PERFORMANCE OPTIMIZATIONS ===
      set -g focus-events on               # Enable focus events
      set -g default-command "$SHELL"      # Use default shell
      
      # === THEME CUSTOMIZATIONS ===
      # Window status format
      setw -g window-status-activity-style "none"
      setw -g window-status-separator ""
      
      # === CONDITIONAL CONFIGURATIONS ===
      # Different configs for different contexts
      if-shell '[ "$SSH_CONNECTION" != "" ]' {
        set -g status-bg red
        set -g status-fg white
        set -g window-status-current-style "bg=red,fg=white,bold"
      }
      
      # === PLUGIN MANAGER (TPM) ===
      # Keep this at the very bottom
      run '~/.tmux/plugins/tpm/tpm'
    '';
  };

  # === ADDITIONAL TMUX-RELATED PACKAGES ===
  home.packages = with pkgs; [
    # === TMUX ECOSYSTEM ===
    tmux                    # Main tmux package
    tmuxp                   # Tmux session manager with YAML configs
    teamocil               # Simple tmux session management
    
    # === TERMINAL UTILITIES FOR TMUX ===
    ranger                  # Terminal file manager
    btop                    # Modern system monitor
    lazygit                 # Terminal git UI
    
    # === CLIPBOARD UTILITIES ===
    wl-clipboard           # Wayland clipboard (wl-copy, wl-paste)
    xclip                  # X11 clipboard support
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
          - lazygit
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
}
