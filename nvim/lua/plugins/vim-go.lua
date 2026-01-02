
return {
  {
    'fatih/vim-go',
    ft = 'go',
    build = ':GoUpdateBinaries',
    config = function()
      -- Enable auto-format on save
      vim.g.go_fmt_autosave = 1
      vim.g.go_fmt_command = "goimports"
      
      -- Build tags
      vim.g.go_build_tags = "ksql_enable_kbuilder_experiment"
    end
  },
}
