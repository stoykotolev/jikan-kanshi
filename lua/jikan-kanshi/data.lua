local Path = require("plenary.path")

local data_path = string.format("%s/jikan-kanshi", vim.fn.stdpath("data"))
local data_path_exists = false
local file = string.format("%s/filetype.json", data_path)

local function ensure_data_path()
  if data_path_exists then
    return
  end
  local path = Path:new(data_path)

  if not path:exists() then
    path:mkdir()
  end
  data_path_exists = true
end

local function write_data(path, data)
  Path:new(path):write(vim.json.encode(data), "w")
end

--- @alias JikanKanshiRawData {[string]: number}

--- Get the data from the local file
--- @param file_path string
--- @return JikanKanshiRawData
local function read_data(file_path)
  ensure_data_path()

  local path = Path:new(file_path)

  if not path:exists() then
    write_data(file_path, {})
  end

  local result_data = path:read()

  if not result_data or result_data == "" then
    write_data(file_path, {})
    result_data = "{}"
  end

  local data = vim.json.decode(result_data)

  return data
end

-- get the data from the file
-- write to the table, that was retreived from the file
-- on close, sync the data with the file

--- @class JikanKanshiData
--- @field _data JikanKanshiRawData
--- @field file_path string
--- @field has_error boolean
local Data = {}

Data.__index = Data

--- Either creates or reads from the existing file for filetypes.
function Data:new()
  local ok, data = pcall(read_data, file)

  if not ok then
    data = {}
  end

  return setmetatable({
    _data = data,
    file_path = file,
    has_error = not ok,
  }, self)
end

--- The whole idea of this function is to get the current data that you have
--  and then sync it with the existing data in the file, as it might be different
function Data:sync()
  if self.has_error then
    return
  end
  local ok, data = pcall(read_data, self.file_path)

  if not ok then
    -- config.logger.log_error(config.logger, "Failed syncing the jikan kashi data file.")
    error("Unable to update the data file")
    return
  end

  for k, v in pairs(self._data) do
    local new_time = (data[k] or 0) + v
    data[k] = new_time
  end

  pcall(write_data, self.file_path, data)
end

--- Update the data for the specific file type
--- @param file_type string
--- @param duration number
function Data:update(file_type, duration)
  self._data[file_type] = (self._data[file_type] or 0) + duration
end

return Data
