local null_ls = require('null-ls')

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
local diagnostics = null_ls.builtins.diagnostics
local completion = null_ls.builtins.completion
-- function PrintDiagnostics(opts, bufnr, line_nr, client_id)
--   opts = opts or {}

--   bufnr = bufnr or 0
--   line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)

--   local line_diagnostics = vim.lsp.diagnostic.get_line_diagnostics(bufnr, line_nr, opts, client_id)
--   if vim.tbl_isempty(line_diagnostics) then return end

--   local diagnostic_message = ""
--   for i, diagnostic in ipairs(line_diagnostics) do
--     diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
--     if i ~= #line_diagnostics then diagnostic_message = diagnostic_message .. "\n" end
--   end
--   -- print only shows a single line, echo blocks requiring enter, pick your poison
--   vim.api.nvim_echo({ { diagnostic_message, "Normal" } }, false, {})
-- end

null_ls.setup({
  sources = {
    formatting.prettier, formatting.black, formatting.gofmt, formatting.shfmt,
    formatting.clang_format, formatting.cmake_format, formatting.dart_format, formatting.eslint_d,
    code_actions.xo, diagnostics.codespell, diagnostics.eslint_d, completion.spell, completion.tags,
    formatting.google_java_format, formatting.lua_format.with({
      extra_args = {
        '--no-keep-simple-function-one-line', '--no-break-after-operator', '--column-limit=100',
        '--break-after-table-lb', '--indent-width=2'
      }
    }), formatting.isort, formatting.codespell.with({ filetypes = { 'markdown' } })
  },
  on_attach = function(client)
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
    if client.resolved_capabilities.signature_help then
      vim.cmd [[
        augroup document_highlight
          autocmd CursorHold <buffer> lua vim.lsp.buf.signature_help()
        augroup END
    ]]
    end
    -- vim.cmd [[
    --     augroup document_diagnostic
    --       autocmd! * <buffer>
    --       autocmd CursorHold <buffer> silent! Lspsaga hover_doc
    --       autocmd CursorHold <buffer> silent! Lspsaga show_line_diagnostics
    --     augroup END
    --   ]]

    -- vim.cmd [[ autocmd CursorHold * lua PrintDiagnostics() ]]
  end
})
