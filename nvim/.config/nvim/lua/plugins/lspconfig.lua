local hydra_utils = require("../utils/hydra_utils")

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"folke/snacks.nvim",
	},
	config = function()
		-- Decorate floating windows
		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })

		vim.lsp.handlers["textDocument/signatureHelp"] =
			vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

		vim.diagnostic.config({
			float = { border = "rounded" },
		})
		require("lspconfig.ui.windows").default_options.border = "rounded"

		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import cmp-nvim-lsp plugin
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr
			local picker = require("snacks").picker

			opts.desc = "Signature Help"
			keymap.set({ "n", "i", "s" }, "<c-s>", vim.lsp.buf.signature_help, opts)

			opts.desc = "Lsp Decralations"
			keymap.set("n", "gD", function()
				picker.lsp_declarations({ jump = { reuse_win = false } })
			end, opts)
			opts.desc = "Lsp Definitions"
			keymap.set("n", "gd", function()
				picker.lsp_definitions({ jump = { reuse_win = false } })
			end, opts)
			opts.desc = "Lsp Implementations"
			keymap.set("n", "gI", function()
				picker.lsp_implementations({ jump = { reuse_win = false } })
			end, opts)
			opts.desc = "Lsp Type Definitions"
			keymap.set("n", "gy", function()
				picker.lsp_type_definitions({ jump = { reuse_win = false } })
			end, opts)
			opts.desc = "Lsp References"
			keymap.set("n", "gr", function()
				picker.lsp_references({ jump = { reuse_win = false } })
			end, opts)
			opts.desc = "Goto Line Diagnostics"
			keymap.set("n", "gl", vim.diagnostic.open_float, opts)

			opts.desc = "Lsp Implementations"
			keymap.set("n", "li", picker.lsp_implementations, opts)
			opts.desc = "Lsp Document Symbols"
			keymap.set("n", "ls", picker.lsp_symbols, opts)
			opts.desc = "Lsp Workspace Symbols"
			keymap.set("n", "lw", picker.lsp_workspace_symbols, opts)
			opts.desc = "Lsp Buffer Diagnostics"
			keymap.set("n", "lb", picker.diagnostics_buffer, opts)
			opts.desc = "Lsp Diagnostics"
			keymap.set("n", "lD", picker.diagnostics, opts)

			-- NOTE: snacks picker doesn't support this yet
			-- if client.supports_method("callHierarchy/incomingCalls") then
			-- 	opts.desc = "Lsp incoming calls"
			-- 	keymap.set("n", "lc", picker.lsp_incoming_calls, opts)
			-- end

			-- NOTE: snacks picker doesn't support this yet
			-- if client.supports_method("callHierarchy/outgoingCalls") then
			-- 	opts.desc = "Lsp outgoing calls"
			-- 	keymap.set("n", "lC", picker.lsp_outgoing_calls, opts)
			-- end

			opts.desc = "Lsp rename"
			keymap.set("n", "lr", function()
				vim.lsp.buf.rename()
			end, opts)
			opts.desc = "Lsp Code action"
			keymap.set({ "n", "x" }, "la", function()
				vim.lsp.buf.code_action()
			end, opts)
			opts.desc = "Lsp Source action"
			keymap.set({ "n", "x" }, "lA", function()
				vim.lsp.buf.code_action({ context = { only = { "source" }, diagnostics = {} } })
			end, opts)
			opts.desc = "Format"
			keymap.set("n", "lf", function()
				require("conform").format()
			end, opts)
			opts.desc = "Format selection"
			keymap.set("v", "lf", function()
				require("conform").format()
			end, opts)

			opts.desc = "Hover information"
			keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)

			hydra_utils.setup_bidirectional_hydra("n", "diagnostic", "[d", "]d", function()
				vim.diagnostic.goto_prev({ severity = nil })
			end, function()
				vim.diagnostic.goto_next({ severity = nil })
			end, opts)

			hydra_utils.setup_bidirectional_hydra("n", "error", "[e", "]e", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["ERROR"] })
			end, function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["ERROR"] })
			end, opts)

			hydra_utils.setup_bidirectional_hydra("n", "warning", "[w", "]w", function()
				vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity["WARN"] })
			end, function()
				vim.diagnostic.goto_next({ severity = vim.diagnostic.severity["WARN"] })
			end, opts)
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		-- configure bashls server
		lspconfig["bashls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure clangd server
		lspconfig["clangd"].setup({
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
				"--compile-commands-dir=.",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				on_attach(client, bufnr)
				local clang_opts = { noremap = true, silent = true }
				clang_opts.buffer = bufnr
				clang_opts.desc = "Switch Source/Header (C/C++)"
				vim.keymap.set("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", clang_opts)
			end,
		})

		-- configure lua server (with special settings)
		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		lspconfig["qmlls"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { vim.env.QMLLS_NEWEST },
			filetypes = { "qmljs", "qml" },
			handlers = {
				["textDocument/publishDiagnostics"] = function(err, method, params, client_id)
					local filtered_diagnostics = {}
					for _, diagnostic in ipairs(method.diagnostics) do
						if diagnostic.severity ~= vim.diagnostic.severity.WARN then
							table.insert(filtered_diagnostics, diagnostic)
						end
					end

					-- Update the diagnostics in the params to only include errors
					method.diagnostics = filtered_diagnostics
					vim.lsp.handlers["textDocument/publishDiagnostics"](err, method, params, client_id)
				end,
			},
		})

		lspconfig["fish_lsp"].setup({
			capabilities = capabilities,
			on_attach = on_attach,
			cmd = { "fish-lsp", "start" },
			filetypes = { "fish" },
			cmd_env = { fish_lsp_show_client_popups = false },
		})
	end,
}
