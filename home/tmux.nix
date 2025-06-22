{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # Basic Settings
    terminal = "screen-256color";
    historyLimit = 100000;
    keyMode = "vi";
    mouse = true;
    clock24 = true;
    
    # Custom key bindings
    prefix = "C-a";  # Change prefix from C-b to C-a (easier to reach)
    
    extraConfig = ''
      # === GENERAL SETTINGS ===
      
      # Unbind default prefix and bind new one
      unbind C-b
      bind-key C-a send-prefix
      
      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Config reloaded!"
      
      # === WINDOW & PANE MANAGEMENT ===
      
      # Split panes with intuitive keys
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %
      
      # Create new window with current path
      bind c new-window -c "#{pane_current_path}"
      
      # Switch panes with vim-like navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Resize panes with vim-like keys
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # Switch windows with Alt+number (no prefix needed)
      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
      
      # Quick window switching
      bind -n M-p previous-window
      bind -n M-n next-window
      
      # === COPY MODE SETTINGS ===
      
      # Enter copy mode with prefix + v
      bind v copy-mode
      
      # Copy mode key bindings (vi-style)
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -selection clipboard"
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      
      # Paste with prefix + p
      bind p paste-buffer
      
      # === APPEARANCE & THEMING ===
      
      # Status bar position
      set-option -g status-position top
      
      # Colors (Gruvbox-inspired theme)
      set -g default-terminal "screen-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      
      # Status bar colors
      set -g status-bg colour235
      set -g status-fg colour223
      
      # Window status colors
      set -g window-status-current-style "fg=colour235,bg=colour108,bold"
      set -g window-status-style "fg=colour223,bg=colour239"
      
      # Pane border colors
      set -g pane-border-style "fg=colour239"
      set -g pane-active-border-style "fg=colour108"
      
      # Message colors
      set -g message-style "fg=colour235,bg=colour108"
      set -g message-command-style "fg=colour235,bg=colour108"
      
      # === STATUS BAR CONFIGURATION ===
      
      # Status bar refresh interval
      set -g status-interval 5
      
      # Left status bar
      set -g status-left-length 50
      set -g status-left "#[fg=colour235,bg=colour108,bold] #S #[fg=colour108,bg=colour235] "
      
      # Window list format
      set -g window-status-format " #I:#W#F "
      set -g window-status-current-format " #I:#W#F "
      
      # Right status bar
      set -g status-right-length 80
      set -g status-right "#[fg=colour239,bg=colour235]#[fg=colour223,bg=colour239] %Y-%m-%d #[fg=colour108,bg=colour239]#[fg=colour235,bg=colour108] %H:%M "
      
      # === PERFORMANCE SETTINGS ===
      
      # Reduce escape time for faster key response
      set -sg escape-time 0
      
      # Increase repeat time for repeatable commands
      set -g repeat-time 600
      
      # Start window and pane numbering at 1
      set -g base-index 1
      setw -g pane-base-index 1
      
      # Renumber windows when one is closed
      set -g renumber-windows on
      
      # Enable focus events
      set -g focus-events on
      
      # === SESSION MANAGEMENT ===
      
      # Session navigation
      bind S choose-session
      
      # Quick session switching
      bind -n M-s switch-client -l
      
      # === USEFUL SHORTCUTS ===
      
      # Clear screen and history
      bind C-l send-keys 'C-l'
      bind C-k send-keys 'clear' Enter
      
      # Toggle synchronize panes
      bind e setw synchronize-panes
      
      # Maximize/restore pane
      bind m resize-pane -Z
      
      # Kill pane without confirmation
      bind x kill-pane
      
      # Kill window without confirmation
      bind X kill-window
      
      # === PLUGINS SECTION ===
      # Note: These would need to be installed via additional Nix packages
      # or manually if not using Home Manager plugin system
      
      # Display plugin settings (optional manual install)
      # set -g @plugin 'tmux-plugins/tmux-cpu'
      # set -g @plugin 'tmux-plugins/tmux-battery'
      
      # === DEVELOPMENT SHORTCUTS ===
      
      # Git shortcuts
      bind g new-window -n "git" "git status; $SHELL"
      
      # Quick development setup
      bind D split-window -h -c "#{pane_current_path}" \; split-window -v -c "#{pane_current_path}" \; select-pane -t 0
    '';
    
    # Additional plugins via Nix (optional)
    plugins = with pkgs.tmuxPlugins; [
      sensible      # Basic tmux settings everyone can agree on
      yank          # Copy to system clipboard
      cpu           # Display CPU usage
      {
        plugin = resurrect;   # Restore tmux sessions after restart
        extraConfig = ''
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;   # Continuous saving of tmux environment
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }
    ];
  };
  
  # Optional: Install additional tmux utilities
  home.packages = with pkgs; [
    tmux
    tmuxinator     # Tmux session manager
  ];
} 