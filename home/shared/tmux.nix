{ config, pkgs, lib, ... }:

{
  # === MODERN TMUX CONFIGURATION 2025 - FIXED CONFLICTS ===
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";         # Match existing config
    historyLimit = 100000;               # Large scrollback buffer
    keyMode = "vi";                      # Vi-style key bindings
    customPaneNavigationAndResize = false; # DISABLE to prevent conflicts
    escapeTime = 0;                      # Remove escape delay
    aggressiveResize = true;             # Aggressive resize for better multi-client support
    
    # === CUSTOM PREFIX (from original tmux.conf) ===
    prefix = "C-a";                      # Using C-a instead of C-Space (from original config)
    
    # === ESSENTIAL PLUGINS FOR PRODUCTIVITY (CONFLICT-FREE) ===
    plugins = with pkgs.tmuxPlugins; [
      # === VISUAL ENHANCEMENT ===
      {
        plugin = catppuccin;
        extraConfig = ''
          # === CATPPUCCIN THEME CONFIGURATION (from original tmux.conf) ===
          set -g @catppuccin_flavour 'mocha'
          set -g @catppuccin_window_status_style "basic"
          set -g status-interval 120
        '';
      }
      
      # === SESSION MANAGEMENT (CONFLICT-FREE) ===
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
      
      # === PRODUCTIVITY ENHANCEMENTS (CONFLICT-FREE) ===
      {
        plugin = tmux-fzf;
        extraConfig = ''
          # === TMUX-FZF CONFIGURATION ===
          TMUX_FZF_LAUNCH_KEY="C-f"
          TMUX_FZF_ORDER="session|window|pane|command|keybinding|clipboard|process"
          TMUX_FZF_PANE_FORMAT="[#{window_name}] #{pane_current_command}  [#{pane_width}x#{pane_height}] [history #{history_size}/#{history_limit}, #{history_bytes} bytes] #{?pane_active,[active],[inactive]}"
        '';
      }
      
      # === SAFE PLUGINS (NO CONFLICTS) ===
      yank
      better-mouse-mode
      sensible
      # REMOVED: pain-control (conflicts with custom h,j,k,l bindings)
      # REMOVED: vim-tmux-navigator (conflicts with resize bindings)
    ];

    # === COMPREHENSIVE TMUX CONFIGURATION - FIXED CONFLICTS ===
    extraConfig = ''
      # === TERMINAL AND COLOR SETTINGS (from original tmux.conf) ===
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"
      
      # === PREFIX CONFIGURATION (from original tmux.conf) ===
      unbind C-b
      set -g prefix C-a
      bind-key C-a send-prefix
      
      # === MOUSE SUPPORT ===
      set -g mouse on
      
      # === WINDOW AND PANE SETTINGS (from original tmux.conf) ===
      set -g base-index 1              # Start windows at 1
      set -g pane-base-index 1         # Start panes at 1  
      set -g renumber-windows on       # Renumber windows when one is closed
      set -g automatic-rename on       # Automatically rename windows
      set -g automatic-rename-format '#{b:pane_current_path}'
      
      # === SESSION SETTINGS ===
      set -g detach-on-destroy off     # Don't exit from tmux when closing a session
      set -g set-titles on             # Set terminal title
      set -g set-titles-string "tmux - #S (#I:#W)"  # More descriptive title: "tmux - session_name (window_index:window_name)"
      
      # === VISUAL SETTINGS ===
      set -g monitor-activity on       # Monitor for activity
      set -g visual-activity off       # Don't show visual notification
      set -g bell-action none          # Disable bell
      
      # === UNBIND DEFAULT KEYS (from original tmux.conf) ===
      unbind %      # Remove default horizontal split
      unbind '"'    # Remove default vertical split
      unbind r      # Remove default refresh
      
      # === CLEAR VIM-TMUX-NAVIGATOR BINDINGS (PREVENT CONFLICTS) ===
      unbind C-h
      unbind C-j
      unbind C-k
      unbind C-l
      
      # === CUSTOM KEY BINDINGS (FIXED - NO CONFLICTS) ===
      
      # === PANE SPLITTING (from original tmux.conf) ===
      bind '\' split-window -h -c '#{pane_current_path}'
      bind '¥' split-window -h -c '#{pane_current_path}'
      bind - split-window -v -c '#{pane_current_path}'
      
      # === CONFIGURATION RELOAD (FIXED PATH) ===
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config Reloaded!"
      
      # === PANE RESIZING (FIXED - CLEAR BINDINGS FIRST) ===
      # Clear any conflicting bindings first
      unbind h
      unbind j  
      unbind k
      unbind l
      
      # Set our custom resize bindings (from original tmux.conf)
      bind -r h resize-pane -L 5
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r m resize-pane -Z        # Toggle pane zoom
      
      # === PANE NAVIGATION (CUSTOM - NO PLUGIN CONFLICTS) ===
      # Use arrow keys for navigation to avoid h,j,k,l conflicts
      bind -r Left select-pane -L
      bind -r Down select-pane -D
      bind -r Up select-pane -U
      bind -r Right select-pane -R
      
      # Alternative navigation with prefix + direction
      bind H select-pane -L
      bind J select-pane -D  
      bind K select-pane -U
      bind L select-pane -R
      
      # === COPY MODE (VI-STYLE) (from original tmux.conf) ===
      set-window-option -g mode-keys vi
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection
      unbind -T copy-mode-vi MouseDragEnd1Pane
      
      # === WINDOW MANAGEMENT (from original tmux.conf) ===
      bind c new-window -c '#{pane_current_path}'  # New window in current path
      
      # === PRODUCTIVITY SHORTCUTS (from original tmux.conf) ===
      # Notes and todos (using current date format from original)
      bind -r e split-window -h "nvim ~/Documents/git/scratch/notes_$(date +'%Y%m%d%H').md"
      bind -r v split-window -h -c "#{pane_current_path}" "zsh -c 'nvim; exec zsh'"
      bind -r o split-window -h "nvim ~/Documents/git/scratch/todo_$(date +'%y%m%d').md"
      
      # === ADDITIONAL MODERN BINDINGS (CONFLICT-FREE) ===
      # Quick pane commands
      bind Tab select-pane -t :.+     # Switch to next pane
      bind BTab select-pane -t :.-    # Switch to previous pane
      
      # Window navigation
      bind -r p previous-window
      bind -r n next-window
      bind \\; last-window            # Use \; instead of L to avoid conflict
      
      # Window moving
      bind -r "<" swap-window -d -t -1
      bind -r ">" swap-window -d -t +1
      
      # === SESSION MANAGEMENT ===
      bind s choose-tree -Zs          # Session switcher
      bind S new-session              # New session
      
      # === DEVELOPMENT HELPERS (IMPROVED BINDINGS) ===
      # Quick file browser (use F instead of f to avoid conflicts)
      bind F new-window -n "files" "ranger"
      bind C-f split-window -h "ranger"
      
      # Git status in new pane
      bind g split-window -v -c "#{pane_current_path}" "git status && echo 'Press any key to close...' && read"
      
      # Quick system monitor
      bind M new-window -n "monitor" "btop"
      
      # === TMUX SPECIFIC UTILITIES ===
      # Show all key bindings
      bind ? list-keys
      
      # Pane synchronization toggle
      bind C-s setw synchronize-panes
      
      # Clear screen and history
      bind C-l send-keys 'C-l' \; clear-history
      
      # === STATUS BAR CONFIGURATION (from original tmux.conf) ===
      set -g status-interval 120
      set -g status-left '#S '
      set -g window-status-separator ' '
      set -g window-status-current-format "#[fg=colour255,bg=colour62,bold] #I:#{b:pane_current_path} #[fg=white]"
      set -g window-status-format "#I:#W #[fg=white]"
      set -g status-style fg=white,bg=default
      
      # === CUSTOM STATUS RIGHT (adapted from original tmux.conf) ===
      set -g status-right-length 80
      # Weather info (simplified since we don't have the random_note.sh script)
      set -g status-right '#(curl -s wttr.in/Ho\ Chi\ Minh\ City?format=%%C+%%t+%%p+%%c 2>/dev/null || echo "Weather N/A") | %m-%d %H:%M'
      
      # === CUSTOM STATUS LEFT (from original tmux.conf) ===
      set -g status-left "#[bg=#{@thm_green},fg=#{@thm_crust}]#[reverse]█#[noreverse]#S "
      set -g status-style fg=default,bg=default
      set -g status-bg default
      
      # === WAYLAND CLIPBOARD INTEGRATION ===
      if-shell 'test -n "$WAYLAND_DISPLAY"' {
        bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'wl-copy'
        bind P run 'wl-paste | tmux load-buffer - && tmux paste-buffer'
      }
      
      # === ENVIRONMENT IMPROVEMENTS ===
      set-environment -g TMUX_PLUGIN_MANAGER_PATH "~/.tmux/plugins/"
      
      # === PERFORMANCE OPTIMIZATIONS ===
      set -g focus-events on           # Enable focus events
      set -g default-command "$SHELL"  # Use default shell
      
      # === CONDITIONAL CONFIGURATIONS ===
      # Different configs for different contexts
      if-shell '[ "$SSH_CONNECTION" != "" ]' {
        set -g status-bg red
        set -g status-fg white
        set -g window-status-current-style "bg=red,fg=white,bold"
      }
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
    
    # === WEATHER AND UTILITIES ===
    curl                   # For weather information
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

  # === TMUX SCRIPT DIRECTORY (for custom scripts) ===
  xdg.configFile."tmux/scripts/.keep".text = "# Directory for custom tmux scripts";
}
