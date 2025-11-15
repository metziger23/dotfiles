return {
	"NvChad/nvim-colorizer.lua",
	event = { "BufReadPre", "BufNewFile" },
	config = true,
	cmd = {
		"ColorizerAttachToBuffer",
		"ColorizerDetachFromBuffer",
		"ColorizerReloadAllBuffers",
		"ColorizerToggle",
	},
}
