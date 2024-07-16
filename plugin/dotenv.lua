vim.api.nvim_create_user_command("SimianDotENV", require("dotenv").load_env, {})
