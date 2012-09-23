import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2


PageStackWindow {
    id: appWindow

    initialPage: mainPage
    showToolBar: false;
    showStatusBar: false;


    MainPage {
        id: mainPage
        onShowAbout: {
            pageStack.push(aboutPage)
        }
        onShowSettings: {
            settingsPage.latitude_current = mainPage.mapCenter.latitude;
            settingsPage.longitude_current = mainPage.mapCenter.longitude;
            settingsPage.zoom_current = mainPage.mapZoom;

            pageStack.push(settingsPage)

        }

    }

    AboutPage {
        id: aboutPage;
        onBack: {
            pageStack.pop();
        }
    }

    SettingsPage {
        id: settingsPage;
        onBack: {
            mainPage.animationSpeed = settingsPage.animationSpeed;
            mainPage.radarBufferSize = settingsPage.bufferSize;
            mainPage.radarImageOpacity = settingsPage.radarOpacity
            mainPage.usePositionIndicator = settingsPage.usegps
            pageStack.pop();
        }

        onConfigReady: {
            mainPage.mapCenter.latitude = settingsPage.latitude;
            mainPage.mapCenter.longitude = settingsPage.longitude;
            mainPage.mapZoom = settingsPage.zoom;
            mainPage.animationSpeed = settingsPage.animationSpeed;
            mainPage.radarBufferSize = settingsPage.bufferSize;
            mainPage.radarImageOpacity = settingsPage.radarOpacity
            mainPage.autostart = settingsPage.autostart
            mainPage.usePositionIndicator = settingsPage.usegps

            appWindow.showToolBar = !settingsPage.fullscreen
            appWindow.showStatusBar = !settingsPage.fullscreen
        }
    }

    /*
    Component.onCompleted: {
        theme.inverted = true;
    }
    */



}
