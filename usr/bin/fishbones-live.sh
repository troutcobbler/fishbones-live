#!/bin/bash

mkdir /home/user/{Desktop,Documents,Downloads,Music,Pictures,Public,Templates,Videos}

cp -r /usr/share/hatchery/skel/. /home/user

sed -i "s/USERNAME/user/g" /home/user/.config/gtk-3.0/bookmarks

sed -i '$d' /home/user/.config/quickshell/shell.qml

cat << EOF >> /home/user/.config/quickshell/shell.qml

        // Install
        PopupWindow {
            id: installPopup
            anchor.window: bar
            anchor.rect.x: screen.width / 2 - (width / 2)
            anchor.rect.y: screen.height / 2 - (height / 2)
            implicitWidth: 480
            implicitHeight: 120
            visible: true
            color: colorBg

            Text {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: 25
                color: colorFg
                font {
                    family: fontFamily
                    pixelSize: fontSize
                }
                text: "Install now or explore the live-session?"
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.bottomMargin: 15
                anchors.leftMargin: 35
                width: 190
                height: 35
                radius: 5
                color: color0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: colorFg
                    font {
                        family: fontFamily
                        pixelSize: fontSize
                    }
                    text: "LIVE"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: installPopup.visible = false
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.bottomMargin: 15
                anchors.rightMargin: 35
                width: 190
                height: 35
                radius: 5
                color: color0

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: colorFg
                    font {
                        family: fontFamily
                        pixelSize: fontSize
                    }
                    text: "INSTALL"
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        installPopup.visible = false;
                        Quickshell.execDetached(["sudo", "calamares"]);
                    }
                }
            }
        }
    }
}
EOF

chown -R user:user /home/user
