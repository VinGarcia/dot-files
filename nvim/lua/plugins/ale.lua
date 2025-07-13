
return {
  {
    'dense-analysis/ale',
    config = function()
      -- Configuration goes here.
      local g = vim.g

      g.ale_linters = {
          go = {'gobuild', 'golangci-lint'},
          lua = {'lua_language_server'}
      }
    end
  },
}
