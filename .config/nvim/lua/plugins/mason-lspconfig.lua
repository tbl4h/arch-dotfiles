-- ~/.config/nvim/lua/plugins/mason-lspconfig.lua
return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local capabilities = vim.lsp.protocol.make_client_capabilities()
		capabilities.textDocument.completion.completionItem.snippetSupport = true

		-- Funkcja on_attach jest wywoływana, gdy klient LSP dołącza do bufora.
		-- Ustawimy tutaj mapowania klawiszy, które będą aktywne dla każdego bufora z LSP.
		local on_attach = function(client, bufnr)
			local bufopts = { noremap = true, silent = true, buffer = bufnr }

			-- Go to Definition
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)

			-- Go to Type Definition
			vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)

			-- Go to Implementation
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)

			-- Find References
			vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

			-- Hover (info/documentation)
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)

			-- Rename
			vim.keymap.set("n", "rr", vim.lsp.buf.rename, bufopts)

			-- Format (jeśli serwer wspiera)
			vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, bufopts)

			-- Code Actions (szybkie poprawki)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, bufopts)

			-- Next/Previous Diagnostic
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)

			-- Show Diagnostic under cursor
			vim.keymap.set("n", "<leader>D", vim.diagnostic.open_float, bufopts)

			-- Signature Help (pomoc kontekstowa dla argumentów funkcji)
			vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

			-- Dodatkowo, jeśli klientem jest 'ruff' (nowa konfiguracja)
			-- ustawiamy formatowanie przy zapisie dla plików Pythona
			if client.name == "ruff" then
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("RuffLspFormatting", { clear = true }),
					buffer = bufnr,
					callback = function()
						vim.lsp.buf.format({ bufnr = bufnr })
					end,
				})
			end
		end

		-- Konfiguracja Masona - instalacja serwerów
		require("mason").setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		-- Konfiguracja mason-lspconfig
		-- Upewnij się, że Ruff jest również na liście do zainstalowania.
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls", -- Serwer językowy dla Lua
				"rust_analyzer", -- Serwer językowy dla Rust
				"clangd", -- Serwer językowy dla C/C++/Objective-C
				"html",
				"cssls",
				"jsonls",
				"pyright", -- Serwer językowy dla Pythona
				"ruff", -- NOWOŚĆ: Bezpośrednie wsparcie dla Ruffa
				--"codelldb",
			},
		})

		-- Ważne: Jawne wywołanie setup() dla każdego serwera LSP
		-- Używamy on_attach i capabilities dla każdego.

		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
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

		lspconfig.rust_analyzer.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- Możesz dodać specyficzne ustawienia dla rust_analyzer tutaj
		})

		lspconfig.clangd.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- Możesz dodać specyficzne ustawienia dla clangd tutaj
		})

		lspconfig.html.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.cssls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		lspconfig.jsonls.setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Konfiguracja dla Pyright
		lspconfig.pyright.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			root_dir = function(fname)
				-- Spróbuj znaleźć standardowe znaczniki projektu Pythona
				local default_root = lspconfig.util.root_pattern(
					"pyproject.toml",
					"setup.py",
					"setup.cfg",
					"requirements.txt",
					"Pipfile",
					"pyrightconfig.json",
					".git",
					"venv",
					".vscode"
				)(fname)

				-- Jeśli znaleziono standardowy root_dir, zwróć go
				if default_root then
					return default_root
				end

				-- W przeciwnym razie, jeśli nie znaleziono żadnego z powyższych,
				-- folderem roboczym będzie katalog otwartego pliku.
				return vim.fn.fnamemodify(fname, ":h")
			end,
			settings = {
				python = {
					analysis = {
						typeCheckingMode = "strict", -- lub "strict"
						-- Tutaj możesz dodać konfigurację linting engine
						extraPaths = {
							-- Dodaj ścieżkę do katalogu site-packages, gdzie zainstalowany jest Qtile.
							-- W twoim przypadku to /usr/lib/python3.13/site-packages
							-- Pyright przeszuka ten katalog w poszukiwaniu importowanych modułów.
							"/usr/lib/python3.13/",
						},
						logLevel = "debug",

						-- Dodaj to, aby pomóc Pyrightowi w odnajdywaniu
						--venvPath = "/usr/lib/python3.13", -- Ścieżka do katalogu nadrzędnego dla site-packages
						--venv = "site-packages",           -- Nazwa katalogu z pakietami
					},
				},
			},
			on_init = function(client)
				client.server_capabilities.documentFormattingProvider = true
				client.server_capabilities.documentRangeFormattingProvider = true
			end,
		})

		-- NOWA Konfiguracja dla ruff (bezpośrednie wsparcie lspconfig)
		lspconfig.ruff.setup({
			capabilities = capabilities,
			on_attach = on_attach,
			-- Możesz dodać specyficzne ustawienia dla ruff, np. ścieżkę do configu ruff
			-- settings = {
			--   args = { "--config", "/path/to/ruff.toml" }
			-- }
		})
	end,
}
