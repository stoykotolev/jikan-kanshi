local Path = require("plenary.path")

local fileName = "filetype"

-- @class JikanKanshiData
-- @field data_path string
local JikanKanshiData = {
  data_path = string.format("%s/jikan-kanshi", vim.fn.stdpath("data")),
  file_path = "",
  error_log = string.format("%s/jikan-kanshi/error_log", vim.fn.stdpath("data")),
  data = {},
}

local function write_data(path, data)
  Path:new(path):write(vim.json.encode(data), "w")
end

local function read_data(file_name)
  local file = Path:new(file_name)
  if not file:exists() then
    local failed, err = pcall(write_data, file, "{}")
    if failed then
      write_data(JikanKanshiData.error_log, err)
    end
  end

  local out_data = file:read()

  if not out_data or out_data == "" then
    local failed, err = pcall(write_data, JikanKanshiData.file_path, "{}")
    if failed then
      write_data(JikanKanshiData.error_log, err)
    end
    out_data = "{}"
  end

  return out_data
end

function JikanKanshiData:ensure_data_path_exists()
  local path = Path:new(self.data_path)
  if not path:exists() then
    path:mkdir()
  end
end

function JikanKanshiData:write()
  write_data(self.file_path, self.data)
end

function JikanKanshiData:sync()
  JikanKanshiData:ensure_data_path_exists()
  self.file_path = string.format("%s/%s.json", self.data_path, fileName)
  local failed, result = pcall(read_data, self.file_path)
  if failed then
    write_data(JikanKanshiData.error_log, result)
    result = "{}"
  end
  self.data = vim.json.decode(result)
end

return JikanKanshiData
