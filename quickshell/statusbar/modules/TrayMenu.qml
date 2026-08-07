import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.SystemTray

// Tray toggle button + its popup, bundled together since the button's
// color and the popup's visibility both depend on the same state.
// Usage: TrayMenu { barWindow: bar }  -- pass in the PanelWindow to anchor to.
Item {
    id: root

    required property var barWindow

    width: trayToggle.implicitWidth
    height: trayToggle.implicitHeight

    Text {
        id: trayToggle
        color: trayPopup.visible ? "#fabd2f" : "#ebdbb2"
        font.family: "JetBrainsMono Nerd Font"
        font.pixelSize: 14
        text: "󰍜 " // Drawer/Menu Icon

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: trayPopup.visible = !trayPopup.visible
        }
    }

    PopupWindow {
        id: trayPopup
        anchor.window: root.barWindow
        anchor.rect.x: root.barWindow.width - width - 10
        anchor.rect.y: root.barWindow.height + 4
        visible: false
        color: "transparent"

        Connections {
            target: Hyprland
            function onFocusedWindowChanged() {
                trayPopup.visible = false;
            }
        }

        Rectangle {
            width: trayRow.implicitWidth + 16
            height: 36
            color: "#282828"
            border.color: "#3c3836"
            border.width: 1
            radius: 6

            Row {
                id: trayRow
                anchors.centerIn: parent
                spacing: 8

                Text {
                    visible: SystemTray.items.length === 0
                    text: "No active applets"
                    color: "#928374"
                    font.family: "JetBrainsMono Nerd Font"
                    font.pixelSize: 11
                }

                Repeater {
                    model: SystemTray.items
                    Image {
                        width: 20
                        height: 20
                        source: modelData.icon
                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            onClicked: (mouse) => {
                                if (mouse.button === Qt.RightButton) {
                                    modelData.displayMenu();
                                } else {
                                    modelData.activate();
                                }
                                trayPopup.visible = false;
                            }
                        }
                    }
                }
            }
        }
    }
}
