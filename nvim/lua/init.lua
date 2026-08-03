
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

-- Force saving when file is opened read-only by accident.
-- Neovim doesn't attach a tty to `!` commands, so `:w !sudo tee %`
-- can't prompt for the password. Instead we dump the buffer to a temp
-- file, ask for the password inside Neovim, and sudo-copy it over.
vim.keymap.set("n", "<leader>s", function()
    local target = vim.fn.expand("%:p")
    if target == "" then
        vim.api.nvim_echo({ { "No file name for this buffer", "ErrorMsg" } }, false, {})
        return
    end
    local tmp = vim.fn.tempname()
    vim.cmd("write! " .. vim.fn.fnameescape(tmp))
    local pw = vim.fn.inputsecret("[sudo] password for " .. vim.env.USER .. ": ")
    -- -S reads the password from stdin, -p "" silences its own prompt.
    -- cp over an existing file keeps the target's owner/permissions.
    local cmd = "sudo -S -p '' cp " .. vim.fn.shellescape(tmp) .. " " .. vim.fn.shellescape(target)
    vim.fn.system(cmd, pw .. "\n")
    local err = vim.v.shell_error
    vim.fn.delete(tmp)
    vim.cmd("redraw")
    if err == 0 then
        vim.cmd("edit!")
        vim.api.nvim_echo({ { 'Saved "' .. vim.fn.expand("%:t") .. '" with sudo.' } }, false, {})
    else
        vim.api.nvim_echo({ { "sudo write failed (wrong password?)", "ErrorMsg" } }, false, {})
    end
end, { silent = true, desc = "force save a read-only file with sudo" })

-- tig blame: not a plugin but very useful
vim.keymap.set("n", "<leader><leader>b", function()
    local file = vim.fn.expand("%:p")
    local lnum = vim.fn.line(".")
    vim.cmd("tabnew")
    vim.fn.termopen(string.format("tig blame %s +%d", vim.fn.shellescape(file), lnum))
    vim.cmd("startinsert")
end, { silent = true, desc = "tig blame current file at cursor line" })
