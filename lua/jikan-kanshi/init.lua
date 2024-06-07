local augroup = vim.api.nvim_create_augroup("JikanKanshi", { clear = true })
local Data = require("jikan-kanshi.data")
local BufFunctions = require("jikan-kanshi.jikan-kanshi")

local function setup()
    Data:sync()
    vim.api.nvim_create_autocmd("BufNew", {
        group = augroup,
        desc = "Start the duration timer for the open filetype",
        once = true,
        callback = function()
            BufFunctions:bufEnter()
        end,
    })

    vim.api.nvim_create_autocmd("QuitPre", {
        group = augroup,
        desc = "End the duration timer for the open filetype",
        once = true,
        callback = function()
            BufFunctions:bufLeave()
        end,
    })
end

return { setup = setup }
