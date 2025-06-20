-- Simple Java LSP configuration using jdtls
local M = {}

function M.setup()
  -- Only setup if jdtls is available
  local jdtls_ok, jdtls = pcall(require, 'jdtls')
  if not jdtls_ok then
    vim.notify("jdtls not found, please install it via Mason", vim.log.levels.WARN)
    return
  end

  -- Find the root directory
  local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'})
  if not root_dir then
    vim.notify("Could not find Java project root", vim.log.levels.WARN)
    return
  end

  -- Setup workspace directory
  local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
  local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
  vim.fn.mkdir(workspace_dir, 'p')

  -- Get the current OS
  local os = vim.loop.os_uname().sysname
  
  -- This is the minimal configuration
  local config = {
    cmd = {
      'jdtls',
      '--jvm-arg=-Xmx4G',  -- Max memory
      '--jvm-arg=-Dlog.level=WARNING',
    },
    root_dir = root_dir,
    settings = {
      java = {}
    },
    init_options = {
      bundles = {}
    },
  }

  -- Start the LSP client
  jdtls.start_or_attach(config)
end

return M
