require("nvchad.configs.lspconfig").defaults()


local servers = {
  -- Webdev
  "html",
  "cssls",
  "eslint",

  -- Python
  "pyright",

  -- C/C++/C#
  "clangd",

  -- Linux
  "bashls",
  "qmlls",

  -- Lua
  "lua_ls",

  -- Data files
  "jsonls",
  "yamlls",

  -- Rust
  "rust_analyzer",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers 

