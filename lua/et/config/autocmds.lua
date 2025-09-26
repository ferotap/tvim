-- local RunFile = vim.api.nvim_create_augroup("RunFile", { clear = true })
-- vim.api.nvim_create_autocmd(
--   {"FileType"},
--   {
--     pattern = {"java"},
--     command = "require('jdtls').start_or_attach({})",
--     group = RunFile,
--
--   }
-- )
--
-- Highlight the yanked text for 200ms
local highlight_yank_group = vim.api.nvim_create_augroup("HighlightYank", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  group = highlight_yank_group,
  pattern = "*",
  callback = function()
    vim.hl.on_yank({
      higroup = "IncSearch",
      timeout = 200,
    })
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client == nil then
      return
    end
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf)
      -- vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'java',
    callback = function(args)
      local dap = require('dap')
      require'jdtls'.setup_dap(dap.opts)
    end
})
