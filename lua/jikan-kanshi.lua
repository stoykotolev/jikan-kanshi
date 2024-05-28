local Data = require("jikan-kanshi.data")

local augroup = vim.api.nvim_create_augroup("JikanKanshi", { clear = true })
local startTime
local endTime
local fileType

local function bufEnter()
    fileType = vim.bo.filetype
    startTime = os.time()
end

local function bufLeave()
    endTime = os.time()
    local timeSpent = os.difftime(endTime, startTime)
    Data:write(
        fileType .. " has been opened for " .. timeSpent .. " seconds.\n"
    )
end

local function setup()
    Data:ensure_data_path_exists()
    vim.api.nvim_create_autocmd("BufNew", {
        group = augroup,
        desc = "Start the duration timer for the open filetype",
        once = true,
        callback = bufEnter,
    })

    vim.api.nvim_create_autocmd("QuitPre", {
        group = augroup,
        desc = "End the duration timer for the open filetype",
        once = true,
        callback = bufLeave,
    })
end

return { setup = setup }
