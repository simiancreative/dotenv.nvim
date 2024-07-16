local config = require("dotenv.config")
local methods = require("dotenv.methods")

local M = {}

M.config = config

M.setup = function(args)
  M.config = vim.tbl_deep_extend("force", M.config, args or {})
end

M.load_env = function() 
  methods.load_env(M.config)
end

return M
