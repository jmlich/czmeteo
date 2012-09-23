// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2


BasePage {

    pageHeader: qsTr("Settings")
    tools: aboutPageTools

    property alias autostart: autostartCheckbox.checked
    property alias bufferSize: bufferSlider.value
    property alias animationSpeed: animationSpeedSlider.value
    property alias radarOpacity: radarOpacitySlider.value
    property alias fullscreen: fullscreenCheckbox.checked
    property alias usegps: usegpsCheckbox.checked

    property real latitude
    property real longitude
    property int zoom;

    property real latitude_current;
    property real longitude_current;
    property real zoom_current;


    signal back();
    signal configReady();


    ConfigFile {
        id: configFile;
    }

    Component.onCompleted: {
        autostartCheckbox.checked = (configFile.get("autostart","true") === "true");
        fullscreenCheckbox.checked = (configFile.get("fullscreen", "true") === "true");
        bufferSlider.value = parseInt(configFile.get("bufferSize", 10))
        animationSpeedSlider.value = parseInt(configFile.get("animationSpeed",400))
        radarOpacitySlider.value = parseFloat(configFile.get("radarOpacity", 0.5))
        latitude = parseFloat(configFile.get("latitude",49.817492))
        longitude = parseFloat(configFile.get("longitude",15.472962))
        zoom = parseInt(configFile.get("zoom",8))
        usegpsCheckbox.checked = (configFile.get("usegps","true") === "true");
        configReady();
    }

    onBack: {
        if (useCurrentPos) {
            latitude = latitude_current;
            longitude = longitude_current;
            zoom = zoom_current;
        }
        configFile.set("autostart", autostart)
        configFile.set("bufferSize", bufferSize)
        configFile.set("animationSpeed", animationSpeed)
        configFile.set("latitude", latitude)
        configFile.set("longitude", longitude)
        configFile.set("zoom", zoom)
        configFile.set("radarOpacity", radarOpacity)
        configFile.set("fullscreen", fullscreen)
        configFile.set("usegps", usegps)

    }


    Flickable {
        anchors.margins: 20
        anchors.fill: parent;
        flickableDirection: Flickable.VerticalFlick;
        contentHeight: column.height;

        Column {
            id: column;
            width: parent.width

            CheckBox {
                id: autostartCheckbox
                text: qsTr("auto start")

            }

            CheckBox {
                id: useCurrentPos
                width: parent.width
                text: qsTr("store current position")
            }

            CheckBox {
                id: fullscreenCheckbox
                width: parent.width
                text: qsTr("start in fullscreen mode")
            }

            CheckBox {
                id: usegpsCheckbox
                width: parent.width
                text: qsTr("show device position")
            }

            Label {
                text: qsTr("buffer size (hours)")
            }

            Slider {
                id: bufferSlider
                minimumValue: 5
                maximumValue: 100;
                stepSize: 1;
                value: bufferSize
                width: parent.width
                valueIndicatorText: formatBuffer(value*15)
                valueIndicatorVisible: true;
            }


            Label {
                text: qsTr("animation interval (ms)")
            }

            Slider {
                id: animationSpeedSlider;
                minimumValue: 200
                maximumValue: 2000;
                stepSize: 50;
                value: animationSpeed
                width: parent.width
                valueIndicatorVisible: true;
            }

            Label {
                text: qsTr("radar opacity (0.0 - 1.0)")
            }
            Slider {
                id: radarOpacitySlider
                minimumValue: 0.0
                maximumValue: 1.0
                stepSize: 0.05
                valueIndicatorVisible: true;
                width: parent.width
            }


        }

    }

    function formatBuffer(t) {
        var h = Math.round(t / 60)
        var m = Math.round(t % 60)
        m = (m === 0) ? "00" : m;
        return h+":"+m

    }


    ToolBarLayout {
        id: aboutPageTools
        visible: true
        MyToolIcon {
            myPlatformIconId: "toolbar-back"
            anchors.left: parent.left
            onClicked: back();
        }

    }

}
