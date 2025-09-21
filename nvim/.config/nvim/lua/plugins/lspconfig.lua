local hydra_utils = require("../utils/hydra_utils")

--- Implements the off-spec textDocument/switchSourceHeader method.
--- @param buf integer
local function switch_source_header(client, buf)
	client:request("textDocument/switchSourceHeader", vim.lsp.util.make_text_document_params(buf), function(err, result)
		if err then
			vim.notify(err.message, vim.log.levels.ERROR)
			return
		end
		if not result then
			vim.notify("Corresponding file could not be determined", vim.log.levels.WARN)
			return
		end
		vim.cmd.edit(vim.uri_to_fname(result))
	end)
end

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		"mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"ibhagwan/fzf-lua",
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

		local keymap = vim.keymap -- for conciseness

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local lsp = vim.lsp
				local completion = lsp.completion
				local ms = lsp.protocol.Methods

				local client = lsp.get_client_by_id(ev.data.client_id)
				if not client or not client:supports_method(ms.textDocument_completion) then
					return
				end
				-- Buffer local mappings.
				-- See `:help vim.lsp.*` for documentation on any of the below functions
				local opts = { buffer = ev.buf, silent = true }
				local fzf_lua = require("fzf-lua")

				opts.desc = "Signature Help"
				keymap.set({ "n", "i", "s" }, "<c-s>", function()
					-- NOTE: for some reason the border gets rouned only when this
					-- is called with "function()"
					vim.lsp.buf.signature_help()
				end, opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				opts.desc = "Goto definition"
				keymap.set("n", "gd", fzf_lua.lsp_definitions, opts)
				keymap.set("n", "gI", fzf_lua.lsp_implementations, opts)
				opts.desc = "Goto type"
				keymap.set("n", "gy", fzf_lua.lsp_typedefs, opts)
				opts.desc = "Goto References"
				keymap.set("n", "gr", fzf_lua.lsp_references, opts)
				opts.desc = "Goto Line Diagnostics"
				keymap.set("n", "gl", vim.diagnostic.open_float, opts)

				opts.desc = "Lsp Implementations"
				keymap.set("n", "li", fzf_lua.lsp_implementations, opts)
				opts.desc = "Lsp Document Symbols"
				keymap.set("n", "ls", fzf_lua.lsp_document_symbols, opts)
				opts.desc = "Lsp Workspace Symbols"
				keymap.set("n", "lw", fzf_lua.lsp_live_workspace_symbols, opts)
				opts.desc = "Lsp Workspace Symbols (live query)"
				keymap.set("n", "ll", fzf_lua.lsp_live_workspace_symbols, opts)
				opts.desc = "Lsp Document Diagnostics"
				keymap.set("n", "ld", fzf_lua.diagnostics_document, opts)
				opts.desc = "Lsp Workspace Diagnostics"
				keymap.set("n", "lD", fzf_lua.diagnostics_workspace, opts)

				if client:supports_method("callHierarchy/incomingCalls", ev.buf) then
					opts.desc = "Lsp incoming calls"
					keymap.set("n", "lc", fzf_lua.lsp_incoming_calls, opts)
				end

				if client:supports_method("callHierarchy/outgoingCalls", ev.buf) then
					opts.desc = "Lsp outgoing calls"
					keymap.set("n", "lC", fzf_lua.lsp_outgoing_calls, opts)
				end

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
			end,
		})

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			-- You can also include other diagnostic configurations here
			-- virtual_text = true,
			-- underline = true,
			-- etc.
		})

		local capabilities = require("blink.cmp").get_lsp_capabilities()

		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- configure bashls server
		vim.lsp.config("bashls", {})

		-- configure clangd server
		vim.lsp.config("clangd", {
			cmd = {
				"clangd",
				"--background-index",
				"--clang-tidy",
				"--header-insertion=never",
				"--completion-style=detailed",
				"--function-arg-placeholders",
				"--fallback-style=llvm",
				-- "--compile-commands-dir=" .. vim.fn.getcwd(),
				"--compile-commands-dir=.",
			},
			init_options = {
				usePlaceholders = true,
				completeUnimported = true,
				clangdFileStatus = true,
			},
			on_attach = function(client, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, "ClangdSwitchSourceHeader", function()
					switch_source_header(client, bufnr)
				end, {
					bar = true,
					desc = "Switch Source/Header (C/C++)",
				})
				local clang_opts = { noremap = true, silent = true }
				clang_opts.buffer = bufnr
				clang_opts.desc = "Switch Source/Header (C/C++)"
				vim.keymap.set("n", "gs", "<cmd>ClangdSwitchSourceHeader<cr>", clang_opts)
				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("conf_lsp_attach_detach", { clear = false }),
					buffer = bufnr,
					callback = function(args)
						if args.data.client_id == client.id then
							vim.keymap.del("n", "gs", { buffer = bufnr })
							vim.api.nvim_buf_del_user_command(bufnr, "ClangdSwitchSourceHeader")
							return true -- Delete this autocmd.
						end
					end,
				})
			end,
		})

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls", {
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

		vim.lsp.config("qmlls", {
			cmd = { vim.env.QT_BIN_DIR ~= nil and vim.fs.joinpath(vim.env.QT_BIN_DIR, "qmlls") or "qmlls" },
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

		vim.lsp.config("fish_lsp", {
			cmd = { "fish-lsp", "start" },
			filetypes = { "fish" },
			cmd_env = { fish_lsp_show_client_popups = false },
		})
	end,
}
