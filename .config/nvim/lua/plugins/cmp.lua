-- ~/.config/nvim/lua/plugins/cmp.lua
return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter", -- Ładuj wtyczkę tylko przy wejściu w tryb insert
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- Źródło uzupełniania dla LSP (konieczne!)
    "hrsh7th/cmp-buffer",      -- Źródło uzupełniania dla bieżącego bufora
    "hrsh7th/cmp-path",        -- Źródło uzupełniania dla ścieżek plików
    "L3MON4D3/LuaSnip",        -- Silnik do snippetów (bardzo zalecany)
    "saadparwaiz1/cmp_luasnip", -- Integracja nvim-cmp z LuaSnip
    -- Opcjonalne źródła (możesz dodać później, jeśli potrzebujesz):
    -- "hrsh7th/cmp-cmdline",    -- Uzupełnianie w linii poleceń
    -- "hrsh7th/cmp-nvim-lua",   -- Uzupełnianie dla API Neovim (przydatne dla Lua w konfiguracji Neovim)
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip") -- Będzie dostępne, jeśli zainstalujesz LuaSnip

    cmp.setup({
      -- Konfiguracja snippetów: pozwala cmp na rozwijanie snippetów za pomocą LuaSnip
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- Wymagane do rozwijania snippetów LSP
        end,
      },
      -- Okna wyświetlające sugestie i dokumentację
      window = {
        completion = cmp.config.window.bordered(), -- Okno sugestii z ramką
        documentation = cmp.config.window.bordered(), -- Okno dokumentacji z ramką
      },
      -- Mapowania klawiszy dla trybu insert w oknie uzupełniania
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4), -- Przewiń dokumentację w górę
        ["<C-f>"] = cmp.mapping.scroll_docs(4),  -- Przewiń dokumentację w dół
        ["<C-Space>"] = cmp.mapping.complete(),  -- Wymuś uzupełnianie (ręczne wywołanie)
        ["<C-e>"] = cmp.mapping.abort(),         -- Anuluj uzupełnianie
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Potwierdź i wybierz zaznaczoną sugestię
        -- `<Tab>` do nawigacji po sugestiach i snippetach
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),
      -- Źródła, z których cmp pobiera sugestie
      sources = cmp.config.sources({
        { name = "nvim_lsp" },  -- Główne źródło: serwery języka LSP
        { name = "luasnip" },   -- Snippety z LuaSnip
        { name = "buffer" },    -- Sugestie z bieżącego bufora
        { name = "path" },      -- Sugestie ścieżek plików
      }),
      -- Opcjonalne: Ustawienie debounce dla opóźnienia uzupełniania
      -- debounce_time = 200,
    })

    -- Opcjonalne: Ustawienia dla uzupełniania w linii poleceń (cmdline)
    -- cmp.setup.cmdline('/', {
    --   sources = cmp.config.sources({
    --     { name = 'buffer' }
    --   })
    -- })

    -- cmp.setup.cmdline(':', {
    --   sources = cmp.config.sources({
    --     { name = 'path' },
    --     { name = 'cmdline' }
    --   })
    -- })
  end,
}
