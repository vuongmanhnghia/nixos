{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    
    # Cài đặt các package cần thiết cho neovim
    extraPackages = with pkgs; [
      # Language servers
      lua-language-server
      nil # Nix LSP
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted # HTML, CSS, JSON, ESLint
      python3Packages.python-lsp-server
      rust-analyzer
      
      # Formatters và linters
      stylua
      nixpkgs-fmt
      nodePackages.prettier
      black
      isort
      rustfmt

      # Java development (nếu cần)
      # jdt-language-server
    ];
    
    # Plugin configuration sẽ được quản lý bởi Lazy.nvim từ dotfiles
    plugins = [ ];
    
    # Không đặt cấu hình trực tiếp ở đây vì chúng ta sử dụng dotfiles
    extraConfig = "";
  };

  # Tạo symlink đến dotfiles neovim config
  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/Workspaces/Config/nixos/dotfiles/nvim";
    recursive = true;
  };

  # Cài đặt các environment variables cần thiết
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  # Cài đặt shell aliases hữu ích
  programs.bash.shellAliases = {
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
  };

  programs.zsh.shellAliases = {
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
  };

  # Đảm bảo các dependencies runtime được cài đặt
  home.packages = with pkgs; [
    # Clipboard support
    xclip
    wl-clipboard
    
    # Font cho icons (cách mới cho nerd fonts)
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    
    # Terminal multiplexer (cho tmux navigator plugin)
    tmux
    
    # Fuzzy finder
    fzf
    
    # File manager alternative
    ranger
    
    # Additional development tools
    curl
    wget
    unzip
    
    # Database tools (nếu cần)
    sqlite

    # Development tools cơ bản
    git
    ripgrep
    fd
    tree-sitter
    
    # Runtime và compilers (tuỳ chọn, có thể comment nếu không cần)
    # gcc
    # nodejs
    # python3
    # rustc
    # cargo
    
    # Build tools (tuỳ chọn)
    # gnumake
    # cmake
    
    # Debugging tools (tuỳ chọn)
    # delve # Go debugger
    # lldb
    
    # Flutter/Dart (tuỳ chọn)
    # flutter
    # dart
  ];

  # Cấu hình Git (cần thiết cho nhiều plugin)
  programs.git = {
    enable = true;
    # Bạn có thể cấu hình thêm thông tin git ở đây nếu chưa có
  };

  # Cấu hình tmux (cho vim-tmux-navigator)
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    keyMode = "vi";
    extraConfig = ''
      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(\\.[0-9]+)?).*/\\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-h' select-pane -L
      bind-key -T copy-mode-vi 'C-j' select-pane -D
      bind-key -T copy-mode-vi 'C-k' select-pane -U
      bind-key -T copy-mode-vi 'C-l' select-pane -R
      bind-key -T copy-mode-vi 'C-\\' select-pane -l
    '';
  };
}
