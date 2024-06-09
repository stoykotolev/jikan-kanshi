local Path = require("plenary.path")

--- @class JikanKanshiLogger
--- @field error_log_path string
local Logger = {}

Logger.__index = Logger

--- Initialize the logger
---@return JikanKanshiLogger
function Logger:new()
  local logger = setmetatable({
    error_log_path = string.format("%s/jikan-kanshi/%s", vim.fn.stdpath("data"), "error_log"),
  }, self)

  return logger
end

--- @param error string
function Logger:log_error(error)
  Path:new(self.error_log_path):write(error .. "\n", "a")
end

return Logger
