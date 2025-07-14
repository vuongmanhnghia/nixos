return {
	{
		"williamboman/mason.nvim",
		-- version = "v1.11.0",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		lazy = false,
		opts = {
			auto_install = true,
			-- manually install packages that do not exist in this list please
			ensure_installed = { "lua_ls", "zls", "ts_ls", "pyright" },
		},
	},
	{
		"neovim/nvim-lspconfig",
		lazy = false,
		config = function()
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local lspconfig = require("lspconfig")
			-- lua
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			})
			-- typescript
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
			-- Js
			lspconfig.eslint.setup({
				capabilities = capabilities,
			})
			-- zig
			lspconfig.zls.setup({
				capabilities = capabilities,
			})
			-- yaml
			lspconfig.yamlls.setup({
				capabilities = capabilities,
			})
			-- tailwindcss
			lspconfig.tailwindcss.setup({
				capabilities = capabilities,
			})
			-- golang
			lspconfig.gopls.setup({
				capabilities = capabilities,
				cmd = { "gopls" },  -- Use gopls from PATH instead of hardcoded path
				root_dir = lspconfig.util.root_pattern("go.mod", ".git"),
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							unreachable = true,
							fillstruct = true,
						},
						staticcheck = true,
						gofumpt = true,
						codelenses = {
							gc_details = false,
							generate = true,
							regenerate_cgo = true,
							run_govulncheck = true,
							test = true,
							tidy = true,
							upgrade_dependency = true,
							vendor = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						usePlaceholders = true,
						completeUnimported = true,
						directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
						semanticTokens = true,
					},
				},
			})
			-- C++ (using system clangd for NixOS compatibility)
			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = { "/run/current-system/sw/bin/clangd", "--background-index", "--clang-tidy" },
				filetypes = { "c", "cpp", "objc", "objcpp" },
			})
			--java
			-- lspconfig.jdtls.setup({
			--     settings = {
			--         java = {
			--             configuration = {
			--                 runtimes = {
			--                     {
			--                         name = "JavaSE-23",
			--                         path = "/opt/homebrew/Cellar/openjdk/23.0.2/libexec/openjdk.jdk/Contents/Home",
			--                         default = true,
			--                     },
			--                 },
			--             },
			--         },
			--     },
			-- })
			-- nix
			lspconfig.rnix.setup({ capabilities = capabilities })
			-- protocol buffer
			lspconfig.buf_ls.setup({ capabilities = capabilities })
			-- docker compose
			lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
			-- svelte
			lspconfig.svelte.setup({ capabilities = capabilities })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "proto",
				callback = function()
					lspconfig.buf_language_server.setup({
						capabilities = capabilities,
					})
				end,
			})
			-- python
			lspconfig.pyright.setup({
				capabilities = capabilities,
				settings = {
				python = {
					analysis = {
						typeCheckingMode = "basic", -- hoặc "strict" để kiểm tra mạnh hơn
						autoSearchPaths = true,
						useLibraryCodeForTypes = true,
						diagnosticMode = "workspace", -- hoặc "openFilesOnly"
						}
					}
				}
			})
			-- bash
			lspconfig.bashls.setup({ capabilities = capabilities })
			-- lsp kepmap setting
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {})
			vim.keymap.set("n", "gr", vim.lsp.buf.references, {})
			vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			-- list all methods in a file
			-- working with go confirmed, don't know about other, keep changing as necessary
			vim.keymap.set("n", "<leader>fm", function()
				local filetype = vim.bo.filetype
				local symbols_map = {
					python = "function",
					javascript = "function",
					typescript = "function",
					java = "class",
					lua = "function",
					go = { "method", "struct", "interface" },
					cpp = "function",
					c = "function",
				}
				local symbols = symbols_map[filetype] or "function"
				require("fzf-lua").lsp_document_symbols({ symbols = symbols })
			end, {})
			-- Set C++ specific indentation to match formatting
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "c", "cpp", "objc", "objcpp" },
				callback = function()
					vim.opt_local.tabstop = 2
					vim.opt_local.shiftwidth = 2
					vim.opt_local.softtabstop = 2
					vim.opt_local.expandtab = true
				end,
			})
		end,
	},
}
