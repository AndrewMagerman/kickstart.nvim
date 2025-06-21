return {
  {
    'toppair/peek.nvim',
    build = 'deno task --quiet build:fast',
    ft = { 'markdown' },
    config = function()
      require('peek').setup {
        auto_load = true, -- auto-start preview on opening markdown
        close_on_bdelete = true, -- close preview when buffer is closed
        syntax = true, -- enable treesitter syntax highlighting
        theme = 'dark', -- or 'light'
        update_on_change = true,
      }
    end,
    keys = {
      {
        '<leader>mp',
        function()
          require('peek').open()
        end,
        desc = 'Markdown Preview',
      },
      {
        '<leader>mP',
        function()
          require('peek').close()
        end,
        desc = 'Close Preview',
      },
    },
  },
}
