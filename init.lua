hyperKey = { "shift", "ctrl", "cmd", "option" }

-- reload config
hs.hotkey.bind(hyperKey, "R", function()
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

hs.hotkey.bind(hyperKey, "c", open("Visual Studio Code"))
hs.hotkey.bind(hyperKey, "i", open("iTerm"))
hs.hotkey.bind(hyperKey, "j", open("IntelliJ IDEA"))
hs.hotkey.bind(hyperKey, "k", open("slack"))
hs.hotkey.bind(hyperKey, "n", open("notes"))
hs.hotkey.bind(hyperKey, "o", open("Google Chrome"))
hs.hotkey.bind(hyperKey, "z", open("zoom.us"))

-- remap
local function pressFn(mods, key)
    if key == nil then
        key = mods
        mods = {}
    end

    return function()
        hs.eventtap.keyStroke(mods, key, 1000)
    end
end

local function remap(mods, key, pressFn)
    hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end

remap({ 'ctrl' }, 'h', pressFn('left'))
remap({ 'ctrl' }, 'j', pressFn('down'))
remap({ 'ctrl' }, 'k', pressFn('up'))
remap({ 'ctrl' }, 'l', pressFn('right'))
remap({ 'ctrl', 'alt' }, 'l', pressFn('alt', 'right')) -- word-wise moving
remap({ 'ctrl', 'alt' }, 'h', pressFn('alt', 'left'))


-- Credit for this implementation goes to @arbelt and @jasoncodes 🙇⚡️😻

--   https://gist.github.com/arbelt/b91e1f38a0880afb316dd5b5732759f1
--   https://github.com/jasoncodes/dotfiles/blob/ac9f3ac/hammerspoon/control_escape.lua

send_escape = false
last_mods = {}

control_key_handler = function()
    send_escape = false
end

control_key_timer = hs.timer.delayed.new(0.12, control_key_handler)

control_handler = function(evt)
    local new_mods = evt:getFlags()
    if last_mods["ctrl"] == new_mods["ctrl"] then
        return false
    end
    if not last_mods["ctrl"] then
        last_mods = new_mods
        send_escape = true
        control_key_timer:start()
    else
        if send_escape then
            hs.eventtap.keyStroke({}, "ESCAPE")
        end
        last_mods = new_mods
        control_key_timer:stop()
    end
    return false
end

control_tap = hs.eventtap.new({ hs.eventtap.event.types.flagsChanged }, control_handler)
control_tap:start()

other_handler = function(evt)
    send_escape = false
    return false
end

other_tap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, other_handler)
other_tap:start()

-- from: https://github.com/hetima/hammerspoon-foundation_remapping
-- remap printscreen key to right option key
local FRemap = require('foundation_remapping')
remapper = FRemap.new({ vendorID = 0x17ef, productID = 0x60ee })
remapper:remap('PrintScreen', 'ralt')
remapper:register()
