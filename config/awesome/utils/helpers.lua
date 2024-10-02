local awful = require('awful')
local M = {}

function M.switch(direction)
  local s = awful.screen.focused()
  local tags = s.tags
  local next_index = s.selected_tag.index + direction

  for i = next_index, direction > 0 and #tags or 1, direction do
    local t = tags[i]
    if #t:clients() > 0 then
      t:view_only()
      return
    end
  end
end

return M
