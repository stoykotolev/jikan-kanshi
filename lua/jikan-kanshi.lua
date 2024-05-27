local augroup = vim.api.nvim_create_augroup("JikanKanshi", { clear = true })

local function bufEnter()
    print("Entering a buffer")
end

local function bufLeave()
    print("Leaving buffer")
end

local function setup()
    vim.api.nvim_create_autocmd("FileType", {
        group = augroup,
        desc = "Start the duration timer for the open filetype",
        once = true,
        callback = bufEnter,
    })

    vim.api.nvim_create_autocmd("BufLeave", {
        group = augroup,
        desc = "End the duration timer for the open filetype",
        once = true,
        callback = bufLeave,
    })
end

return { setup = setup }
