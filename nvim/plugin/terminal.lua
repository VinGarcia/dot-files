-- luacheck: globals vim

-- Open bash with <C-d>, and using <C-d> again inside the terminal closes it:
vim.keymap.set("n", "<C-d>", ":tab split<enter>:-tabmove<enter>:term<enter>")

local id = vim.api.nvim_create_augroup("neovim_terminal", {})

vim.api.nvim_create_autocmd("TermOpen", {
    group = id,
    callback = function()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.keymap.set("n", "<C-d>", ":close<enter>", { buffer = true })
    end
})

vim.api.nvim_create_autocmd("TermOpen", {
    group = id,
    command = "startinsert",
})

vim.api.nvim_create_autocmd("TermClose", {
    group = id,
    callback = function()
        vim.api.nvim_input("<enter>")
    end,
})

local opts = { silent = true }

-- Set window navigation to work like in other windows
local map = function(lhs, rhs)
    vim.keymap.set("t", lhs, "<C-\\><C-N>" .. rhs, opts)
end

map("<Esc>", "<C-W><C-W>")
map("<C-n>", ":tab split<enter>:-tabmove<enter>:term<enter>")
map("<C-q>", ":close<enter>")

map("<C-W>+", "<C-W>+")
map("<C-W>-", "<C-W>-")
map("<C-W>>", "<C-W>>")
map("<C-W><", "<C-W><")

map("<C-W><C-C>", ":close<enter>")
map("<C-W>c", ":close<enter>")

map("<C-W><C-N>", ":new<enter>")
map("<C-W>n", ":new<enter>")

map("<C-W><C-W>", "<C-W><C-W>")
map("<C-W>w", "<C-W><C-W>")

map("<C-W><C-O>", ":only<enter>")
map("<C-W>o", ":only<enter>")

map("<C-W><down>", "<C-W>j")
map("<C-W><left>", "<C-W>h")
map("<C-W><right>", "<C-W>l")
map("<C-W><up>", "<C-W>k")

-- For some reason these need explicit remapping
vim.keymap.set("t", "<M-Left>", "<M-Left>", opts)
vim.keymap.set("t", "<M-Right>", "<M-Right>", opts)
vim.keymap.set("t", "<M-Up>", "<M-Up>", opts)
