local Data = require("jikan-kanshi.data")

local function checkInvalidFT(fileType)
    return fileType == nil or fileType == "" or fileType == "TelescopePrompt"
end

local fileTypesData = {}

local startTime
local endTime
local fileType

local M = {}

function M:bufEnter()
    fileType = vim.bo.filetype
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
    fileTypesData[fileType] = timeSpent
    Data:write(fileTypesData)
end

return M
