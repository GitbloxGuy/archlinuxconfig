import QtQuick 2.15
import SddmComponents 2.0

Rectangle {
    width: 1920
    height: 1080
    color: "#282828"
    Image {
	id: background
	anchors.fill: parent
	source: config.background
	fillMode: Image.PreseveAspectCrop
    }

    Column {
        anchors.centerIn: parent
        spacing: 16

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: " "
            color: "#ebdbb2"
            font.pixelSize: 28
            font.family: "JetBrainsMono Nerd Font"
        }

        TextInput {
            id: username
            width: 240
            height: 40
	    text: userModel.lastUser
	    color: "#ebdbb2"
	    font.family: "JetBrainsMono Nerd Font"

	    


	    KeyNavigation.tab: password
	    Keys.onReturnPressed: password.forceActiveFocus()
        }

        TextInput {
            id: password
            width: 240
	    height: 40
            color: "#ebdbb2"
            echoMode: TextInput.Password
	    font.family: "JetBrainsMono Nerd Font"
	    focus: true

            Keys.onReturnPressed: sddm.login(username.text, password.text, sessionModel.Index)
        }

ComboBox {
    id: session
    width: 240
    height: 40
    model: sessionModel
    index: sessionModel.lastIndex
    font.family: "JetBrainsMono Nerd Font"
    color: "transparent"
    menuColor: "transparent"
    borderWidth: 0
    textColor: "#ebdbb2"
    hoverColor: "#3c3836"
    arrowColor: "transparent"
    }
}}
