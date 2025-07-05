-- ~/.config/nvim/lua/lualine/themes/melange_lualine_theme.lua

-- Melange-nvim colors (pobrane z repozytorium lub poprzez :highlight w nvim)
-- Będziemy musieli odtworzyć kolory 'melange-nvim' dla lualine
-- Domyślne kolory Melange:
-- base_bg = "#f3f0e0" (jasne tło)
-- base_fg = "#504b40" (ciemny tekst)
-- comment = "#9a8c88"
-- red = "#c04848"
-- green = "#82a86b"
-- yellow = "#d28e5d"
-- blue = "#6494ed"
-- purple = "#9e77b6"
-- cyan = "#5594b2"

local colors = {
  bg_normal = "#f3f0e0", -- Jasne tło
  fg_normal = "#504b40", -- Ciemny tekst

  -- Kolory akcentujące z melange-nvim (możesz dostosować)
  red = "#c04848",
  green = "#82a86b",
  yellow = "#d28e5d",
  blue = "#6494ed",
  purple = "#9e77b6",
  cyan = "#5594b2",

  -- Jasniejsze/ciemniejsze odcienie dla kontrastu w statusline
  status_bg_light = "#fffbe0", -- Trochę jaśniejsze tło dla sekcji
  status_bg_dark = "#ede9d0",  -- Trochę ciemniejsze tło dla sekcji
  status_fg_accent = "#605b50", -- Trochę ciemniejszy tekst dla wyróżnienia
}

local theme = {
  normal = {
    a = { fg = colors.bg_normal, bg = colors.blue, gui = "bold" },
    b = { fg = colors.fg_normal, bg = colors.status_bg_dark },
    c = { fg = colors.fg_normal, bg = colors.bg_normal },
  },
  insert = {
    a = { fg = colors.bg_normal, bg = colors.green, gui = "bold" },
    b = { fg = colors.fg_normal, bg = colors.status_bg_dark },
    c = { fg = colors.fg_normal, bg = colors.bg_normal },
  },
  visual = {
    a = { fg = colors.bg_normal, bg = colors.purple, gui = "bold" },
    b = { fg = colors.fg_normal, bg = colors.status_bg_dark },
    c = { fg = colors.fg_normal, bg = colors.bg_normal },
  },
  replace = {
    a = { fg = colors.bg_normal, bg = colors.red, gui = "bold" },
    b = { fg = colors.fg_normal, bg = colors.status_bg_dark },
    c = { fg = colors.fg_normal, bg = colors.bg_normal },
  },
  command = {
    a = { fg = colors.bg_normal, bg = colors.yellow, gui = "bold" },
    b = { fg = colors.fg_normal, bg = colors.status_bg_dark },
    c = { fg = colors.fg_normal, bg = colors.bg_normal },
  },
  inactive = {
    a = { fg = colors.fg_normal, bg = colors.bg_normal, gui = "bold" },
    b = { fg = colors.fg_normal, bg = colors.bg_normal },
    c = { fg = colors.fg_normal, bg = colors.bg_normal },
  },
}

return theme
