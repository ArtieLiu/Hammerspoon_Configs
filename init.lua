-- reload config
hs.hotkey.bind({"cmd", "alt", "ctrl", "shift"}, "R", function()
    hs.reload()
end)
hs.alert.show("Config loaded")

-- open app
-- from: https://liuhao.im/english/2017/06/02/macos-automation-and-shortcuts-with-hammerspoon.html
--- A closure function
function open(name)
  return function()
      hs.application.launchOrFocus(name)
      if name == 'Finder' then
          hs.appfinder.appFromName(name):activate()
      end
  end
end

hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "i", open("iTerm"))
hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "o", open("Google Chrome"))
hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "m", open("NeteaseMusic"))
hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "j", open("IntelliJ IDEA"))
hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "k", open("Enan Kanban"))
hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "w", open("wechat"))
-- hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "c", open("Visual Studio Code"))
-- hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "p", function() hs.eventtap.keyStroke({},"F3") end)

-- remap
local function pressFn(mods, key)
	if key == nil then
		key = mods
		mods = {}
	end

	return function() hs.eventtap.keyStroke(mods, key, 1000) end
end

local function remap(mods, key, pressFn)
	hs.hotkey.bind(mods, key, pressFn, nil, pressFn)	
end

remap({'ctrl'}, 'h', pressFn('left'))
remap({'ctrl'}, 'j', pressFn('down'))
remap({'ctrl'}, 'k', pressFn('up'))
remap({'ctrl'}, 'l', pressFn('right'))
remap({'ctrl', 'alt'}, 'l', pressFn('alt','right')) -- word-wise moving
remap({'ctrl', 'alt'}, 'h', pressFn('alt','left'))

-- u i o
-- j k l
-- m , .
-- remap({'cmd','ctrl','alt',"shift"},'space', pressFn('0'))
-- remap({'cmd','ctrl','alt',"shift"},'u', pressFn('7'))
-- remap({'cmd','ctrl','alt',"shift"},'i', pressFn('8'))
-- remap({'cmd','ctrl','alt',"shift"},'o', pressFn('9'))
-- remap({'cmd','ctrl','alt',"shift"},'j', pressFn('4'))
-- remap({'cmd','ctrl','alt',"shift"},'k', pressFn('5'))
-- remap({'cmd','ctrl','alt',"shift"},'l', pressFn('6'))
-- remap({'cmd','ctrl','alt',"shift"},'m', pressFn('1'))
-- remap({'cmd','ctrl','alt',"shift"},',', pressFn('2'))
-- remap({'cmd','ctrl','alt',"shift"},'.', pressFn('3'))

-- Credit for this implementation goes to @arbelt and @jasoncodes 🙇⚡️😻
--
--   https://gist.github.com/arbelt/b91e1f38a0880afb316dd5b5732759f1
--   https://github.com/jasoncodes/dotfiles/blob/ac9f3ac/hammerspoon/control_escape.lua

-- send_escape = false
-- last_mods = {}

-- control_key_handler = function()
--   send_escape = false
-- end

-- control_key_timer = hs.timer.delayed.new(0.12, control_key_handler)

-- control_handler = function(evt)
--   local new_mods = evt:getFlags()
--   if last_mods["ctrl"] == new_mods["ctrl"] then
--     return false
--   end
--   if not last_mods["ctrl"] then
--     last_mods = new_mods
--     send_escape = true
--     control_key_timer:start()
--   else
--     if send_escape then
--       hs.eventtap.keyStroke({}, "ESCAPE")
--     end
--     last_mods = new_mods
--     control_key_timer:stop()
--   end
--   return false
-- end

-- control_tap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, control_handler)
-- control_tap:start()

-- other_handler = function(evt)
--   send_escape = false
--   return false
-- end

-- other_tap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, other_handler)
-- other_tap:start()
