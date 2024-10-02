local awful = require('awful')
local naughty = require('naughty')

local M = {}

local function create_tag(tag_number)
  local screen = awful.screen.focused()
  -- Check if the desired tag exists, if not, create it
  local tag = screen.tags[tag_number]
  if not tag then
    tag = awful.tag.add(tostring(tag_number), {
      screen = screen,
      layout = awful.layout.suit.tile,
    })
  end
  return tag
end

-- Function to add a tag to a client
local function add_tag_to_client(client, tag)
  -- Get the current tags of the client
  local client_tags = client:tags()

  -- Add the new tag to the list if it doesn't already exist
  if not awful.util.table.hasitem(client_tags, tag) then
    table.insert(client_tags, tag)
    client:tags(client_tags) -- Assign the updated tag list back to the client
  end
end

-- Spawn a client on the current tag and then add another tag as the first tag
local function spawn_on_current_and_add_tag(cmd, first_tag_name)
  -- Get the current tag (the one that is active/focused)
  local current_tag = awful.screen.focused().selected_tag

  -- Spawn the application in the current tag
  awful.spawn(cmd, {
    tag = current_tag, -- Start the client on the current tag
    callback = function(c)
      add_tag_to_client(c, first_tag_name)
    end,
  })
end

local function find_client(app_class, tag)
  -- Check if the application is already open on this tag
  for _, c in ipairs(tag:clients()) do
    if c.class == app_class then
      -- naughty.notify({
      --   title = 'Debug: Found client',
      --   text = 'Class: '
      --     .. tostring(c.class)
      --     .. '\nName: '
      --     .. tostring(c.name)
      --     .. '\nType: '
      --     .. type(c),
      -- })
      return c
    end
  end
  -- Notify only if the app is not found
  -- naughty.notify({
  --   title = 'Notification',
  --   text = app_class .. ' not found' .. 'on tag ' .. tag.index,
  -- })
  return nil
end

-- local function launch_app(app_command, tag, fn)
local function launch_app(app_command, tag)
  -- return awful.spawn(app_command, { tag = tag })
  return awful.spawn(app_command, { tag = tag })
end

local function launch(tag_number, app_class, app_command)
  -- Get the focused screen
  local tag = create_tag(tag_number)

  local existing_client = find_client(app_class, tag)

  -- If the application is not found on the tag, launch it
  if not existing_client then
    -- awful.spawn(app_command, { tag = tag })
    launch_app(app_command, tag)
  end
  return tag
end

-- Function to launch an app and toggle it on the current tag
function M.launch_and_toggle(tag_number, app_class, app_command)
  local tag = create_tag(tag_number)
  local current_tag = awful.screen.focused().selected_tag

  -- Check if the application is already open on default tag
  local existing_client = find_client(app_class, tag)

  if existing_client then
    existing_client:toggle_tag(current_tag)

    -- naughty.notify({
    --   title = 'only toggle',
    -- })
  else
    -- naughty.notify({
    --   title = 'launch and toggle',
    -- })

    spawn_on_current_and_add_tag(app_command, tag)
  end
end

-- Define a general function to switch to a tag and launch an app if needed
function M.switch_and_launch(tag_number, app_class, app_command)
  local tag = launch(tag_number, app_class, app_command)
  tag:view_only()
end

return M
