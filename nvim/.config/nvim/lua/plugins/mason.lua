return {
	"mason-org/mason.nvim",
	version = "1.11.0",
	cmd = {
		"Mason",
		"MasonUpdate",
		"MasonInstall",
		"MasonUninstall",
		"MasonUninstallAll",
		"MasonLog",
	},
	dependencies = {
		{ "mason-org/mason-lspconfig.nvim", version = "1.32.0" },
		{ "WhoIsSethDaniel/mason-tool-installer.nvim", commit = "09caa3380a0e8532043bc417c04d1d6d31b6683b" },
	},
	config = function()
		-- import mason
		local mason = require("mason")

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				border = "rounded",
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = {
				"lua_ls",
				"bashls",
				"clangd",
			},
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true, -- not the same as ensure_installed
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"stylua", -- lua formatter
				"clang-format",
			},
		})
	end,
}
