{ config, pkgs, ... }:

{
  # === BASH SHELL CONFIGURATION ===
  programs.bash = {
    enable = true;
    
    # === COMMAND ALIASES ===
    shellAliases = {
      # === BASIC SYSTEM ALIASES ===
      cls = "clear";
      ll = "eza -la --icons --git --header";
      la = "eza -a --icons";
      l = "eza -CF --icons";
      ls = "eza --icons --group-directories-first";
      
      # === MODERN CLI REPLACEMENTS ===
      cat = "bat --style=numbers,changes,header";
      grep = "rg --color=auto --smart-case";
      find = "fd --color=auto";
      tree = "eza --tree --icons";
      
      # === GIT SHORTCUTS ===
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gc = "git commit -v";
      gcm = "git commit -m";
      gco = "git checkout";
      gcb = "git checkout -b";
      gd = "git diff";
      gds = "git diff --staged";
      gl = "git log --oneline --graph --decorate";
      gp = "git push";
      gpl = "git pull";
      gs = "git status --short";
      gst = "git status";
      
      # === SYSTEM MANAGEMENT ===
      oh = "cd ~/ && echo 'Went back home'";
      config = "cd ~/Workspaces/Config/nixos";
      nixos-rebuild = "sudo nixos-rebuild switch --flake ~/Workspaces/Config/nixos";
      nixos-test = "sudo nixos-rebuild test --flake ~/Workspaces/Config/nixos";
      home-rebuild = "home-manager switch --flake ~/Workspaces/Config/nixos";
      
      # === DEVELOPMENT NAVIGATION ===
      dev = "cd ~/Workspaces/Dev";
      workspaces = "cd ~/Workspaces";
      web = "cd ~/Workspaces/Dev/Web";
      app = "cd ~/Workspaces/Dev/App";
      
      # === TMUX SESSION MANAGEMENT ===
      tm = "tmux";
      tma = "tmux attach-session -t";
      tmn = "tmux new-session -s";
      tms = "tmux list-sessions";
      tmk = "tmux kill-session -t";
      tmd = "tmux detach";
      
      # === SYSTEM MONITORING ===
      htop = "btop";
      df = "duf";
      du = "dust";
      ps = "procs";
      
      # === UTILITY SHORTCUTS ===
      h = "history";
      j = "jobs";
      path = "echo $PATH | tr ':' '\\n'";
      reload = "source ~/.bashrc";
      edit = "nvim";
      
      # === NETWORK UTILITIES ===
      ping = "ping -c 5";
      wget = "wget --continue --progress=bar --timestamping";
      
      # === CLIPBOARD UTILITIES (Wayland) ===
      copy = "wl-copy";
      paste = "wl-paste";
      
      # === DIRECTORY OPERATIONS ===
      mkdir = "mkdir -pv";
      rmdir = "rmdir -v";
      cp = "cp -iv";
      mv = "mv -iv";
      rm = "rm -iv";
      
      # === ARCHIVE OPERATIONS ===
      tarxz = "tar -xvf";
      targz = "tar -czvf";
      untar = "tar -xvf";
    };

    # === MINIMAL BASH CONFIGURATION ===
    bashrcExtra = ''
      # === ENVIRONMENT VARIABLES ===
      export EDITOR="nvim"
      export VISUAL="nvim"
      export BROWSER="firefox"
      export TERMINAL="wezterm"
      export MANPAGER="nvim +Man!"
      
      # === CLI TOOLS CONFIGURATION ===
      export BAT_THEME="TwoDark"
      export BAT_PAGER="less -RF"
      export BAT_STYLE="numbers,changes,header"
      
      export EZA_COLORS="da=36:di=34:fi=0:ln=35:pi=33:so=32:bd=33:cd=33:or=31:mi=31:ex=32"
      export EZA_ICON_SPACING=2
      
      export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
      
      # === FZF CONFIGURATION ===
      if command -v fzf &> /dev/null; then
        export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --color=always --style=numbers --line-range=:500 {}' --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 --color=fg:#cdd6f4,header:#f38ba8,info:#cba6ac,pointer:#f5e0dc --color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6ac,hl+:#f38ba8"
        
        if command -v fd &> /dev/null; then
          export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
          export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
          export FZF_ALT_C_COMMAND='fd --type d . --strip-cwd-prefix --hidden --follow --exclude .git'
        fi
      fi
      
      # === COLOR SUPPORT ===
      export CLICOLOR=1
      export CLICOLOR_FORCE=1
      
      # Enable colored output for common commands
      alias grep='grep --color=auto'
      alias egrep='egrep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias diff='diff --color=auto'
      alias ip='ip --color=auto'
      
      # === HISTORY CONFIGURATION ===
      export HISTSIZE=50000
      export HISTFILESIZE=50000
      export HISTCONTROL=ignoredups:erasedups
      export HISTIGNORE="ls:ll:la:cd:pwd:exit:clear:cls:history"
      export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
      shopt -s histappend
      shopt -s cmdhist
      
      # === BASH OPTIONS ===
      shopt -s autocd                 # cd to directory by typing name
      shopt -s cdspell                # auto-correct typos in cd
      shopt -s checkwinsize           # check window size after commands
      shopt -s expand_aliases         # expand aliases
      shopt -s globstar               # enable ** recursive globbing
      shopt -s nocaseglob             # case-insensitive globbing
      
      # === COLORED MAN PAGES ===
      export LESS_TERMCAP_mb=$'\e[1;32m'      # begin bold
      export LESS_TERMCAP_md=$'\e[1;32m'      # begin blink
      export LESS_TERMCAP_me=$'\e[0m'         # reset bold/blink
      export LESS_TERMCAP_so=$'\e[01;33m'     # begin reverse video
      export LESS_TERMCAP_se=$'\e[0m'         # reset reverse video
      export LESS_TERMCAP_us=$'\e[1;4;31m'    # begin underline
      export LESS_TERMCAP_ue=$'\e[0m'         # reset underline
      
      # === SIMPLE PROMPT ===
      export PS1='\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[0m\]\$ '
    '';
  };

  # === ESSENTIAL PACKAGES ===
  home.packages = with pkgs; [
    nix-index             # For command-not-found functionality
  ];

  # === DIRECTORY ENVIRONMENT MANAGEMENT ===
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
} 
