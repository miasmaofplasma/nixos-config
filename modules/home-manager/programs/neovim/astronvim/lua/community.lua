-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- language packs
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.typescript-all-in-one" },
  -- { import = "astrocommunity.pack.sql" },
  { import = "astrocommunity.pack.yaml" },
  { import = "astrocommunity.pack.cs" },
  -- other
  { import = "astrocommunity.file-explorer.yazi-nvim" },
  { import = "astrocommunity.ai.opencode-nvim" },
  { import = "astrocommunity.diagnostics.trouble-nvim" },

  -- testing
  { import = "astrocommunity.test.neotest" },
  -- motion
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.portal-nvim" },
  { import = "astrocommunity.motion.vim-matchup" },
  -- end motion

  -- import/override with your plugins folder
}
