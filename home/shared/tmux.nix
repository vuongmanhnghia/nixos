{ config, pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # Basic settings
    terminal = "screen-256color";
    historyLimit = 10000;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    
    extraConfig = ''
      # === BASIC SETTINGS ===
      
      # Unbind default prefix and use C-a
      unbind C-b
      bind-key C-a send-prefix
      
      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display "Config reloaded!"
      
      # === WINDOW & PANE MANAGEMENT ===
      
      # Split panes
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      
      # Navigate panes with vim keys
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R
      
      # Resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5
      
      # === COPY MODE ===
      
      bind v copy-mode
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "wl-copy"
      bind p paste-buffer
      
      # === APPEARANCE ===
      
      # Colors
      set -g status-bg colour235
      set -g status-fg colour223
      set -g window-status-current-style "fg=colour235,bg=colour108,bold"
      
      # Status bar
      set -g status-left "#[fg=colour235,bg=colour108,bold] #S "
      set -g status-right " %Y-%m-%d %H:%M "
      
      # === PERFORMANCE ===
      
      set -sg escape-time 0
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on
    '';
    
    # Essential plugins
    plugins = with pkgs.tmuxPlugins; [
      sensible
      yank
    ];
  };
} 