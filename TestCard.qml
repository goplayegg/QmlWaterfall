import QtQuick 2.0
import QtQuick.Controls 2.12

Rectangle {
    id: control
    height: 100
    color: "red"
    property alias text: txt.text
    Text {
        id: txt
        anchors.centerIn: parent
    }
    Component.onDestruction: {
        console.log("TestCard onDestruction:")
    }
}
