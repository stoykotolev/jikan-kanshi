local augroup = vim.api.nvim_create_augroup("JikanKanshi", { clear = true })
local Data = require("jikan-kanshi.data")
local BufFunctions = require("jikan-kanshi.jikan-kanshi")

local function setup()
  Data:new()
  vim.api.nvim_create_autocmd({ "BufAdd" }, {
    group = augroup,
    desc = "Start the duration timer for the open filetype",
    once = true,
    callback = function()
      vim.schedule(function()
        BufFunctions:bufEnter()
      end)
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
