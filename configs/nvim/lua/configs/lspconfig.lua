require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local cmp_nvim_lsp = require "cmp_nvim_lsp"

-- Setup capabilities for nvim-cmp completion
local capabilities = cmp_nvim_lsp.default_capabilities()

-- Define on_attach function for LSP server customizations
local on_attach = function(client, bufnr)
  -- Set keybinds for LSP actions
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>gd",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    { noremap = true, silent = true }
  )
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>gr",
    "<cmd>lua vim.lsp.buf.references()<CR>",
    { noremap = true, silent = true }
  )
end

-- List of LSP servers to be enabled
local servers = { "html", "cssls", "clangd", "pyright" }

-- Enable each server in the list
for _, server in ipairs(servers) do
  -- Set additional configuration for specific servers
  if server == "clangd" then
    lspconfig.clangd.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "c", "cpp" },
      settings = {
        clangd = {
          semanticHighlighting = true, -- Enable semantic highlighting
        },
      },
    }
  -- elseif server == "pyright" then
  --   lspconfig.pylsp.setup {
  --     on_attach = on_attach,
  --     capabilities = capabilities,
  --     filetypes = { "python" },
  --     settings = {
  --       pylsp = {
  --         plugins = {
  --           pylint = { enabled = false },
  --           flake8 = { enabled = true },
  --           black = { enabled = true },
  --           mypy = { enabled = true }, -- Optional for type checking
  --           jedi = { enabled = true }, -- Enable Jedi for better completions
  --           pydocstyle = { enabled = false }, -- Disable docstring requirement
  --         },
  --       },
  --     },
  --   }
  elseif server == "pyright" then
    lspconfig.pyright.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "python" },
      settings = {
        python = {
          analysis = {
            typeCheckingMode = "basic", -- or "strict" if you want
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
          },
        },
      },
    }
  elseif server == "cssls" then
    lspconfig.cssls.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "css", "scss", "less" }, -- Ensure CSS variants are included
      settings = {
        css = {
          colorDecorators = true, -- Optional: enable color decorators
        },
      },
    }
  else
    lspconfig[server].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

lspconfig.efm.setup {
  init_options = { documentFormatting = true },
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      html = {
        {},
      },
    },
  },
}
