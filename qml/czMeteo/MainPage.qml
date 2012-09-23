import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2
import QtMobility.sensors 1.2


Page {
    id: mainPage
    tools: commonTools
    //orientationLock: PageOrientation.LockLandscape // FIXME
    signal showAbout();
    signal showSettings();

    property alias mapCenter: myMap.center
    property alias mapZoom: myMap.zoomLevel
    property alias animationSpeed: playLoop.interval
    property alias autostart: playLoop.running
    property alias radarBufferSize: radarImage.imagesMax
    property alias radarImageOpacity: radarImage.opacity


    ToolBarLayout {
        id: commonTools
        visible: true

        ToolIcon {
            platformIconId: "icon-m-toolbar-previous"
            onClicked: {
                radarImage.previousImage();
            }
        }

        ToolIcon {
            platformIconId: playLoop.running ? "icon-m-toolbar-mediacontrol-pause" : "icon-m-toolbar-mediacontrol-play"
            onClicked: {
                playLoop.running = !playLoop.running;
            }
        }

        ToolIcon {
            platformIconId: "icon-m-toolbar-next"
            onClicked: {
                radarImage.nextImage();
            }
        }

        ToolIcon {
            platformIconId: "toolbar-view-menu"
            onClicked: (myMenu.status === DialogStatus.Closed) ? myMenu.open() : myMenu.close()
        }

    }

    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: qsTr("Settings");
                onClicked: { showSettings(); }
            }
            MenuItem {
                text: qsTr("About");
                onClicked: { showAbout(); }
            }
        }
    }



    Map {
        z: 1
        id: myMap;
        anchors.fill: parent;
        plugin: Plugin {
            name : "nokia"
            PluginParameter { name: "app_id"; value: "MRX7ur8DHd7vB8JZPcoc" }
            PluginParameter { name: "token"; value: "DiXilnCAUjo5I2_IeAEKNQ" }
        }
        connectivityMode: Map.HybridMode;
        center: Coordinate { }

        //        zoomLevel: mapZoom;

        onCenterChanged: {
            updateRadarPos();
        }
        onZoomLevelChanged: {
            updateRadarPos();
        }
    }


    PinchArea {
        id: pincharea

        property double __oldZoom

        anchors.top: parent.top;
        anchors.bottom: imagesCache.top;
        anchors.left: parent.left;
        anchors.right: parent.right;


        function calcZoomDelta(zoom, percent) {
            return zoom + Math.log(percent)/Math.log(2)
        }

        onPinchStarted: {
            __oldZoom = myMap.zoomLevel
        }

        onPinchUpdated: {
            myMap.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
        }

        onPinchFinished: {
            myMap.zoomLevel = calcZoomDelta(__oldZoom, pinch.scale)
        }
    }


    MouseArea {
        preventStealing: true;
        id: mousearea

        property int __panDistance: 0
        property bool __isPanning: false
        property int __lastX: -1
        property int __lastY: -1

        anchors.top: parent.top;
        anchors.bottom: imagesCache.top;
        anchors.left: parent.left;
        anchors.right: parent.right;


        onClicked: {

            if (__panDistance > 10) {
                return;
            }

            appWindow.showStatusBar = !appWindow.showStatusBar
            appWindow.showToolBar = !appWindow.showToolBar
            updateRadarPos(); // FIXME: v tehle chvili se pusti animace na schovani, takze se nespocita dobre;

        }

        onPressed: {
            __panDistance = 0;
            __isPanning = true
            __lastX = mouse.x
            __lastY = mouse.y
        }

        onReleased: {
            __isPanning = false
        }

        onPositionChanged: {
            if (__isPanning) {
                var dx = mouse.x - __lastX
                var dy = mouse.y - __lastY

                __panDistance = __panDistance + Math.abs(dx) + Math.abs(dy);
                myMap.pan(-dx, -dy)
                __lastX = mouse.x
                __lastY = mouse.y
            }
        }

        onCanceled: {
            __isPanning = false;
        }
    }

    RadarData {
        id: radarImage;
        z: 2
        visible: (mainPage.status === PageStatus.Active)
    }


    Repeater {
        id: imagesCache
        model: radarImage.dataListModel;

        anchors.bottom: parent.bottom;
        anchors.left: parent.left;
        anchors.right: parent.right;
        height: 20;

        delegate: Item {
            z: radarImage.z + 1
            anchors.fill: parent;

            Image {
                // cached image
                id: currentImage
                source: model.url;
                visible: false;
                onStatusChanged: {
                    if (status === Image.Error) {
                        var s = source;
                        //                        source = ""; source = s;
                    }
                }
            }
            Rectangle {
                // progressbar
                id: imagesCacheItem
                x: (radarImage.imagesMax-model.index-1)*width

                anchors.bottom: parent.bottom
                width: mainPage.width/radarImage.dataListModel.count;
                height: imagesCache.height;
                //  color: "red"
                opacity: 0.2
                visible: (currentImage.status !== Image.Ready)
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "red"; }
                    GradientStop { position: 1.0; color: Qt.darker("red"); }
                }
            }
            MouseArea {
                anchors.fill: imagesCacheItem
                onClicked: {
                    radarImage.imagesSelected = model.index;
                }
            }
        }
    }

    Rectangle {
        id: positionIndicator;
        width: mainPage.width/radarImage.dataListModel.count;
        height: 20;
        x: (radarImage.imagesMax-radarImage.imagesSelected-1)*width
        z: imagesCache.z + 1
        anchors.bottom: parent.bottom
        //color: "blue"
        opacity: 0.5

        gradient: Gradient {
            GradientStop { position: 0.0; color: "blue"; }
            GradientStop { position: 1.0; color: Qt.darker("blue"); }
        }


    }



    BusyIndicator {
        z: 5
        anchors.centerIn: parent;
        visible: (radarImage.status !== Image.Ready)
        running: visible;
        platformStyle: BusyIndicatorStyle { size: "large" }

    }

    Coordinate {
        id: radarTopLeft
        latitude: 51.345786;
        longitude: 11.284418;
    }

    Coordinate {
        id: radarBottomRight;
        latitude: 48.05766
        longitude: 19.621754
    }

