// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

Item {

    /**
      * Odriznuti histogramu z o vysce a sirce 81 z srazkoveho obrazku
      */

    Image {
        id: image;
        z: parent.z + 1

        x: - clipLeftReal
        y: - clipTopReal
        width: parent.width + clipLeftReal + clipRightReal;
        height: parent.height + clipTopReal + clipBottomtReal;

        property real clipLeft: 1
        property real clipRight: 82
        property real clipTop: 95
        property real clipBottom: 1

        property real clipLeftReal: (clipLeft / (sourceSize.width  - (clipLeft + clipRight) ) ) * parent.width
        property real clipTopReal:  (clipTop  / (sourceSize.height - (clipTop + clipBottom) ) ) * parent.height
        property real clipRightReal: ((clipRight / (sourceSize.width - (clipLeft + clipRight) )) * parent.width)
        property real clipBottomtReal: ((clipBottom / (sourceSize.height -(clipTop +clipBottom) ))  * parent.height)

//        property real topHistHeight: histHeight/(460-histHeight) * parent.height;



        function toImageWidth(w) {
            if (status !== Image.Ready) {
                return w;
            }
            return w/(sourceSize.width-w) * parent.width
        }
        function toImageHeight(h) {
            if (status !== Image.Ready) {
                return h;
            }
            return h/(sourceSize.height-h) * parent.height
        }

    }

    property alias source: image.source
    property alias status: image.status


    clip: true;

}
