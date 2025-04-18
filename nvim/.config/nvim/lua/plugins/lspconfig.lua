local hydra_utils = require("../utils/hydra_utils")

local function find_compile_commands(start_path)
	-- Search upward from the current file's directory
	local path = vim.fs.find("compile_commands.json", { path = start_path, upward = true })[1]
	if not path then
		return nil
	end

	-- Resolve symlinks (returns nil if path doesn't exist)
	local realpath = vim.loop.fs_realpath(path)
	return realpath or path -- Fallback to original if not a symlink
end

function start_client()
	local ok, Manager = pcall(require, "lspconfig.manager")
	if not ok then
		return
	end

	local util = require("lspconfig.util")
	local lsp = vim.lsp

	function Manager:_start_client(bufnr, new_config, root_dir, single_file, silent)
		-- do nothing if the client is not enabled
		if new_config.enabled == false then
			return
		end
		if not new_config.cmd then
			vim.notify(
				string.format(
					"[lspconfig] cmd not defined for %q. Manually set cmd in the setup {} call according to configs.md, see :help lspconfig-setup.",
					new_config.name
				),
				vim.log.levels.ERROR
			)
			return
		end

		new_config.on_init = util.add_hook_before(new_config.on_init, function(client)
			self:_notify_workspace_folder_added(root_dir, client)
		end)

		new_config.on_exit = util.add_hook_before(new_config.on_exit, function()
			for name in pairs(self._clients[root_dir]) do
				if name == new_config.name then
					self._clients[root_dir][name] = nil
				end
			end
		end)

		-- Launch the server in the root directory used internally by lspconfig, if otherwise unset
		-- also check that the path exist
		if not new_config.cmd_cwd and vim.uv.fs_realpath(root_dir) then
			new_config.cmd_cwd = root_dir
		end

		-- Sending rootDirectory and workspaceFolders as null is not explicitly
		-- codified in the spec. Certain servers crash if initialized with a NULL
		-- root directory.
		if single_file then
			new_config.root_dir = nil
			new_config.workspace_folders = nil
		end

		local start_new_clangd = false
		local reuse_clangd_id = nil

		if new_config.name == "clangd" then
			local root_dir_comp_db = find_compile_commands(root_dir)
			if root_dir_comp_db ~= nil then
				start_new_clangd = true
				for client_root_dir, dir_clients in pairs(self._clients) do
					if dir_clients[new_config.name] then
						local client_root_dir_comp_db = find_compile_commands(client_root_dir)
						if client_root_dir_comp_db == root_dir_comp_db then
							start_new_clangd = false
							reuse_clangd_id = dir_clients[new_config.name].id
							break
						end
					end
				end
			end
		end

		if reuse_clangd_id ~= nil then
			lsp.buf_attach_client(bufnr, reuse_clangd_id)
			self:_cache_client(root_dir, assert(lsp.get_client_by_id(reuse_clangd_id)))
			return
		end

		local reuse_client = function(existing_client)
			if (self._clients[root_dir] or {})[existing_client.name] then
				self:_notify_workspace_folder_added(root_dir, existing_client)
				return true
			end

			for _, dir_clients in pairs(self._clients) do
				if dir_clients[existing_client.name] then
					self:_notify_workspace_folder_added(root_dir, existing_client)
					return true
				end
			end

			return false
		end

		local client_id = lsp.start(new_config, {
			bufnr = bufnr,
			silent = silent,
			reuse_client = function(existing_client)
				if start_new_clangd then
					return false
				end
				return reuse_client(existing_client)
			end,
		})

		if client_id then
			self:_cache_client(root_dir, assert(lsp.get_client_by_id(client_id)))
		end
	end
end

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

		start_client()

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
				"--pch-storage=memory",
				"--function-arg-placeholders",
				"--compile-commands-dir=.",
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
