import QtQuick 1.0

Rectangle {
   id: headerRectangle
   property alias text: headerText.text
   property bool hide: false

   width: parent.width
   height: hide ? 0 : 72
/*
   anchors.top: parent.top
   anchors.left: parent.left
   anchors.right: parent.right
*/
   color: "#ff00a8e6";
   z: 5


   Text {
       id: headerText

       anchors.left: parent.left
       anchors.leftMargin: 12
       anchors.verticalCenter: parent.verticalCenter

       color: "white"
       text: ""
       font.pixelSize: 34
   }
}
