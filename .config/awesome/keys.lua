local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")

local help = require("help")
help:init()

local keys = {}

function _launch_rofi()
    awful.spawn.with_shell('rofi -combi-modi window,drun,shell -modi combi -show combi -show-icons')
end

function _launch_thunar()
    awful.spawn.with_shell('thunar')
end

function keys:init()
    -- Help with keys: https://superuser.com/a/1255946
    globalkeys = gears.table.join(
        awful.key({ modkey }, "/", function(t) help:show() end, {description="show help", group="awesome"}),
        awful.key({ modkey, "Shift" }, "/", hotkeys_popup.show_help, {description="show help", group="awesome"}),

        awful.key({ "Mod1" }, "Tab", function () awful.client.focus.byidx(1) end, {description = "focus next by index", group = "client"}),
        awful.key({ "Mod1", "Shift" }, "Tab", function () awful.client.focus.byidx(-1) end, {description = "focus previous by index", group = "client"}),

        awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
                {description = "open a terminal", group = "launcher"}),
        awful.key({ modkey, "Control" }, "r", awesome.restart,
                {description = "reload awesome", group = "awesome"}),
        awful.key({ modkey, "Shift"   }, "q", awesome.quit,
                {description = "quit awesome", group = "awesome"}),

        awful.key({ modkey, "Control" }, "l",     function () awful.tag.incmwfact( 0.05)          end,
                {description = "increase master width factor", group = "layout"}),
        awful.key({ modkey, "Control" }, "j",     function () awful.tag.incmwfact(-0.05)          end,
                {description = "decrease master width factor", group = "layout"}),

        awful.key({ modkey }, "r", _launch_rofi, {description = "launch rofi", group = "launcher"}),
        awful.key({ modkey }, "e", _launch_thunar, {description = "launch thunar", group = "launcher"})
    )

    clientkeys = gears.table.join(
        awful.key({ modkey, "Shift" }, "c", function (c) c:kill() end, {description = "close", group = "client"}),
        awful.key({ modkey }, "f",
            function (c)
                c.fullscreen = not c.fullscreen
                c:raise()
            end,
            {description = "toggle fullscreen", group = "client"}),
        awful.key({ modkey }, "`", function (c) c:swap(awful.client.getmaster()) end, {description = "move to master", group = "client"}),
        awful.key({ modkey }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end,
            {description = "(un)maximize", group = "client"}),
        awful.key({ modkey, }, "t", function (c) c.ontop = not c.ontop end, {description = "toggle keep on top", group = "client"})
    )

    -- Bind all key numbers to tags.
    -- Be careful: we use keycodes to make it work on any keyboard layout.
    -- This should map on the top row of your keyboard, usually 1 to 9.
    for i = 1, 9 do
        globalkeys = gears.table.join(globalkeys,
            -- View tag only.
            awful.key({ modkey }, "#" .. i + 9,
                    function ()
                            local screen = awful.screen.focused()
                            local tag = screen.tags[i]
                            if tag then
                            tag:view_only()
                            end
                    end,
                    {description = "view tag #"..i, group = "tag"}),
            -- Move client to tag.
            awful.key({ modkey, "Shift" }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:move_to_tag(tag)
                                tag:view_only()
                            end
                        end
                    end,
                    {description = "move focused client to tag #"..i, group = "tag"}),
            -- Toggle tag on focused client.
            awful.key({ modkey, "Control" }, "#" .. i + 9,
                    function ()
                        if client.focus then
                            local tag = client.focus.screen.tags[i]
                            if tag then
                                client.focus:toggle_tag(tag)
                                tag:view_only()
                            end
                        end
                    end,
                    {description = "toggle focused client on tag #" .. i, group = "tag"})
        )
    end

    self.globalkeys = globalkeys
    self.clientkeys = clientkeys
end

return keys
