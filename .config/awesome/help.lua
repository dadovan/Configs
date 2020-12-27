local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")

local help = {}

function help:init()
    local awesome = _create_widget([[<span background="orange" foreground="black">    awesome    </span>
<i>(M1: Alt, Super: Windows)</i>]],
    {
        "<i>Super</i> + <i>1..9</i>", "Switch to tag",
        "<i>Super</i> + <i>Shift</i> + <i>1..9</i>", "Add tag to current window",
        "", "",
        "<i>Super</i> + <i>`</i>", "Move window to main area",
        "<i>M1</i> + <i>Tab</i>", "Select next window",
        "<i>M1</i> + <i>Shift</i> + <i>Tab</i>", "Select prev window",
        "<i>Super</i> + <i>Control</i> + <i>j/l</i>", "Inc/dev main window size",
        "<i>Super</i> + <i>m</i>", "Maximize window",
        "<i>Super</i> + <i>f</i>", "Make window full screen",
        "", "",
        "<i>Super</i> + <i>e</i>", "Launch thunar",
        "<i>Super</i> + <i>r</i>", "Launch rofi",
        "", "",
        "<i>Super</i> + <i>Control</i> + <i>r</i>", "Reload config",
        "<i>Super</i> + <i>Shift</i> + <i>q</i>", "Exit awesome"
    })

    local tmux = _create_widget([[<span background="orange" foreground="black">    tmux    </span>
<i>(C: Control, M: Alt, S: Shift)</i>]],
    {
        "<i>M-1..0</i>", "Switch to window",
        "<i>M-S-1..0</i>", "Move pane to window",
        "<i>C-b</i>, <i>u</i>", "Select one window left",
        "<i>C-b</i>, <i>o</i>", "Select one window right",
        "<i>C-b</i>, <i>y</i>", "Select last window",
        "<i>C-b</i>, <i>-</i>", "Split window horizontally",
        "<i>C-b</i>, <i>S-\\</i>", "Split window vertically",
        "<i>C-b</i>, <i>t</i>", "Layout: main vertical",
        "<i>C-b</i>, <i>b</i>", "Layout: main horizontal",
        "<i>C-b</i>, <i>g</i>", "Layout: tiled",
        "", "",
        "<i>M-S-q</i>", "Kill the current pane",
        "<i>C-b</i>, <i>jil,</i>", "Switch pane",
        "<i>C-b</i>, <i>S-u</i>", "Make current pane large primary",
        "", "",
        "<i>C-b</i>, <i>S-r</i>", "Reload the config"
    })

    local help_widget = wibox.widget {
        homogeneous = false,
        spacing = 5,
        min_cols_size = 10,
        min_rows_size = 10,
        layout = wibox.layout.grid,
    }

    help_widget:add_widget_at(awesome, 1, 1, 1, 1)
    help_widget:add_widget_at(tmux, 1, 3, 1, 1)

    self.popup = awful.popup {
        widget = help_widget,
        border_color = '#00ff00',
        border_width = 2,
        placement    = awful.placement.centered,
        shape        = gears.shape.rounded_rect,
        visible      = false,
        ontop        = true,
    }

    self.keygrabber = function(_, key, event)
        if event == "release" and key == "Escape" then
            self:hide()
        end
    end
end

function help:show()
    if not self.popup then self.init() end

    if not self.popup.visible then
        self.popup.visible = true
        awful.keygrabber.run(self.keygrabber)
    end
end

function help:hide()
    if self.popup.visible then
        self.popup.visible = false
        awful.keygrabber.stop(self.keygrabber)
    end
end

function _create_widget(heading, values)
    local spacer_widget = wibox.widget {
        text = "    ",
        widget = wibox.widget.textbox
    }

    local heading = wibox.widget {
        markup = "\n" .. heading,
        valign = 'center',
        align = 'center',
        widget = wibox.widget.textbox
    }

    local key_markup = [[]]
    local desc_markup = [[]]
    for i = 1, #values, 2 do
        key_markup = key_markup .. values[i] .. "\n"
        desc_markup = desc_markup .. values[i + 1] .. "\n"
    end

    local key_widget = wibox.widget {
        markup = key_markup,
        valign = "top",
        widget = wibox.widget.textbox
    }

    local desc_widget = wibox.widget {
        markup = desc_markup,
        valign = "top",
        widget = wibox.widget.textbox
    }

    local widget = wibox.widget {
        homogeneous = false,
        spacing = 5,
        min_cols_size = 10,
        min_rows_size = 10,
        widget = wibox.layout.grid
    }

    widget:add_widget_at(heading, 1, 1, 1, 5)
    widget:add_widget_at(spacer_widget, 2, 1, 1, 1)
    widget:add_widget_at(key_widget, 2, 2, 1, 1)
    widget:add_widget_at(spacer_widget, 2, 3, 1, 1)
    widget:add_widget_at(desc_widget, 2, 4, 1, 1)
    widget:add_widget_at(spacer_widget, 2, 5, 1, 1)

    return widget
end

return help
