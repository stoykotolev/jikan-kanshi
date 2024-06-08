local Data = require("jikan-kanshi.data")

local function checkInvalidFT(fileType)
  return fileType == nil or fileType == "" or fileType == "TelescopePrompt"
end
local startTime
local endTime
local fileType

local M = {}

function M:bufEnter()
  fileType = vim.bo.filetype
  print("ft", fileType)
  if checkInvalidFT(fileType) then
    return
  end
  startTime = os.time()
end

function M:bufLeave()
  if checkInvalidFT(fileType) then
    return
  end
  endTime = os.time()
  local timeSpent = os.difftime(endTime, startTime)
  -- Add timeSpent to the existing value or set it if it doesn't exist
  Data.data[fileType] = (Data.data[fileType] or 0) + timeSpent
  Data:write()
end

return M
