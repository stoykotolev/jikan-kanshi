local Path = require("plenary.path")
local augroup = vim.api.nvim_create_augroup("JikanKanshi", { clear = true })

local data_path = string.format("%s/jikan-kanshi", vim.fn.stdpath("data"))
local data_path_exists = false
local data_file

local function ensure_data_path_exists()
    if data_path_exists then
        return
    end

    local path = Path:new(data_path)
    if not path:exists() then
        path:mkdir()
    end
    data_path_exists = true
    return string.format("%s/filetype.txt", data_path)
end

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

    Path:new(data_file)
        :write(
            fileType .. " has been opened for " .. timeSpent .. " seconds.",
            "a"
        )
end

local function setup()
    data_file = ensure_data_path_exists()
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