/*
    Coordinate {
        id: radarTopLeft
        latitude: 69.869892;
        longitude: -13.161621;
    }

    Coordinate {
        id: radarBottomRight;
        latitude: 34.261757;
        longitude: 31.574707;
    }
*/
    Component.onCompleted: {
        updateRadarPos();
    }

    function updateRadarPos() {
        var p1 = myMap.toScreenPosition(radarTopLeft)
        var p2 = myMap.toScreenPosition(radarBottomRight)
        radarImage.x = p1.x
        radarImage.y = p1.y;
        radarImage.width = p2.x-p1.x
        radarImage.height = p2.y-p1.y
        updateMyPos();
    }


    Label {
        z: 3
        anchors.top: parent.top;
        anchors.right: parent.right;
        anchors.margins: 5;
        text: radarImage.timeString;
        color: "#a40000"
        font.bold: true;
    }

    Timer {
        id:  playLoop;
        interval: 400;
        repeat: true;
        running: false;
        onTriggered: {
            radarImage.nextImage();
        }

    }

    onHeightChanged: {
        updateRadarPos();
    }


    function updateMyPos() {
        var p = myMap.toScreenPosition(positionSource.position.coordinate);
        myPositionImage.x = p.x - 23 // origin
        myPositionImage.y = p.y - 64

    }

    property bool usePositionIndicator: false;

    Image {
        id: myPositionImage;
        source: "./images/position.png"
        x: 10;
        y: 10;
        z: radarImage.z+1
        transform: Rotation { origin.x: 23; origin.y: 64; angle: deltaAngle + compassAzimuth }
        visible: usePositionIndicator

    }

    PositionSource {
        id: positionSource;
        active: usePositionIndicator;
        updateInterval: 1000
        onPositionChanged: {
            updateMyPos();
        }
    }

    property real compassAzimuth: 0

    Compass {
        id: compass
        active: usePositionIndicator;
        onReadingChanged: {
            compassAzimuth = reading.azimuth;
        }
    }

    property real deltaAngle: 0

    OrientationSensor {
        id: orientationSensor
        active: usePositionIndicator;
        onReadingChanged: {
            if (reading.orientation === OrientationReading.RightUp) {
                deltaAngle = 90;
            }
            if (reading.orientation === OrientationReading.TopUp) {
                deltaAngle = 0;
            }
        }
    }

}
