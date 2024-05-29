local Data = require("jikan-kanshi.data")

local startTime
local endTime
local fileType

local M = {}

function M:bufEnter()
    fileType = vim.bo.filetype
    startTime = os.time()
end

function M:bufLeave()
    endTime = os.time()
    local timeSpent = os.difftime(endTime, startTime)
    Data:write(
        fileType .. " has been opened for " .. timeSpent .. " seconds.\n"
    )
end

return M

