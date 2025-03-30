import QtQuick
import QtQuick.Controls
import QtQuick.Window
import Qt5Compat.GraphicalEffects
import GFile 1.2

Window {
    id: window
    visible: true
    flags: Qt.FramelessWindowHint
    width: 200
    height: 200
    color: "#00000000"
    readonly property real scale:Screen.devicePixelRatio
    readonly property real winwid:window.screen.width
    readonly property real winhei:window.screen.height
    property real num:0
    function reset(){
        fish.scale=0.8
        text_.scale=1
        text_.opacity=1
        text_.anchors.verticalCenterOffset=-30
        text_.visible=false
    }

    DragHandler {
        grabPermissions: TapHandler.CanTakeOverFromAnything
        onActiveChanged: if (active) { window.startSystemMove() }
    }
    Image{
        id:fish
        anchors.fill: parent
        scale: 0.8
        source:"qrc:/images/fish.png"
        property bool click:false
        property bool onNA:false
        NumberAnimation on scale {
            running: fish.click
            duration: 100
            to: 1.0
            onStarted: fish.onNA=true
            onStopped: fish.click=false
        }

        NumberAnimation on scale {
            running: !fish.click
            duration: 250
            easing.type: Easing.OutBack
            easing.overshoot: 1.0
            to: 0.8
            onStopped:fish.onNA=false
        }
    }
    Text{
        anchors.centerIn: parent
        anchors.verticalCenterOffset: -30
        font.pixelSize: 20
        text:"功德+1"
        visible: false
        id:text_
        NumberAnimation on scale {
            running: fish.onNA
            duration: 350
            to: 1.5
            onStopped: {
                text_.scale=1.0
                text_.visible=false
            }
            onStarted: text_.visible=true
        }
        NumberAnimation on anchors.verticalCenterOffset {
            running: fish.onNA
            duration: 350
            to: -90
            onStopped: text_.anchors.verticalCenterOffset=-30
        }
        NumberAnimation on opacity {
            running: fish.onNA
            duration: 350
            to: 0
            onStopped: text_.opacity=1
        }
    }
    Text{
        id:gd
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 80
        font.pixelSize: 20
        text:"功德:0"
        Component.onCompleted:
        {
            num=file.read_()
            text="功德:"+num
        }
    }

    MouseArea{
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton |Qt.MiddleButton
        onClicked: (mouse)=>{

                       if(mouse.button===Qt.RightButton)//如果按下右键 显示右键菜单
                       {
                           yjcd.x=mouseX+window.x
                           yjcd.y=mouseY+window.y
                           if(yjcd.y+yjcd.height>winhei) yjcd.y-=yjcd.height//如果窗口上方的高度不足以显示右键菜单，就显示在窗口下方
                           if(yjcd.x+yjcd.width>winwid) yjcd.x-=yjcd.width
                           yjcd.visible=true
                       }
                       else if(mouse.button===Qt.LeftButton)
                       {
                           if(!fish.onNA)
                           {
                               num++
                               gd.text="功德:"+num
                               file.save(num)
                               fish.click=true
                           }

                           yjcd.visible=false
                       }
                   }
    }
    GFile{
        id:file
        function save(n){
            source="./547.dll"
            write(n)
        }
        function read_(){
            source="./547.dll"
            return read()
        }
    }

    Window{//右键菜单
        id:yjcd
        flags:Qt.FramelessWindowHint|Qt.WindowStaysOnTopHint//无边框 最上层
        width: 124
        height: 204
        color: "#00000000"
        property bool pick_:false
        onActiveFocusItemChanged: {//失去焦点时隐藏
            if(!activeFocusItem)
                visible=false

        }
        Rectangle{
            anchors.fill: parent
            border.color: "#80808080"
            border.width: 2
        }
        Item
        {
            id:menu
            width: yjcd.width-4
            x:2
            y:2
            GButton{
                width: menu.width
                height: 20
                text:"关闭"
                radiusBg: 0
                toolTipText: "关闭"
                danger:true
                onClicked: Qt.quit()
            }
        }
    }
}
