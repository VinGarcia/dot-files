return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        http = {
          anthropic_max = function()
            local anthropic = require("codecompanion.adapters.http.anthropic")
            return require("codecompanion.adapters").extend("anthropic", {
              name = "anthropic_max",
              formatted_name = "Anthropic (Max)",
              env = {
                api_key = "CODECOMPANION_OAUTH_TOKEN",
              },
              headers = {
                ["authorization"] = "Bearer ${api_key}",
                ["anthropic-beta"] = "oauth-2025-04-20",
              },
              handlers = {
                setup = function(self)
                  self.headers["x-api-key"] = nil -- API rejeita se vier junto do Bearer
                  return anthropic.handlers.setup(self)
                end,
                form_messages = function(self, messages)
                  -- This initial prompt is a requirement from the API:
                  table.insert(messages, 1, {
                    role = "system",
                    content = "You are Claude Code, Anthropic's official CLI for Claude.",
                  })
                  return anthropic.handlers.form_messages(self, messages)
                end,
              },
              schema = {
                model = {
                  default = "claude-sonnet-4-6",
                },
              },
            })
          end,
        },
      },
      strategies = {
        chat = {
          adapter = "claude_code",
        },
        inline = {
          adapter = "anthropic_max",
        },
        cmd = {
          adapter = "claude_code",
        },
      },
      display = {
        chat = {
          window = {
            position = "right",
          },
        },
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)

      -- Change how the chat window behaves so we submit on enter everytime:
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'codecompanion',
        callback = function()
          vim.keymap.set('i', '<Enter>', function()
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
    end,
  },
  {
    "echasnovski/mini.diff",
    config = function()
      local diff = require("mini.diff")
      diff.setup({
        -- Disabled by default
        source = diff.gen_source.none(),
      })
    end,
  },
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },
}
