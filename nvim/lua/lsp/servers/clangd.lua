return {
    cmd = { "clangd" },

    filetypes = {
        "c",
        "cpp",
        "objc",
        "objcpp",
    },

    root_markers = {
        ".clangd",
        ".clang-format",
        "compile_commands.json",
        "compile_flags.txt",
        ".git",
    },

    init_options = {
        clangdFileStatus = true,
    },
}
