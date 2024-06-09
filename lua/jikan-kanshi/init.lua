local augroup = vim.api.nvim_create_augroup("JikanKanshi", { clear = true })
local Data = require("jikan-kanshi.data")
local Logger = require("jikan-kanshi.logger")
local BufFunctions = require("jikan-kanshi.jikan-kanshi")

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
      BufFunctions:bufLeave(config)
    end,
  })
end

return { setup = setup }
