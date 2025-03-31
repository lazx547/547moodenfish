import QtQuick
import QtQuick.Controls
import QtQuick.Window

Item{
    id:pickerItem
    property real value:slider.value
    property real maxValue:100
    property real minValue:0
    property string text
    property real step:0.01
    onTextChanged: text_.text=text
    function setValue(vl){
        slider.x = Math.max(0,vl*(pickerItem_.width-slider.width))
    }

    Text{
        id:text_
        text:text
        font.pixelSize: 14
        y:-2
    }
    GButton{
        x:10
        radiusBg:0
        width: 10
        height: 15
        text:"<"
        font.pixelSize: 10
        padding: 0
        topPadding: 0
        bottomPadding: 0
        onClicked: setValue(value-step)
        toolTipText: "减小"
    }
    GButton{
        id:bur
        x:90
        radiusBg:0
        width: 10
        height: 15
        text:">"
        font.pixelSize: 10
        padding: 0
        topPadding: 0
        bottomPadding: 0
        onClicked: setValue(value+step)
        toolTipText: "增加"
    }
    Item {
        id: pickerItem_
        width: 70
        height: 15
        x:20
        y:0
        Rectangle {
            anchors.fill: parent
            border.color: "#80808080"
            border.width: 2
            ToolTip.visible: false
        }
        Rectangle {
            id: slider
            x: parent.width - width
            width: height
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            border.color: pickerItem_.down ? "#1677ff" : pickerItem_.hovered ? "#69b1ff" : "#80808080";
            border.width: 2
            scale: 0.9
            property real value: x / (pickerItem_.width - width)
        }

        MouseArea {
            anchors.fill: parent

            function handleCursorPos(x) {
                let halfWidth = slider.width * 0.5;
                slider.x = Math.max(0, Math.min(width, x + halfWidth) - slider.width);
            }
            onPressed: (mouse) => {
                           handleCursorPos(mouse.x, mouse.y);
                       }
            onPositionChanged: (mouse) => handleCursorPos(mouse.x);
        }
    }
    Rectangle{
        id:shvr
        x:100
        y:0
        z:-1
        width: 20
        height: 15
        color:Qt.rgba(0.8,0.8,0.8)
        Text{
            anchors.fill: parent
            id:vr
            text:(slider.value * (maxValue-minValue)).toFixed(0)
            font.pixelSize: 12
            horizontalAlignment:Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
