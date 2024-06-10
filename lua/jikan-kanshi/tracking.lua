local function checkInvalidFT(fileType)
  return fileType == nil or fileType == "" or fileType == "TelescopePrompt"
end

local fileTypeMapping = {
  typescriptreact = "typescript",
  typescript = "typescript",
  javascriptreact = "javascript",
  javascript = "javascript",
  lua = "lua",
  rust = "rust",
  python = "python",
  ruby = "ruby",
  java = "java",
  c = "c",
  cpp = "cpp",
  csharp = "csharp",
  go = "go",
  php = "php",
  html = "html",
  css = "css",
  scss = "css",
  less = "css",
  json = "json",
  xml = "xml",
  markdown = "markdown",
  sh = "bash",
  bash = "bash",
  zsh = "bash",
  powershell = "powershell",
  kotlin = "kotlin",
  dart = "dart",
  objectivec = "objective-c",
  objc = "objective-c",
  sql = "sql",
  perl = "perl",
  r = "r",
  swift = "swift",
  matlab = "matlab",
  julia = "julia",
  elixir = "elixir",
  erlang = "erlang",
  scala = "scala",
  groovy = "groovy",
  haskell = "haskell",
  clojure = "clojure",
  lisp = "lisp",
  vim = "viml",
  vimscript = "viml",
  tex = "latex",
  latex = "latex",
  toml = "toml",
  yaml = "yaml",
}

local startTime
local endTime
local fileType

local M = {}

--- Called when entering a buffer and the tracking needs to start
function M:bufEnter()
  fileType = fileTypeMapping[vim.bo.filetype] or "other"
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
end

return M
