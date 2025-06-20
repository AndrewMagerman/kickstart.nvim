-- Java filetype plugin
local jdtls_ok, jdtls = pcall(require, 'jdtls')
if not jdtls_ok then
  vim.notify("jdtls not found, please install it via Mason", vim.log.levels.WARN)
  return
end

-- Get the Mason JDTLS installation path
local mason_pkg = 'jdtls'
local jdtls_path = vim.fn.stdpath('data') .. '/mason/packages/' .. mason_pkg
local jdtls_jar = vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar')
local jdtls_os = vim.fn.has('mac') and 'mac' or vim.fn.has('win32') and 'win' or 'linux'
local jdtls_config = jdtls_path .. '/config_' .. jdtls_os

-- Find the root directory
local root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle'}) or vim.fn.getcwd()

-- Setup workspace directory
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/site/java/workspace-root/' .. project_name
vim.fn.mkdir(workspace_dir, 'p')

-- Full path to the java executable
local java_executable = '/opt/homebrew/opt/openjdk@23/bin/java'  -- Update this path if needed

-- Configuration
local config = {
  cmd = {
    java_executable,
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx4g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', jdtls_jar,
    '-configuration', jdtls_config,
    '-data', workspace_dir,
  },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          {
            name = 'JavaSE-23',
            path = '/opt/homebrew/opt/openjdk@23',
            default = true,
          },
        },
      },
    },
  },
  init_options = {
    bundles = {}
  },
}

-- Start the LSP client
jdtls.start_or_attach(config)
