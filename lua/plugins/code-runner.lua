return {
    "CRAG666/code_runner.nvim",
    lazy = true,
    opts = {
        filetype = {
            python = "python3 -u",
            typescript = "deno run",
            sh = "bash",
            php = "php",
            javascript = "node",
            java = "java"
        },

    },
    config = true,
    cmd = { "RunCode", "RunFile", "RunProject", "RunClose" }
}
