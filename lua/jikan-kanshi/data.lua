local Path = require("plenary.path")

-- @class JikanKanshiData
-- @field data_path string
local JikanKanshiData = {
    data_path = string.format("%s/jikan-kanshi", vim.fn.stdpath("data")),
}

function JikanKanshiData:ensure_data_path_exists()
    local path = Path:new(self.data_path)
    if not path:exists() then
        path:mkdir()
    end
end

function JikanKanshiData:write(data)
    Path:new(self.data_path .. "/filetype.json")
        :write(vim.json.encode(data), "w")
end

return JikanKanshiData
