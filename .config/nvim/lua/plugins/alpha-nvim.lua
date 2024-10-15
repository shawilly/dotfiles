local function getEen(str, start_pos)
  local byte = string.byte(str, start_pos)
  if not byte then
    return nil
  end
  return (byte < 0x80 and 1) or (byte < 0xE0 and 2) or (byte < 0xF0 and 3) or (byte < 0xF8 and 4) or 1
end

local function colorize(header, header_color_map, colors)
  for letter, color in pairs(colors) do
    ---@type string
    local color_name = "AlphaJemuelKwelKwelWalangTatay" .. letter
    vim.api.nvim_set_hl(0, color_name, color)
    ---@type string
    colors[letter] = color_name
  end

  local colorized = {}

  for i, line in ipairs(header_color_map) do
    local colorized_line = {}
    local pos = 0

    for j = 1, #line do
      local start = pos
      pos = pos + getEen(header[i], start + 1)

      ---@type string
      local color_name = colors[line:sub(j, j)]
      if color_name then
        table.insert(colorized_line, { color_name, start, pos })
      end
    end

    table.insert(colorized, colorized_line)
  end

  return colorized
end

return {
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    init = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")

      local dashboard = require("alpha.themes.dashboard")

      -- inspiration: https://www.vecteezy.com/vector-art/27174601-pixel-art-illustration-frog-pixelated-frog-frog-amphibi-animal-icon-pixelated-for-the-pixel-art-game-and-icon-for-website-and-video-game-old-school-retro
      local color_map = {
        [[                      EEEEEEEEEEEEEEEE                        EEEEEEEEEEEEEEEE]],
        [[                  EEEEWWQQGGGGGGGGGGGGEEEE                EEEEWWQQGGGGGGGGGGGGEEEE]],
        [[                EEWWQQGGGGGGGGGGGGGGGGGGGWQQBBWWWWWWWWBBQQGGGGGGGGGGGGGGGGGGGGGGQQEE]],
        [[              EEOYYYYYYYYYYQQGGGGGGGGGGGGGGGQQWWWWWWWWQQGGGGGGGGGGGGGGQQYYYYYYYYYYYOEE]],
        [[            EEBBBBYYYYYYYYYYYYQQGGGGGGGGGGGGQQWWWWWWWWQQGGGGGGGGGGGGQQYYYYYYYYYYYYBBBBEE]],
        [[            EEBBBBBBBBBBBBYYYYQQGGGGGGGGGGGGGGWWWWWWWWGGGGGGGGGGGGGGQQYYYYBBBBBBBBBBBBEE]],
        [[            EEYYBBBBBBBBBBYYYYQQGGGGGGGGGGGGGGWWWWWWWWGGGQGGGGGGGGGGQQYYYYBBBBBBBBBBYYEE]],
        [[            EEYYYYBBBBBBBBYYYYWWGGGGGGGGGGGGGGWWWWWWWWGGGGGGGGGGGGGGQQYYYYBBBBBBBBYYYYEE]],
        [[            EEYYYYYYYYYYYYYYYYWWGGGGGGGGGGGGGGWWWWWWWWGGGGGGGGGGGGGGQQYYYYYYYYYYYYYYEE]],
        [[            EEYYYYYYYYYYYYYYWWGGGGGGGGGGGGQQWWWWQQQQWWWWGGGGGGGGGGGGQQYYYYYYYYYYYYYYEE]],
        [[              BBYYYYYYYYYYWWGGGGGGGGGGGGGGGGGGQQQQQQQQGGGGGQGGGGGGGGGGQQYYYYYYYYYYBB]],
        [[                BBWWWWWQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQQGGGGGGGGGGGGBB]],
        [[                BBWWQQOOOYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYOOOQQQQBB]],
        [[                EEQQOOOOOYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYOOOOOQQEE]],
        [[                EEQQOOOOOYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYOOOOOQQEE]],
        [[]],
      }

      local colors = {
        ["B"] = { fg = "#050401" },
        ["G"] = { fg = "#8dd234" },
        ["Q"] = { fg = "#61a63f" },
        ["W"] = { fg = "#477338" },
        ["E"] = { fg = "#26421b" },
        ["Y"] = { fg = "#fcf189" },
        ["O"] = { fg = "#f8c43b" },
        ["D"] = { fg = "#e3a727" },
      }

      local header = {}
      for _, line in ipairs(color_map) do
        local header_line = [[]]
        for i = 1, #line do
          if line:sub(i, i) ~= " " then
            header_line = header_line .. "█"
          else
            header_line = header_line .. " "
          end
        end
        table.insert(header, header_line)
      end

      local header_add = [[             R I B B I T V I M             ]]
      table.insert(header, header_add)

      local hl_add = {}
      for i = 1, #header_add do
        table.insert(hl_add, { "NeoBeeTitle", 1, i })
      end

      dashboard.section.header.val = header
      local colorized = colorize(header, color_map, colors)

      table.insert(colorized, hl_add)

      dashboard.section.header.opts = {
        hl = colorized,
        position = "center",
      }

      dashboard.section.buttons.val = {
        dashboard.button("␣  t", "ᨒ↟  Tree"),
        dashboard.button("␣ sf", "   Find file"),
        dashboard.button("␣ s/", "   Grep"),
        dashboard.button("   r", "   Recent files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("   s", "   Restore Session", [[<cmd> lua require("persistence").load() <cr>]]),
        dashboard.button("   l", "󰒲   Eazy", "<cmd> Eazy <cr>"),
        dashboard.button("   q", "   Quit", "<cmd> qa <cr>"),
      }

      for _, a in ipairs(dashboard.section.buttons.val) do
        a.opts.width = 49
        a.opts.cursor = -2
      end

      alpha.setup(dashboard.config)
    end,
  },
}
