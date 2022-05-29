local jdtls = require('jdtls')

local root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' })
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local home = os.getenv('HOME')
local workspace_folder = home .. "/workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
  -- The command that starts the language server
  -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
  cmd = {

    -- 💀
    'java', -- or '/path/to/java11_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.
    '-Declipse.application=org.eclipse.jdt.ls.core.id1', '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product', '-Dlog.protocol=true', '-Dlog.level=ALL',
    '-Xms4g', '--add-modules=ALL-SYSTEM', '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED', -- 💀
    '-jar', home
        .. '/source/clone/jdtls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version

    -- 💀
    '-configuration',
    home .. '~/source/clone/jdtls/org.eclipse.jdt.ls.product/target/repository/config_linux',
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    -- 💀
    -- See `data directory configuration` section in the README
    '-data', workspace_folder
  },

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require('jdtls.setup').find_root({ '.git', 'mvnw', 'gradlew' }),

  -- Here you can configure eclipse.jdt.ls specific settings
  -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
  -- for a list of options
  settings = { java = {} },
  capabilities = capabilities,
  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = { bundles = {} }
}

config.on_attach = function(client, bufnr)
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
  end
  if client.resolved_capabilities.document_highlight then
    vim.cmd [[
      augroup document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]]
  end
  jdtls.setup.add_commands()
  local opts = { silent = true, noremap = true }
  vim.api.nvim_set_keymap('n', "<A-o>", [[<cmd>lua require('jdtls').organize_imports<CR>]], opts)
  vim.api.nvim_set_keymap('n', "<leader>df", [[<cmd>lua require('jdtls').test_class<CR>]], opts)
  vim.api.nvim_set_keymap('n', "<leader>dn", [[<cmd>lua require('jdtls').test_nearest_method<CR>]],
    opts)
  vim.api.nvim_set_keymap('n', "<leader>la", [[<cmd>lua vim.lsp.buf.code_action()<CR>]], opts)
  vim.api.nvim_set_keymap('n', "crv", [[<cmd>lua require('jdtls').extract_variable<CR>]], opts)
  vim.api.nvim_set_keymap('v', 'crm', [[<ESC><CMD>lua require('jdtls').extract_method(true)<CR>]],
    opts)
  vim.api.nvim_set_keymap('n', "crc", [[<cmd>lua require('jdtls').extract_constant<CR>]], opts)
end

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)
