#!/bin/bash

mkdir /home/user/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

cp -r /usr/share/hatchery/skel/. /home/user

sed -i "s/USERNAME/user/g" /home/user/.config/gtk-3.0/bookmarks

cat << EOF >> /home/user/.config/awesome/rc.lua

-- Install popup widgets
install_cancel = wibox.widget {
    text   = "LIVE",
    align = "center",
    halign = "center",
    widget = wibox.widget.textbox,
}

install_yes = wibox.widget {
    text   = "INSTALL",
    align = "center",
    halign = "center",
    widget = wibox.widget.textbox,
}

-- Install popup
install = awful.popup {
    widget = {
        {
            {
                widget = wibox.container.margin,
                margins = 20,
                {
                    {
                        widget = wibox.container.margin,
                        margins = 20,
                        {
                            text   = 'Welcome to hatchery Linux!',
                            align = "center",
                            halign = "center",
                            widget = wibox.widget.textbox
                        },
                    },
                    {
                        text   = 'Install now or explore the live-session?',
                        align = "center",
                        halign = "center",
                        widget = wibox.widget.textbox
                    },
                    layout = wibox.layout.fixed.vertical,
                },
            },
            {
                {
                    top = 4,
                    bottom = 4,
                    left = 22,
                    right = 12,
                    widget = wibox.container.margin,
                    {
                        bg     = color0,
                        shape = bubble,
                        widget = wibox.container.background,
                        {
                            margins = 5,
                            widget = wibox.container.margin,
                            {
                                widget = install_cancel,
                            },
                        },
                    },
                },
                {
                    top = 4,
                    bottom = 4,
                    left = 12, 
                    right = 22,
                    widget = wibox.container.margin,
                    {
                        bg     = color0,
                        shape = bubble,
                        widget = wibox.container.background,
                        {
                            margins = 5,
                            widget = wibox.container.margin,
                            {
                                widget = install_yes,
                            },
                        },
                    },
                },
                layout = wibox.layout.flex.horizontal,
            },
            layout = wibox.layout.fixed.vertical,
        },
        margins = 10,
        widget  = wibox.container.margin
    },
    placement    = awful.placement.centered,
    ontop        = true,
    visible      = true,
    minimum_width = 480,
    minimum_height = 120,
    screen = awful.screen.focused()
}

-- Install popup functions
install_cancel:connect_signal("button::release", function(self)
    install.visible = false
end)

install_yes:connect_signal("button::release", function(self)
    install.visible = false
    awful.spawn.easy_async("sudo calamares", function() end)
end)
EOF

chown -R user:user /home/user
