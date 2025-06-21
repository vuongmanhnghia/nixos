-- pull lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins and options
require("vim-options")
require("vim-helpers")
require("help-floating")
require("floating-term")
-- require("lazy").setup("plugins")

-- Lazy.nvim setup với lockfile path cho NixOS
local uname = vim.loop.os_uname()
local hostname = vim.loop.os_gethostname()
lazy_opts = {}

-- Xác định path của config directory
local config_path = vim.fn.stdpath("config")
local lockfile_path = config_path .. "/lazy-lock.json"

-- Kiểm tra nếu đang chạy trên NixOS với symlink config
if vim.fn.isdirectory(config_path) == 1 then
    lazy_opts.lockfile = lockfile_path
elseif not (uname.sysname == "Darwin" and hostname == "nagih") then
    -- Fallback cho các hệ thống khác
    lazy_opts.lockfile = "~/Workspaces/Config/nixos/dotfiles/nvim/lazy-lock.json"
end

require("lazy").setup("plugins", lazy_opts)
require("snipets")
