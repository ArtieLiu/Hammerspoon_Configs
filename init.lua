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
hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "s", open("slack"))
hs.hotkey.bind({"alt","ctrl","cmd","shift"}, "p", open("preview"))
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

-- from: https://github.com/hetima/hammerspoon-foundation_remapping
-- remap printscreen key to right option key
local FRemap = require('foundation_remapping')
remapper = FRemap.new({vendorID=0x17ef, productID=0x6047})
remapper:remap('PrintScreen', 'ralt')
remapper:register()
