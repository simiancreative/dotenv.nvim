function script_path()
   local str = debug.getinfo(2, "S").source:sub(2)
   return str:match("(.*/)")
end

return {
  load_env = function(opts)
    -- load env file and set env variables
    local handle = io.popen('sh ' .. script_path() .. opts.script_path)

    -- read the result
    local result = handle:read("*a")
    handle:close()

    -- set vim env variables
    for line in string.gmatch(result, "[^\r\n]+") do
      -- get key and value
      local key, value = string.match(line, "([^=]+)=([^=]+)")

      if not key or not value then
        goto continue
      end

      -- if key is not a prefix, then skip
      local is_prefix = false
      for _, prefix in ipairs(opts.prefixes) do
        if string.match(key, prefix) then
          is_prefix = true
          break
        end
      end

      if not is_prefix then
        goto continue
      end

      if key and value then
        vim.fn.setenv(key, value)
      end

      ::continue::
    end
  end
}
