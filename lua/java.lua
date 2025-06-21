return {
  'mfussenegger/nvim-jdtls',
  ft = { 'java' },
  config = function()
    local jdtls = require 'jdtls'

    local home = vim.fn.expand '$HOME'
    local mason_path = vim.fn.stdpath 'data' .. '/mason/packages/jdtls'

    local root_markers = { '.git', 'pom.xml', 'build.gradle' }
    local root_dir = require('jdtls.setup').find_root(root_markers)
    if not root_dir then
      vim.notify('Java root directory not found', vim.log.levels.WARN)
      return
    end

    local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
    local workspace_dir = home .. '/.local/share/eclipse/' .. project_name

    local config = {
      cmd = {
        mason_path .. '/bin/jdtls',
        '-data',
        workspace_dir,
        '--jvm-arg=-Djava.home=' .. os.getenv 'JAVA_HOME',
      },
      root_dir = root_dir,
    }

    jdtls.start_or_attach(config)
  end,
}
