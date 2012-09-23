import QtQuick 1.1
import com.nokia.meego 1.0


Page {
    id: wrapper
    anchors.fill:  parent
    anchors.topMargin: header.height
    property string pageHeader: ""
    property bool hideHeader:  false
//    orientationLock: PageOrientation.LockPortrait
/*
    Rectangle {
            color: "black"
            anchors.fill:  parent
    }
    */

    PageHeader {
        id: header
        visible: !wrapper.hideHeader
        y: -height
        z:300
        width: parent.width
        text: wrapper.pageHeader
    }
    Item {
        id: workArea
        z:200
        anchors.top:  header.bottom
        anchors.left:  parent.left
        anchors.right:  parent.right
        anchors.bottom:  parent.bottom
    }

}
