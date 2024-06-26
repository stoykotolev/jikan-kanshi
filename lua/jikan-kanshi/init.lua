local augroup = vim.api.nvim_create_augroup("JikanKanshi", { clear = true })
local Data = require("jikan-kanshi.data")
local Logger = require("jikan-kanshi.logger")
local Tracking = require("jikan-kanshi.tracking")

--- @class JikanKanshiConfig
--- @field data JikanKanshiData
--- @field logger JikanKanshiLogger
local JikanKanshi = {}

JikanKanshi.__index = JikanKanshi

--- @return JikanKanshiConfig
function JikanKanshi:new()
  return setmetatable({
    data = Data:new(),
    logger = Logger:new(),
  }, self)
end

local config = JikanKanshi:new()

local function setup()
  vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained" }, {
    group = augroup,
    desc = "Start the duration timer for the open filetype",
    callback = function()
      vim.schedule(function()
        Tracking:bufEnter()
      end)
      Tracking:bufEnter()
    end,
  })

  vim.api.nvim_create_autocmd({ "QuitPre", "BufLeave", "FocusLost" }, {
    group = augroup,
    desc = "Start the duration timer for the open filetype",
    callback = function(ev)
      Tracking:bufLeave(config)
      if ev.event == "QuitPre" then
        config.data:sync()
      end
    end,
  })

  vim.api.nvim_create_user_command("JikanData", function()
    config.data:get_data()
  end, {})
end

return { setup = setup }
