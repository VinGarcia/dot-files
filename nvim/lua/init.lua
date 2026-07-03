
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

vim.lsp.enable('millet')

-- Expand 'E' into 'Explore' in the command line
vim.cmd([[cab E Explore]])

vim.keymap.set({ "n", "v" }, "<leader>w", ":q<enter>", { silent = true })

-- tig blame: not a plugin but very useful
vim.keymap.set("n", "<leader><leader>b", function()
    local file = vim.fn.expand("%:p")
    local lnum = vim.fn.line(".")
    vim.cmd("tabnew")
    vim.fn.termopen(string.format("tig blame %s +%d", vim.fn.shellescape(file), lnum))
    vim.cmd("startinsert")
end, { silent = true, desc = "tig blame current file at cursor line" })
