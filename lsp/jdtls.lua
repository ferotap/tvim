local home = vim.env.HOME -- Get the home directory
local java_home = vim.env.JAVA_HOME
local nvim_appname = vim.env.NVIM_APPNAME or "nvim"
local java_filetypes = { "java" }
local jdtls = require("jdtls")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/.local/jdtls-workspace/" .. project_name
local myvim = require("et.util.myvim")

local system_os = ""

-- Determine OS
if vim.fn.has("mac") == 1 then
  system_os = "mac"
elseif vim.fn.has("unix") == 1 then
  system_os = "linux"
elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
  system_os = "win"
else
  print("OS not found, defaulting to 'linux'")
  system_os = "linux"
end

-- Needed for debugging
local bundles = {
  vim.fn.glob(home ..
  "/.local/share/" .. nvim_appname .. "/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"),
}

-- vim.list_extend(bundles,
--   vim.split(vim.fn.glob(home ..
--     "/.local/share/" .. nvim_appname .. "/mason/share/java-test/*.jar", true), "\n"))

return {

  filetypes = java_filetypes,
  root_markers = { ".git", "mvnw", "pom.xml", "build.gradle" },
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. home .. "/.local/share/" .. nvim_appname .. "/mason/share/jdtls/lombok.jar",
    "-Xmx4g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",

    -- Eclipse jdtls location
    "-jar",
    home .. "/.local/share/" .. nvim_appname .. "/mason/share/jdtls/plugins/org.eclipse.equinox.launcher.jar",
    "-configuration",
    home .. "/.local/share/" .. nvim_appname .. "/mason/packages/jdtls/config_" .. system_os,
    "-data",
    workspace_dir,
  },

  -- on_attach = function(client, bufnr)
  --   -- vim.print("client: " .. client.client_id .. "bufnr" .. bufnr)
  --   require("jdtls").setup_dap(require("dap").opts)
  -- end,
  --
  init_options = {
    bundles = bundles
  },
  settings = {
    java = {
      -- TODO(done) Replace this with the absolute path to your main java version (JDTLS requires JDK 21 or higher)
      home = java_home,
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        -- TODO(done) Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
        -- The runtimes' name parameter needs to match a specific Java execution environments.  See https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request and search "ExecutionEnvironment".
        runtimes = {
          -- {
          --   name = "JavaSE-17",
          --   path = "/opt/kela/java/jdk-17",
          -- },
          {
            default = true,
            name = "JavaSE-21",
            path = java_home,
          },
        },
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all"
        }
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      signatureHelp = { enabled = true },
      format = {
        enabled = true,
        -- Formatting works by default, but you can refer to a specific file/URL if you choose
        -- settings = {
        --   url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
        --   profile = "GoogleStyle",
        -- },
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "java",
          "javax",
          "com",
          "org",
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
        },
        useBlocks = true,
      },
    },
  },
}
