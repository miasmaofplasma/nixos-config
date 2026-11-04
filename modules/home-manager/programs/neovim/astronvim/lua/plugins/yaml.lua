if true then return {} end
return {
  {
    "AstroNvim/astrolsp",
    ---@type AstroCoreOpts
    opts = {
      config = {
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ["/Users/10203773/pyxis/connected-sdk-go/spec/schema/connected-module-spec.json"] = "connected-api.yaml",
              },
            },
          },
        },
      },
      treesitter = { ensure_installed = { "yaml" } },
    },
  },
  {
    "AstroNvim/astrocore",
    optional = true,
    ---@type AstroCoreOpts
    opts = {
      treesitter = { ensure_installed = { "yaml" } },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "yamlls" })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "yaml-language-server" })
    end,
  },
}
