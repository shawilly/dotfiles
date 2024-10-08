return {
  -- messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      opts.presets.lsp_doc_border = true

      opts.routes = {
        {
          filter = {
            event = "notify",
            find = "Request textDocument/inlayHint failed",
          },
          opts = { skip = true },
        },
      }
    end,
  },
  -- buffer line
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
      { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
    },
    opts = {
      options = {
        mode = "tabs",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },

  -- filename
  {
    "b0o/incline.nvim",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    dependencies = { "mini.icons" },
    config = function()
      require("incline").setup({
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local lazy_icons = LazyVim.config.icons
          local mini_icons = require("mini.icons")

          local function get_filename()
            local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
            if filename == "" then
              filename = "[No Name]"
            end
            local ft_icon, ft_color = mini_icons.get("file", filename)
            local modified = vim.bo[props.buf].modified
            return {
              " ",
              { filename, gui = modified and "bold,italic" or "bold" },
              " ",
              ft_icon and { ft_icon, " ", guibg = "none", group = ft_color } or "",
            }
          end

          local function get_diagnostics()
            local icons = {
              error = lazy_icons.diagnostics.Error,
              warn = lazy_icons.diagnostics.Warn,
              info = lazy_icons.diagnostics.Info,
              hint = lazy_icons.diagnostics.Hint,
            }
            local labels = {}

            for severity, icon in pairs(icons) do
              local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
              if n > 0 then
                table.insert(labels, { " " .. icon .. n, group = "DiagnosticSign" .. severity })
              end
            end
            if #labels > 0 then
              table.insert(labels, { " ┊" })
            end
            return labels
          end

          local function get_mini_diff()
            local icons = {
              add = lazy_icons.git.added,
              change = lazy_icons.git.modified,
              delete = lazy_icons.git.removed,
            }
            local signs = vim.b[props.buf].minidiff_summary

            local labels = {}
            if signs == nil then
              return labels
            end
            for name, icon in pairs(icons) do
              if tonumber(signs[name]) and signs[name] > 0 then
                table.insert(labels, { " ", icon .. signs[name], group = "MiniDiffSign" .. name })
              end
            end
            if #labels > 0 then
              table.insert(labels, { " 󰊢 " .. signs.n_ranges .. " ┊" })
            end
            return labels
          end

          return {
            { get_diagnostics() },
            { get_mini_diff() },
            { get_filename() },
            group = props.focused and "ColorColumn" or "SignColumn",
          }
        end,
      })
    end,
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
    keys = {
      {

        "<leader>d",
        "<cmd>NvimTreeClose<cr><cmd>tabnew<cr><bar><bar><cmd>DBUI<cr>",
      },
    },
  },
}
