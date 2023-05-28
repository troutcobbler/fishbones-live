#!/bin/bash

mkdir /home/user/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

cp -r /usr/share/hatchery/skel/. /home/user

sed -i "s/USERNAME/user/g" /home/user/.config/gtk-3.0/bookmarks

cat << EOF >> /home/user/.config/eww/eww.yuck


;;;;;;;;;;;;;;;;;
;; welcome dialog
;;;;;;;;;;;;;;;;;


;; welcome widget
(defwidget welcome-widget []
(box :orientation "v"
     :space-evenly "false"
     :spacing "5"
     :vexpand "false"
     :class "confirm-padding"
     "Welcome to hatchery Linux!"
(box :orientation "v"
     :space-evenly "false"
     :spacing "5"
     :vexpand "false"
     :class "confirm-padding"
     "Install now or explore the live-session?"
  (box :class "confirm-padding"
       :spacing "25"
    (button :class "metric"
            :onclick "eww close welcome-dialog" "LIVE")
    (button :class "metric"
            :onclick "eww close welcome-dialog && sudo calamares" "INSTALL")))))

;; welcome dialog
(defwindow welcome-dialog
  :geometry (geometry :height "120px" :width "480px" :anchor "center")
  (welcome-widget))
EOF

cat << EOF >> /home/user/.config/eww-wayland/eww.yuck


;;;;;;;;;;;;;;;;;
;; welcome dialog
;;;;;;;;;;;;;;;;;


;; welcome widget
(defwidget welcome-widget []
(box :orientation "v"
     :space-evenly "false"
     :spacing "5"
     :vexpand "false"
     :class "confirm-padding"
     "Welcome to hatchery Linux!"
(box :orientation "v"
     :space-evenly "false"
     :spacing "5"
     :vexpand "false"
     :class "confirm-padding"
     "Install now or explore the live-session?"
  (box :class "confirm-padding"
       :spacing "25"
    (button :class "metric"
            :onclick "\${eww_cmd} close welcome-dialog" "LIVE")
    (button :class "metric"
            :onclick "\${eww_cmd} close welcome-dialog && sudo calamares" "INSTALL")))))

;; welcome dialog
(defwindow welcome-dialog
  :monitor 0
  :geometry (geometry :height "120px" :width "480px" :anchor "center")
  (welcome-widget))
EOF

cat << EOF >> /home/user/.xprofile

# welcome dialog
sleep 5s && eww open welcome-dialog &
EOF

cat << EOF >> /home/user/.config/sway/config

# welcome dialog
exec sleep 5s && eww-wayland -c \$HOME/.config/eww-wayland open welcome-dialog
EOF

chown -R user:user /home/user
