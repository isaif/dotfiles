local function get_diagnostic_label(props)
  local icons = { error = '', warn = '', info = '', hint = '' }
  local label = {}

  for severity, icon in pairs(icons) do
    local n = #vim.diagnostic.get(
      props.buf,
      { severity = vim.diagnostic.severity[string.upper(severity)] }
    )
    if n > 0 then
      table.insert(
        label,
        { icon .. ' ' .. n .. ' ', group = 'DiagnosticSign' .. severity }
      )
    end
  end
  if #label > 0 then
    table.insert(label, { '| ' })
  end
  return label
end

local function get_git_diff(props)
  local icons = { removed = '~', changed = '-', added = '+' }
  local labels = {}
  local signs = vim.b[props.buf].gitsigns_status_dict

  if signs == nil then
    return labels
  end

  for name, icon in pairs(icons) do
    if tonumber(signs[name]) and signs[name] > 0 then
      table.insert(
        labels,
        { icon .. ' ' .. signs[name] .. ' ', group = 'Diff' .. name }
      )
    end
  end
  if #labels > 0 then
    table.insert(labels, { '| ' })
  end
  return labels
end

return {
  'b0o/incline.nvim',
  event = 'UIEnter',
  config = function()
    require('incline').setup({
      hide = {
        cursorline = 'focused_win',
      },
      render = function(props)
        local filename =
          vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end

        local ft_icon, ft_color =
          require('nvim-web-devicons').get_icon_color(filename)
        if ft_icon then
          ft_icon = ft_icon .. ' '
        end

        local modified = vim.bo[props.buf].modified and 'bold,italic' or 'bold'

        local buffer = {
          { get_diagnostic_label(props) },
          { get_git_diff(props) },
          { ft_icon, guifg = ft_color },
          { filename, gui = modified },
        }
        return buffer
      end,
    })
  end,
  -- config = true,
  dependencies = {
    -- required as I am using icons for filetype
    'nvim-tree/nvim-web-devicons',
    -- required to show git diff
    'lewis6991/gitsigns.nvim',
  },
}
