return {
	"saghen/blink.pairs",
	version = "*", -- (recommended) only required with prebuilt binaries

	-- download prebuilt binaries from github releases
	dependencies = "saghen/blink.download",

	--- @module 'blink.pairs'
	--- @type blink.pairs.Config
	opts = {
		highlights = {
			enabled = false,
		},
	},
}
