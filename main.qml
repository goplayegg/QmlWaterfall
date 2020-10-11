import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Qml Waterfall")

    ScrollView {
        id: scroll
        anchors.fill: parent
        Waterfall {
            id: wf
            width: parent.width
            cardWidth: 140
            model: ListModel {
                id: md
            }
            delegate: TestCard{
                height: model.h
                color: model.c
                text: model.index
            }
        }
    }

    Button {
        text: md.count === 0? "add":"clear"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onClicked: {
            if(md.count !== 0)
                wf.clear()//call item.clear(), dont call model.clear()
            else
                appendCard(30)
        }
    }

    Connections {
        target: scroll.ScrollBar.vertical
        function onPositionChanged() {
            if(0.99 < target.position+target.size){
                console.log("scrollbar position:"+ target.position)
                appendCard(10)
            }
        }
        function onSizeChanged() {
            if(1.0 === target.size){
                console.log("scrollbar size:"+ target.size)
                appendCard(30)
            }
        }
    }

    property var colors: ["red","green", "blue","yellow","gray","pink"]
    function appendCard(num){
        if(wf.reLayouting){
            console.warn("waterfall is reLayouting, ignore append num:"+ num)
            return
        }
        for(var i=0;i<num;++i){
            md.append({h: rand(30, 300), c: colors[rand(0,colors.length-1)]})
        }
    }

    function rand(minNum, maxNum){
        return parseInt(Math.random() * (maxNum - minNum + 1) + minNum, 10);
    }
}
