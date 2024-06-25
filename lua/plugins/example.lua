return {

  -- add fugitive
  { "tpope/vim-fugitive" },

  -- add surround, because I am not a beast of the field
  { "tpope/vim-surround" },

  -- writing
  { "Soares/write.vim" },

  -- devicons
  { "nvim-tree/nvim-web-devicons" },

  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup({
        ---Render style
        ---@usage 'background'|'foreground'|'virtual'
        render = "background",

        ---Set virtual symbol (requires render to be set to 'virtual')
        virtual_symbol = "■",

        ---Set virtual symbol suffix (defaults to '')
        virtual_symbol_prefix = "",

        ---Set virtual symbol suffix (defaults to ' ')
        virtual_symbol_suffix = " ",

        ---Set virtual symbol position()
        ---@usage 'inline'|'eol'|'eow'
        ---inline mimics VS Code style
        ---eol stands for `end of column` - Recommended to set `virtual_symbol_suffix = ''` when used.
        ---eow stands for `end of word` - Recommended to set `virtual_symbol_prefix = ' ' and virtual_symbol_suffix = ''` when used.
        virtual_symbol_position = "inline",

        ---Highlight hex colors, e.g. '#FFFFFF'
        enable_hex = true,

        ---Highlight short hex colors e.g. '#fff'
        enable_short_hex = true,

        ---Highlight rgb colors, e.g. 'rgb(0 0 0)'
        enable_rgb = true,

        ---Highlight hsl colors, e.g. 'hsl(150deg 30% 40%)'
        enable_hsl = true,

        ---Highlight CSS variables, e.g. 'var(--testing-color)'
        enable_var_usage = true,

        ---Highlight named colors, e.g. 'green'
        enable_named_colors = true,

        ---Highlight tailwind colors, e.g. 'bg-blue-500'
        enable_tailwind = false,

        ---Set custom colors
        ---Label must be properly escaped with '%' to adhere to `string.gmatch`
        --- :help string.gmatch
        custom_colors = {
          { label = "%-%-theme%-primary%-color", color = "#0f1219" },
          { label = "%-%-theme%-secondary%-color", color = "#5a5d64" },
        },

        -- Exclude filetypes or buftypes from highlighting e.g. 'exclude_buftypes = {'text'}'
        exclude_filetypes = {},
        exclude_buftypes = {},
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tailwindcss = {
          hovers = true,
          suggestions = true,
          root_dir = function(fname)
            local root_pattern = require("lspconfig").util.root_pattern(
              "tailwind.config.prettier.ts",
              "tailwind.config.ts",
              "tailwind.config.js"
            )
            return root_pattern(fname)
          end,
        },
      },
    },
  },
  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        tailwind = true,
        rgb = true,
      },
    },
  },
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      -- Original LazyVim kind icon formatter
      local format_kinds = function(entry, item)
        item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          path = "[Path]",
          luasnip = "[Snippet]",
        })[entry.source.name]

        local function rgbToHex(rgba)
          -- Check if the input is a string
          if type(rgba) ~= "string" then
            return nil, "Input is not a string"
          end

          -- Extract the RGBA values from the string
          local r, g, b, a = rgba:match("rgba?%((%d+),%s*(%d+),%s*(%d+),?%s*([%d%.]*)%)")

          -- Check if the pattern match was successful
          if not r or not g or not b then
            return nil, "Invalid RGB/RGBA format"
          end

          -- Convert the extracted values to numbers
          r = tonumber(r)
          g = tonumber(g)
          b = tonumber(b)

          -- Handle the alpha value if it exists, otherwise default to 1 (opaque)
          a = tonumber(a)
          if not a or a == "" then
            a = 1
          end

          -- Ensure the values are within the valid range
          if r < 0 or r > 255 or g < 0 or g > 255 or b < 0 or b > 255 or a < 0 or a > 1 then
            return nil, "Invalid RGB/RGBA value"
          end

          -- Convert the RGB values to a hex string
          local hex = string.format("%02x%02x%02x", r, g, b)

          return hex
        end

        item.kind = ({
          Text = "",
          Method = "ƒ",
          Function = "",
          Constructor = "",
          Field = "ﰠ",
          Variable = "",
          Class = "ﴯ",
          Interface = "",
          Module = "",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "﬌",
          Color = " ",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "ﬦ",
          TypeParameter = "",
        })[item.kind]

        -- Check if the completion item has a documentation string - in the case of tailwindcss in our project this is
        -- an rgb value
        --
        -- TODO Check if this works or doesn't when using hex codes
        local c = rgbToHex(entry.completion_item.documentation)

        if c == nil then
          return item
        end

        local hl_group = "lsp_documentColor_mf_" .. c
        vim.api.nvim_set_hl(0, hl_group, { fg = "#" .. c, bg = "#" .. c })

        item.kind_hl_group = hl_group

        return item
      end

      opts.formatting.format = function(entry, item)
        item = format_kinds(entry, item) -- Add icons
        return item
      end
    end,
  },
  { "mxsdev/nvim-dap-vscode-js" },
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    -- you can do it like this with a config function
    config = function()
      require("catppuccin").setup({
        -- configurations
        flavour = "mocha",
      })
    end,
    -- or just use opts table
    opts = {
      -- configurations
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },

  -- Configure LazyVim to load gruvbox
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "gruvbox",
  --   },
  -- },
}
