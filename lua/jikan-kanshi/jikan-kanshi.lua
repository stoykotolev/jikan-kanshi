local function checkInvalidFT(fileType)
  return fileType == nil or fileType == "" or fileType == "TelescopePrompt"
end
local startTime
local endTime
local fileType

local M = {}

--- Called when entering a buffer and the tracking needs to start
function M:bufEnter()
  fileType = vim.bo.filetype
  if checkInvalidFT(fileType) then
    return
  end
  startTime = os.time()
end

--- Called when leaving a buffer and the tracking needs to end
--- @param config JikanKanshiConfig
function M:bufLeave(config)
  if checkInvalidFT(fileType) then
    return
  end
  endTime = os.time()
  local timeSpent = os.difftime(endTime, startTime)
  config.data:update(fileType, timeSpent)
  config.data:sync()
end

return M
