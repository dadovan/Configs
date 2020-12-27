local awful = require("awful")
local beautiful = require("beautiful")

local menu = {}

function menu:init()
    mainmenu = awful.menu({ items =
    {
        { "open terminal", terminal },
        { "Applications",
            {
                { "pcmanfm", "pcmanfm" },
                { "thunar", "thunar" },
                { "vlc", "vlc" }
            }
        },
        { "Restart Awesome", awesome.restart },
        { "Quit Awesome", awesome.quit }
    }})

    self.launcher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mainmenu })
end

return menu
