local M = {}

function M.setup()
  local lsp = vim.lsp
  local mason = require "mason"
  local mason_cfg = require "mason-lspconfig"
  local lsp_cfg = require "lspconfig"
  local neodev = require "neodev"

  local signs = require "nitintf.utils.lsp".signs

  vim.diagnostic.config {
    signs = true,
    severity_sort = true,
  }

  lsp.handlers["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" })

  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  mason.setup {}

  mason_cfg.setup {
    ensure_installed = {
      "bashls",
      "cssls",
      "dockerls",
      "docker_compose_language_service",
      "html",
      "jsonls",
      "lua_ls",
      "marksman",
      "sqlls",
      "tailwindcss",
      "tsserver",
      "yamlls",
    },
  }

  -- lua
  neodev.setup {}

  lsp_cfg.lua_ls.setup {
    settings = {
      Lua = {
        format = {
          enable = true,
        },
        telemetry = {
          enable = false,
        },
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  }

  -- typescript
  lsp_cfg.tsserver.setup {
    on_attach = function(client)
      -- Formatting is handled by null-ls prettier
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end,
  }

  -- yaml
  lsp_cfg.yamlls.setup {
    settings = {
      yaml = {
        keyOrdering = false,
      },
    },
  }

  -- rest
  lsp_cfg.bashls.setup {}
  lsp_cfg.cssls.setup {}
  lsp_cfg.dockerls.setup {}
  lsp_cfg.docker_compose_language_service.setup {}
  lsp_cfg.html.setup {}
  lsp_cfg.jsonls.setup {}
  lsp_cfg.marksman.setup {}
  lsp_cfg.sqlls.setup {}
  lsp_cfg.tailwindcss.setup {}
end

return M
