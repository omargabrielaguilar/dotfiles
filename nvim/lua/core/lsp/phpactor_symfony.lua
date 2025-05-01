---@type vim.lsp.Config
return {
  cmd = { "phpactor", "language-server" },
  root_markers = { "composer.json" },
  filetypes = { "php" },
  init_options = {
    ["language_server_configuration.auto_config"] = false,
    ["language_server_worse_reflection.inlay_hints.enable"] = true,
    ["language_server_worse_reflection.inlay_hints.types"] = false,
    ["language_server_worse_reflection.inlay_hints.params"] = true,
    ["code_transform.import_globals"] = true,
    ["phpunit.enabled"] = true,
    ["indexer.exclude_patterns"] = {
      "/vendor/**/Tests/**/*",
      "/vendor/**/tests/**/*",
      "/var/cache/**/*",
      "/vendor/composer/**/*",
    },
    ["php_code_sniffer.enabled"] = true,
    ["php_code_sniffer.bin"] = "%project_root%/bin/phpcs",

    ["language_server_phpstan.enabled"] = true,
    ["language_server_phpstan.level"] = "7",
    ["language_server_phpstan.bin"] = "%project_root%/bin/phpstan",
    ["language_server_phpstan.mem_limit"] = "2048M",
  },
}
