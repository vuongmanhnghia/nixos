# home/shared/ripgrep.nix - Home Manager configuration for ripgrep
{ config, pkgs, ... }:

{
  # Cài đặt ripgrep
  home.packages = with pkgs; [
    ripgrep
  ];

  # Tạo file cấu hình ripgrep
  xdg.configFile."ripgrep/ripgreprc".text = ''
    # Configuration for ripgrep (rg) command
    # Colors and styling
    --colors=line:fg:yellow
    --colors=line:style:bold
    --colors=path:fg:green
    --colors=path:style:bold
    --colors=match:fg:black
    --colors=match:bg:yellow
    --colors=match:style:nobold
    # Default behavior
    --smart-case
    --hidden
    --follow
    --glob=!.git/*
    --glob=!node_modules/*
    --glob=!.next/*
    --glob=!dist/*
    --glob=!build/*
    --glob=!target/*
    --glob=!*.min.js
    --glob=!*.min.css
    # Output formatting
    --max-columns=150
    --max-columns-preview
    # Performance
    --mmap
  '';

  # Thiết lập biến môi trường để ripgrep sử dụng config file
  home.sessionVariables = {
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/ripgreprc";
  };

  # Tạo shell aliases cho ripgrep (tùy chọn)
  home.shellAliases = {
    rg = "rg"; # Sử dụng config mặc định
    rgf = "rg --files"; # Chỉ liệt kê files
    rgi = "rg --ignore-case"; # Tìm kiếm không phân biệt hoa thường
    rgv = "rg --invert-match"; # Tìm kiếm ngược
    rgl = "rg --files-with-matches"; # Chỉ hiện tên file
    rgc = "rg --count"; # Đếm số match
  };
}