
--
-- Setting up some basic configs:
--

-- The leader key is used in combination with other keys to
-- generate shortcuts below in this configuration.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- This disables mouse interaction which is confusing and not helpful at all
vim.opt.mouse = ""

require("config.lazy")

require("codecompanion").setup({
  adapters = {
    openai = function()
      return require("codecompanion.adapters").extend("openai", {
        schema = {
          model = {
            default = "gpt-4.1",
          },
        },
      })
    end,
    anthropic = function()
      return require("codecompanion.adapters").extend("anthropic", {
        schema = {
          model = {
            default = "claude-sonnet-4-5-20250929",
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = "anthropic",
    },
    inline = {
      adapter = "anthropic",
    },
    cmd = {
      adapter = "anthropic",
    }
  },
  display = {
    chat = {
      window = {
        position = "right",
      },
    },
  },
})

-- local lspconfig = require('lspconfig')
--
-- lspconfig.gopls.setup {
--   settings = {
--     gopls = {
--       buildFlags = {
--         "-tags=ksql_enable_kbuilder_experiment",
--       },
--     }
--   },
-- }

-- Change how the chat window behaves so we submit on enter everytime:
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'codecompanion',
    callback = function()
        vim.keymap.set('i', '<Enter>', function ()
            require('codecompanion').last_chat():submit()
        end, { buffer = true, desc = 'Use enter to send the message' })
        vim.keymap.set('i', '<S-Enter>', '<Enter>', { buffer = true, desc = 'Use shift enter to start a new line' })
        vim.keymap.set({ 'n', 'v' }, '<Enter>', 'j^', { buffer = true, desc = 'Restore default behavior for "enter"' })
    end,
})

vim.keymap.set({ "n", "v" }, "<leader>i", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v" }, '<M-h>', ":CodeCompanion #{buffer} ", { noremap = true })
--vim.keymap.set({ "n", "v" }, '<M-H>', ":%CodeCompanion #{buffer} ", { noremap = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- Expand 'E' into 'Explore' in the command line
vim.cmd([[cab E Explore]])

