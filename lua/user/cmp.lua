-- ---------------
-- Get cmp module
-- ---------------
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
    vim.notify("cmp can not be required", "error")
    return
end

-- -------------------
-- Get luasnip module
-- -------------------
local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
    vim.notify("luasnip can not be required", "error")
    return
end

local icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
}

-- gray
vim.cmd("highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080")
-- blue
vim.cmd("highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6")
vim.cmd("highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6")
-- light blue
vim.cmd("highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE")
vim.cmd("highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE")
vim.cmd("highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE")
-- pink
vim.cmd("highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0")
vim.cmd("highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0")
-- front
vim.cmd("highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4")
vim.cmd("highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4")
vim.cmd("highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4")

-- ----------
-- Setup cmp
-- ----------
cmp.setup({
    -- bind snippet engine
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },

    mapping = {
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),    -- for insert mode
            c = cmp.mapping.close()     -- for command mode
        }),
        ["<CR>"] = cmp.mapping.confirm({ select = true })
    },

    sources = cmp.config.sources({
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" },
        { name = "buffer" },
        { name = "path" }
    }),

    formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
            -- vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)
            vim_item.kind = icons[vim_item.kind]
            vim_item.abbr = string.sub(vim_item.abbr, 1, 60)
            vim_item.menu = ({
                nvim_lsp    = "[LSP]",
                nvim_lua    = "[Lua]",
                luasnip     = "[LuaSnip]",
                buffer      = "[Buffer]",
                path        = "[Path]"
            })[entry.source.name]
            return vim_item
        end
    },

    documentation = {
        border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },

    },

    sorting = {
        comparators = {
            cmp.config.compare.score,
            cmp.config.compare.offset,
            --cmp.config.compare.order,
            --cmp.config.compare.sort_text,
            --cmp.config.compare.exact,
            --cmp.config.compare.kind,
            --cmp.config.compare.length,
        }
    },

    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false
    },
    
    -- Select the first element while typing
    completion = {
        completeopt = "menu,menuone,noinsert"
    }
})
