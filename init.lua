HYPER={"cmd", "alt", "ctrl", "shift"}

-- reload config
hs.hotkey.bind(HYPER, "R", function()
    hs.reload()
end)
hs.alert.show("Config loaded")

-- open app
-- from: https://liuhao.im/english/2017/06/02/macos-automation-and-shortcuts-with-hammerspoon.html
--- A closure function
function open(name)
  return function()
      hs.application.launchOrFocus(name)
  end
end

-- open file
function openFile(name)
  return function()
      hs.open(name)
  end
end


hs.hotkey.bind(HYPER, "b", open("obsidian"))
hs.hotkey.bind(HYPER, "c", open("Visual Studio Code"))
hs.hotkey.bind(HYPER, "d", open("dict"))
hs.hotkey.bind(HYPER, "i", open("iTerm"))
hs.hotkey.bind(HYPER, "j", open("IntelliJ IDEA"))
hs.hotkey.bind(HYPER, "k", openFile("/Users/yinan.liu/OneDrive/Kanban/enan kanban.kanbanier"))
hs.hotkey.bind(HYPER, "m", open("Music"))
hs.hotkey.bind(HYPER, "n", open("notes"))
hs.hotkey.bind(HYPER, "o", open("Google Chrome"))
hs.hotkey.bind(HYPER, "s", open("Sublime Text"))
hs.hotkey.bind(HYPER, "w", open("wechat"))
--  HYPER, "p", open("Snipaste")

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
remapper = FRemap.new({vendorID=0x17EF, productID=0x60E1})
remapper:remap('PrintScreen', 'ralt')
remapper:register()
