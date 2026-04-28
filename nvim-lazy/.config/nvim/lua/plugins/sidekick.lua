-- Use sidekick.nvim ONLY for CLI tools (no NES, no Copilot status tracking)
-- https://github.com/folke/sidekick.nvim#can-i-use-this-without-nes-just-for-cli-tools
return {
  "folke/sidekick.nvim",
  opts = {
    -- Disable Next Edit Suggestions (NES)
    nes = {
      enabled = false,
    },
    -- Disable Copilot status tracking (no Copilot LSP needed)
    copilot = {
      status = {
        enabled = false,
      },
    },
  },
}
