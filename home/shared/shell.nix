{ config, pkgs, ... }:

{
  # === BASH SHELL CONFIGURATION ===
  programs.bash = {
    enable = true;
    
    # === COMPREHENSIVE COMMAND ALIASES ===
    shellAliases = {
      # === BASIC SYSTEM ALIASES ===
      cls = "clear";                    # Clear terminal (Windows-style)
      ll = "eza -la --icons --git --header";     # Enhanced long listing
      la = "eza -a --icons";                     # List all with icons
      l = "eza -CF --icons";                     # List in columns with icons
      ls = "eza --icons --group-directories-first"; # Better ls with icons
      
      # === MODERN CLI REPLACEMENTS ===
      cat = "bat --style=numbers,changes,header"; # Syntax highlighted cat
      grep = "rg --color=auto --smart-case";      # Better grep with smart case
      find = "fd --color=auto";                   # Better find
      tree = "eza --tree --icons";                # Tree view with icons
      
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
      
      # === SYSTEM MONITORING ===
      top = "btop";
      htop = "btop";
      df = "duf";
      du = "dust";
      ps = "procs";
      
      # === UTILITY SHORTCUTS ===
      h = "history";
      j = "jobs";
      path = "echo $PATH | tr ':' '\n'";
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

    # === ENHANCED BASH CONFIGURATION ===
    bashrcExtra = ''
      # === MODERN PROMPT WITH GIT INTEGRATION ===
      RED='\033[0;31m'
      GREEN='\033[0;32m'
      YELLOW='\033[1;33m'
      BLUE='\033[0;34m'
      PURPLE='\033[0;35m'
      CYAN='\033[0;36m'
      WHITE='\033[1;37m'
      RESET='\033[0m'
      
      # Git branch in prompt
      parse_git_branch() {
        git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
      }
      
      # === DEVELOPMENT ENVIRONMENT VARIABLES ===
      export EDITOR="nvim"
      export VISUAL="nvim"
      export BROWSER="google-chrome"
      export TERMINAL="wezterm"
      export MANPAGER="nvim +Man!"
      
      # === BAT CONFIGURATION ===
      export BAT_THEME="TwoDark"
      export BAT_PAGER="less -RF"
      export BAT_STYLE="numbers,changes,header"
      
      # === EZA CONFIGURATION ===
      export EZA_COLORS="da=36:di=34:fi=0:ln=35:pi=33:so=32:bd=33:cd=33:or=31:mi=31:ex=32"
      export EZA_ICON_SPACING=2
      
      # === RIPGREP CONFIGURATION ===
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
      
      # === COMMAND SYNTAX HIGHLIGHTING ===
      # Real-time command highlighting with ble.sh
      export CLICOLOR=1
      export CLICOLOR_FORCE=1
      
      # Enable colored output for common commands
      alias grep='grep --color=auto'
      alias egrep='egrep --color=auto'
      alias fgrep='fgrep --color=auto'
      alias diff='diff --color=auto'
      alias ip='ip --color=auto'
      
      # === BLE.SH INTEGRATION FOR REAL-TIME HIGHLIGHTING ===
      # Load ble.sh if available for advanced bash line editing
      if [[ -f "${pkgs.blesh}/share/blesh/ble.sh" ]]; then
        source "${pkgs.blesh}/share/blesh/ble.sh"
        
        # Configure ble.sh for syntax highlighting (fixed configuration)
        bleopt complete_auto_complete=on
        bleopt complete_menu_color=on
        bleopt complete_ambiguous=on
        
        # Use working completion menu style
        bleopt complete_menu_style=linewise
        
        # Custom highlighting colors (only define colors that exist)
        ble-color-setface command_builtin bright-green
        ble-color-setface command_function bright-cyan
        ble-color-setface command_alias bright-blue
        ble-color-setface filename bright-white
        ble-color-setface argument bright-cyan
        ble-color-setface varname bright-yellow
        ble-color-setface option bright-magenta
        
      else
        # Fallback: Load bash-preexec for basic highlighting
        if [[ -f "${pkgs.bash-preexec}/share/bash/bash-preexec.sh" ]]; then
          source "${pkgs.bash-preexec}/share/bash/bash-preexec.sh"
        fi
        
        # Enhanced readline configuration
        if [[ -n "$PS1" ]]; then
          bind 'set colored-stats on'
          bind 'set colored-completion-prefix on'
          bind 'set completion-ignore-case on'
          bind 'set show-all-if-ambiguous on'
          bind 'set show-all-if-unmodified on'
          bind 'set menu-complete-display-prefix on'
          bind 'set visible-stats on'
        fi
        
        # Pre-execution highlighting
        if declare -f preexec > /dev/null 2>&1; then
          preexec() {
            local cmd="$1"
            local first_word=$(echo "$cmd" | awk '{print $1}')
            
            echo -en "\033[1A\033[2K"
            if command -v "$first_word" &> /dev/null 2>&1; then
              echo -e "\033[32m➤\033[0m \033[1;32m$first_word\033[0;36m ''${cmd#* }\033[0m"
            else
              echo -e "\033[31m✗\033[0m \033[1;31m$first_word\033[0;36m ''${cmd#* }\033[0m"
            fi
          }
        fi
      fi
      
      # Enhanced prompt with git support
      export PS1="\[\e[32m\]\u@\h\[\e[0m\]:\[\e[34m\]\w\[\e[33m\]\$(parse_git_branch)\[\e[0m\]\$ "
      
      # === ENHANCED BASH COMPLETION ===
      # Load bash completion if available
      if [[ -f /run/current-system/sw/share/bash-completion/bash_completion ]]; then
        source /run/current-system/sw/share/bash-completion/bash_completion
      fi
      
      # Enable programmable completion features
      if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
        source /etc/bash_completion
      fi
      
      # Color completion based on file types
      if command -v dircolors >/dev/null 2>&1; then
        eval "$(dircolors -b)"
        export LS_COLORS
        # Set colored completion
        bind 'set colored-stats on'
        bind 'set colored-completion-prefix on'
        bind 'set completion-ignore-case on'
        bind 'set show-all-if-ambiguous on'
        bind 'set show-all-if-unmodified on'
        bind 'set menu-complete-display-prefix on'
      fi
      
      # === COMMAND CORRECTION ===
      # Enable thefuck if available
      if command -v thefuck &> /dev/null; then
        eval "$(thefuck --alias)"
        # Use double ESC to trigger correction
        bind '"\e\e": "\C-a\C-kfuck\C-m"'
      fi
      
      # === MCFLY HISTORY SEARCH ===
      # Enable mcfly if available
      if command -v mcfly &> /dev/null; then
        eval "$(mcfly init bash)"
        export MCFLY_KEY_SCHEME=vim
        export MCFLY_FUZZY=true
        export MCFLY_RESULTS=20
      fi
      
      # === COMMAND NOT FOUND HANDLER ===
      command_not_found_handle() {
        echo -e "\033[1;31mCommand '$1' not found.\033[0m"
        
        # Try to suggest from nix packages
        if command -v nix-locate &> /dev/null; then
          echo -e "\033[1;33mSearching in nixpkgs...\033[0m"
          local results=$(nix-locate --minimal --no-group --type x --type s --top-level --whole-name --at-root "/bin/$1" 2>/dev/null | head -5)
          if [[ -n "$results" ]]; then
            echo -e "\033[1;32mFound in packages:\033[0m"
            echo "$results" | while read -r line; do
              echo "  nix-shell -p $(echo "$line" | cut -d. -f1)"
            done
          fi
        fi
        
        # Suggest similar commands
        if command -v which &> /dev/null; then
          echo -e "\033[1;33mSimilar commands:\033[0m"
          compgen -c | grep -i "$1" | head -3 | while read -r cmd; do
            echo "  $cmd"
          done
        fi
        
        return 127
      }
      
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
      
      # === LESSOPEN FOR SYNTAX HIGHLIGHTING ===
      if command -v highlight &> /dev/null; then
        export LESSOPEN="| highlight --out-format=ansi --force %s"
      fi
      
      # === USEFUL FUNCTIONS ===
      # Quick file preview
      preview() {
        if [[ -f "$1" ]]; then
          bat --color=always --style=header,grid "$1"
        elif [[ -d "$1" ]]; then
          eza --tree --icons --level=2 "$1"
        fi
      }
      
      # FZF file preview
      fzf-preview() {
        fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'
      }
      
      # Quick extract function
      extract() {
        if [[ -f $1 ]]; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }
      
      # Create directory and cd into it
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      # Quick backup
      backup() {
        cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
      }
      
      # Weather function
      weather() {
        curl -s "wttr.in/$1?format=3"
      }
      
      # === CLEAN WELCOME MESSAGE ===
      if [[ $- == *i* ]] && [[ -z "$WELCOME_SHOWN" ]]; then
        export WELCOME_SHOWN=1
        echo -e "\e[32m╭─ Welcome to NixOS Terminal\e[0m"
        echo -e "\e[32m├─ User: \e[36m$(whoami)\e[0m"
        echo -e "\e[32m├─ Shell: \e[36mbash $BASH_VERSION\e[0m"
        echo -e "\e[32m├─ Uptime: \e[36m$(cat /proc/uptime | awk '{print int($1/3600)"h "int(($1%3600)/60)"m"}')\e[0m"
        echo -e "\e[32m╰─ Type 'help' for available aliases\e[0m"
      fi
      
      # === HELP FUNCTION ===
      help() {
        echo -e "\e[33m=== Available Aliases ===\e[0m"
        alias | sort | column -t -s'=' | sed 's/alias //' | head -20
        echo -e "\e[33m... (type 'alias' to see all)\e[0m"
      }
    '';
  };

  # === ADDITIONAL PACKAGES FOR SYNTAX HIGHLIGHTING AND ZSH ===
  home.packages = with pkgs; [
    # Bash tools
    bash-preexec          # Preexec hook for bash
    nix-index             # For command-not-found functionality
    
    # ZSH tools  
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
    nix-zsh-completions
    zsh-powerlevel10k     # Beautiful and fast ZSH theme
    
    # Fonts for powerlevel10k (new format)
    nerd-fonts.meslo-lg
  ];

  # === DIRECTORY ENVIRONMENT MANAGEMENT ===
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # === ZSH SHELL CONFIGURATION (RECOMMENDED FOR SYNTAX HIGHLIGHTING) ===
  programs.zsh = {
    enable = true;
    
    # === ZSH-SPECIFIC ALIASES (inherit from bash) ===
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
      
      # === SYSTEM MONITORING ===
      top = "btop";
      htop = "btop";
      df = "duf";
      du = "dust";
      ps = "procs";
      
      # === UTILITY SHORTCUTS ===
      h = "history";
      j = "jobs";
      path = "echo $PATH | tr ':' '\n'";
      reload = "source ~/.zshrc";
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

    # === ZSH CONFIGURATION ===
    initExtra = ''
      # === POWERLEVEL10K THEME ===
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      
      # Load custom Powerlevel10k configuration
      if [[ -f ~/.config/dotfiles/zsh/p10k.zsh ]]; then
        source ~/.config/dotfiles/zsh/p10k.zsh
      fi
      
      # === ZSH SYNTAX HIGHLIGHTING ===
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      
      # === SYNTAX HIGHLIGHTING COLORS (TOKYO NIGHT THEME) ===
      ZSH_HIGHLIGHT_STYLES[command]='fg=#9ece6a,bold'           # Green for commands
      ZSH_HIGHLIGHT_STYLES[builtin]='fg=#9ece6a,bold'           # Green for builtins
      ZSH_HIGHLIGHT_STYLES[function]='fg=#7dcfff,bold'          # Cyan for functions
      ZSH_HIGHLIGHT_STYLES[alias]='fg=#7aa2f7,bold'             # Blue for aliases
      ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e,bold'     # Red for unknown
      ZSH_HIGHLIGHT_STYLES[path]='fg=#bb9af7'                   # Purple for paths
      ZSH_HIGHLIGHT_STYLES[globbing]='fg=#e0af68'               # Yellow for globbing
      ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#7aa2f7'      # Blue for history
      ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#7dcfff'   # Cyan for substitution
      ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#7dcfff'
      ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#7dcfff'
      ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#7dcfff'
      ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#e0af68'   # Yellow for options
      ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#e0af68'
      ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#7dcfff'
      ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ece6a'
      ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ece6a'
      ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#9ece6a'
      ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#9ece6a'
      ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#7dcfff'
      ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#7dcfff'
      ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#7dcfff'
      ZSH_HIGHLIGHT_STYLES[assign]='fg=#bb9af7'                 # Purple for assignments
      ZSH_HIGHLIGHT_STYLES[redirection]='fg=#e0af68'            # Yellow for redirection
      ZSH_HIGHLIGHT_STYLES[comment]='fg=#565f89,bold'           # Dim for comments
      ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#e0af68'
      ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#e0af68'
      
      # === AUTOSUGGESTIONS CONFIGURATION ===
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'              # Dim gray suggestions
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
      
      # === ZSH OPTIONS ===
      setopt AUTO_CD              # cd by typing directory name
      setopt CORRECT              # command correction
      setopt HIST_VERIFY          # verify history expansions
      setopt SHARE_HISTORY        # share history between sessions
      setopt APPEND_HISTORY       # append to history file
      setopt INC_APPEND_HISTORY   # append immediately
      setopt HIST_IGNORE_DUPS     # ignore duplicate commands
      setopt HIST_IGNORE_SPACE    # ignore commands starting with space
      setopt GLOB_COMPLETE        # complete globs
      setopt AUTO_LIST            # automatically list choices
      setopt AUTO_MENU            # show completion menu
      setopt COMPLETE_IN_WORD     # complete from both ends
      setopt ALWAYS_TO_END        # move cursor to end
      
      # === ENVIRONMENT VARIABLES ===
      export EDITOR="nvim"
      export VISUAL="nvim"
      export BROWSER="google-chrome"
      export TERMINAL="wezterm"
      export MANPAGER="nvim +Man!"
      export BAT_THEME="TwoDark"
      export BAT_PAGER="less -RF"
      export BAT_STYLE="numbers,changes,header"
      export EZA_COLORS="da=36:di=34:fi=0:ln=35:pi=33:so=32:bd=33:cd=33:or=31:mi=31:ex=32"
      export EZA_ICON_SPACING=2
      export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
      
      # === HISTORY CONFIGURATION ===
      HISTSIZE=50000
      SAVEHIST=50000
      HISTFILE=~/.zsh_history
      
      # === USEFUL FUNCTIONS ===
      preview() {
        if [[ -f "$1" ]]; then
          bat --color=always --style=header,grid "$1"
        elif [[ -d "$1" ]]; then
          eza --tree --icons --level=2 "$1"
        fi
      }
      
      extract() {
        if [[ -f $1 ]]; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar x $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
          esac
        else
          echo "'$1' is not a valid file"
        fi
      }
      
      mkcd() {
        mkdir -p "$1" && cd "$1"
      }
      
      backup() {
        cp "$1"{,.backup-$(date +%Y%m%d-%H%M%S)}
      }
      
      weather() {
        curl -s "wttr.in/$1?format=3"
      }
      
      # === WELCOME MESSAGE ===
      if [[ -z "$WELCOME_SHOWN" ]]; then
        export WELCOME_SHOWN=1
        echo -e "\e[32m╭─ Welcome to NixOS Terminal (ZSH)\e[0m"
        echo -e "\e[32m├─ User: \e[36m$(whoami)\e[0m"
        echo -e "\e[32m├─ Shell: \e[36mzsh $ZSH_VERSION\e[0m"
        echo -e "\e[32m├─ Uptime: \e[36m$(cat /proc/uptime | awk '{print int($1/3600)"h "int(($1%3600)/60)"m"}')\e[0m"
        echo -e "\e[32m╰─ Type 'help' for available aliases\e[0m"
      fi
      
      # === HELP FUNCTION ===
      help() {
        echo -e "\e[33m=== Available Aliases ===\e[0m"
        alias | sort | head -20
        echo -e "\e[33m... (type 'alias' to see all)\e[0m"
      }
    '';
    
    # === ZSH COMPLETION ===
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    # === ZSH HISTORY ===
    history = {
      size = 50000;
      save = 50000;
      ignoreDups = true;
      ignoreSpace = true;
      share = true;
    };
  };
} 