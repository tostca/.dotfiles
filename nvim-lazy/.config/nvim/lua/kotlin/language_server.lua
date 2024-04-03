local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")
local util = require("lspconfig.util")

local root_files = {
  "settings.gradle", -- Gradle (multi-project)
  "settings.gradle.kts", -- Gradle (multi-project)
  "build.xml", -- Ant
  "pom.xml", -- Maven
  "build.gradle", -- Gradle
  "build.gradle.kts", -- Gradle
}

local kotlin_config = {
  filetypes = { "kotlin" },
  cmd = {
    "/Users/tonystenberg/personal/kotlin-language-server/server/build/install/server/bin/kotlin-language-server",
  },
  settings = {},
}

if not configs.kotlin_language_server then
  configs.kotlin_language_server = {
    default_config = {
      filetypes = kotlin_config.filetypes,
      cmd = kotlin_config.cmd,
      root_dir = util.root_pattern(unpack(root_files)),
      init_options = {
        storagePath = util.root_pattern(unpack(root_files))(vim.fn.expand("%:p:h")),
      },
      settings = kotlin_config.settings,
    },
  }
end

lspconfig.kotlin_language_server.setup({})
