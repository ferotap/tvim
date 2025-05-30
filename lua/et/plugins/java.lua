return {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/nvim-java-refactor",
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        version = "^1.0.0", -- workaround for mason 2.0 compatibilit problem
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
      {
        "williamboman/mason-lspconfig.nvim",
        version = "^1.0.0", -- workaround for mason 2.0 compatibilit problem

        opts = {
          handlers = {
            ["jdtls"] = function()
              require("java").setup()
            end,
          },
        },
      },
    },
  },
}
