-- ~/.config/nvim/lua/plugins/none-ls.lua
return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvim-lua/plenary.nvim",},
  config = function()
    local null_ls = require("null-ls")

    -- Przykład konfiguracji źródeł (formaterów i linterów)
    null_ls.setup({
      sources = {
        --require("none-ls.diagnostics.ruff"),
        --require("none-ls.formatting.ruff"),
        --require("none-ls.extras.nvim"),

        -- Python formatters and linters
        null_ls.builtins.formatting.black, -- Formatowanie za pomocą Black
        null_ls.builtins.formatting.isort, -- Sortowanie importów za pomocą isort
        --null_ls.builtins.diagnostics.ruff, -- Linting za pomocą Ruff

        -- Formater dla Lua (wymaga zainstalowanego Stylua: `luarocks install stylua` lub pobranie binarki)
        null_ls.builtins.formatting.stylua,

        -- Linter dla Lua (wymaga zainstalowanego Selene: `luarocks install selene` lub pobranie binarki)
        null_ls.builtins.diagnostics.selene,

        -- Formater dla HTML, CSS, JavaScript, TypeScript, JSON (wymaga zainstalowanego Prettier: `npm install -g prettier`)
        null_ls.builtins.formatting.prettier.with({
          filetypes = {
            "html",
            "css",
            "javascript",
            "typescript",
            "json",
            "yaml", -- Przykład dla YAML
            "markdown", -- Przykład dla Markdown
          },
        }),

        -- Linter dla CSS (wymaga zainstalowanego Stylelint: `npm install -g stylelint stylelint-config-standard`)
        -- null_ls.builtins.diagnostics.stylelint.with({
        --   filetypes = { "css", "scss", "less" },
        -- }),

        -- Formater dla C/C++ (wymaga zainstalowanego clang-format)
        null_ls.builtins.formatting.clang_format,

        -- Dodaj inne narzędzia, których potrzebujesz
        -- null_ls.builtins.formatting.black.with({ filetypes = { "python" } }), -- Python (wymaga black)
        -- null_ls.builtins.diagnostics.flake8.with({ filetypes = { "python" } }), -- Python (wymaga flake8)
        -- null_ls.builtins.formatting.goimports, -- Go (wymaga goimports)
      },
      -- Opcjonalne: Konfiguracja domyślnych zdarzeń, kiedy none-ls ma się uruchamiać
      on_attach = function(client, bufnr)
        if client.name == "null-ls" then
          -- Auto-formatowanie przy zapisie pliku
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("NullLspFormatting", { clear = true }),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
  end,
}
