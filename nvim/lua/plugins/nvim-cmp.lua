return {
	'hrsh7th/nvim-cmp',
	dependencies = {
		'neovim/nvim-lspconfig',
		'hrsh7th/cmp-nvim-lsp'
	},
	config = function()
		local cmp = require('cmp')
		cmp.setup({
			enabled = function()
				local context = require('cmp.config.context')
				if vim.api.nvim_get_mode().mode == 'c' then
					return true
				else
					return not context.in_treesitter_capture('comment')
						and not context.in_syntax_group('Comment')
				end
			end,
			snippet = {
				{
					expand = function(args)
						vim.fn['vsnip#anonymous'](args.body)
					end,
				},
			},
			sources = cmp.config.sources({
				-- Ensure that only nvim_lsp is used as a source to remove text sources
				{ name = 'nvim_lsp', },
			}, {
					{ name = 'path', },
				}),
			mapping = {
				['<CR>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				['<C-e>'] = cmp.mapping.abort(),
				['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
				['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
				['<C-p>'] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_prev_item({behavior = 'insert'})
					else
						cmp.complete()
					end
				end),
				['<C-n>'] = cmp.mapping(function()
					if cmp.visible() then
						cmp.select_next_item({behavior = 'insert'})
					else
						cmp.complete()
					end
				end),
			},
			-- experimental = {
			--     ghost_text = true,
			-- },
		})
	end
}
