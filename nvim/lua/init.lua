
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
  },
  strategies = {
    chat = {
      adapter = "openai",
    },
    inline = {
      adapter = "openai",
    },
    cmd = {
      adapter = "openai",
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

vim.keymap.set({ "n", "v" }, "<C-i>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

