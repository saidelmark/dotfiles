local parsers = {
  "bash",
  "comment",
  "csv",
  "dockerfile",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitignore",
  "go",
  "gomod",
  "hcl",
  "html",
  "jq",
  "json",
  "json5",
  "kdl",
  "lua",
  "luadoc",
  "make",
  "markdown",
  "markdown_inline",
  "nix",
  "perl",
  "python",
  "rasi",
  "rust",
  "ssh_config",
  "sxhkdrc",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
  "zsh",
}


-- Ensure tree-sitter enabled after opening a file for target language
local filetypes = {}
for _, lang in ipairs(parsers) do
  for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
    table.insert(filetypes, ft)
  end
end

local hl_autogroup = vim.api.nvim_create_augroup("highlight", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  desc = "Start treesitter",
  group = hl_autogroup,
  pattern = filetypes,
  callback = function(ev)
    vim.treesitter.start(ev.buf)
    require('hlargs').setup({
      colors = require('ofirkai').scheme.mid_orange,
    })
    -- If treesitter was enabled and folding queries are installed,
    -- use the queries for folding.
    if vim.treesitter.query.get(ev.match, "folds") then
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
    end
  end,
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = hl_autogroup,
  callback = function(args)
    if not (args.data and args.data.client_id) then
      return
    end
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- We're inside LspAttach, so there is a client
    ---@diagnostic disable-next-line: need-check-nil
    local caps = client.server_capabilities
    -- Every server has some capabiliites
    ---@diagnostic disable-next-line: need-check-nil
    if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
      if vim.treesitter.language.get_lang(args.match) then
        require("hlargs").disable_buf(args.buf)
      end
    end
  end,
})
