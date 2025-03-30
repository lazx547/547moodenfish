import QtQuick
import QtQuick.Controls
import QtQuick.Controls.Basic

Button {
    id: control
    property int radiusBg: 6
    property color colorText:enabled?(control.hovered?(danger? (control.down ? "#ff1600" : "#FF7070") : (control.down ? "#1677ff" : "#4096ff")):"#000000"):Qt.rgba(0,0,0,0.45)
    property color colorBg: {
        if (enabled)
                return control.down ? "#ffffff" : control.hovered ? "#ffffff" : "#00ffffff";
        else return Qt.rgba(0,0,0,0.45);
    }
    property color colorBorder: enabled?(control.hovered?(danger? (control.down ? "#ff1600" : "#FF7070") : (control.down ? "#1677ff" : "#4096ff")):"#000000"):Qt.rgba(0,0,0,0.45)
    property string contentDescription: text
    property string toolTipText
    property bool danger:false

    width: implicitContentWidth + leftPadding + rightPadding
    height: implicitContentHeight + topPadding + bottomPadding
    padding: 4
    topPadding: 2
    bottomPadding: 2
    font {
        family: "微软雅黑"
        pixelSize: 16
    }
    contentItem: Text {
        text: control.text
        font: control.font
        color: control.colorText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
    background: Item {
        Rectangle {
            id: __bg
            width: realWidth
            height: realHeight
            anchors.centerIn: parent
            radius:control.radiusBg
            color: control.colorBg
            border.width: 1
            border.color: control.enabled ? control.colorBorder : "transparent"

            property real realWidth: parent.width
            property real realHeight: parent.height
        }
    }
    Accessible.role: Accessible.Button
    Accessible.name: control.text
    Accessible.description: contentDescription
    Accessible.onPressAction: control.clicked();
    ToolTip{
        id:tooltip
        background: Rectangle{
            color: "white"
            anchors.fill: parent
            border.color: "black"
        }
        delay: 1000
        timeout: 10000
        visible: hovered
        contentItem: Text{
            text: toolTipText
            font.pixelSize: 12
        }
    }
}
