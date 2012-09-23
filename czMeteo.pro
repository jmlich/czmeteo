# Add more folders to ship with the application, here
folder_01.source = qml/czMeteo
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =


symbian {
        TARGET = "czmeteo_20061491"
        TARGET.UID3 = 0x20061491
        ICON = "czMeteo.svg"
        VERSION = 0.0.1
        DEPLOYMENT.display_name = czMeteo
        TARGET.CAPABILITY += NetworkServices Location
#        TARGET.CAPABILITY += SwEvent
        # workaround: http://bugreports.qt.nokia.com/browse/QTBUG-8336
        vendorinfo += "%{\"xmlich02\"}" ":\"xmlich02\""
        my_deployment.pkg_prerules += vendorinfo

        my_deployment.pkg_prerules += \
                "; Dependency to Symbian Qt Quick components" \
                "(0x200346DE), 1, 0, 0, {\"Qt Quick components\"}"

        DEPLOYMENT += my_deployment
}


# If your application uses the Qt Mobility libraries, uncomment the following
# lines and add the respective components to the MOBILITY variable.
CONFIG += mobility
MOBILITY += location sensors

# Speed up launching on MeeGo/Harmattan when using applauncherd daemon
CONFIG += qdeclarative-boostable

# Add dependency to Symbian components
CONFIG += qt-components

symbian:DEPLOYMENT.installer_header = 0x2002CCCF


# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    dateformater.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

OTHER_FILES += \
    qtc_packaging/debian_harmattan/rules \
    qtc_packaging/debian_harmattan/README \
    qtc_packaging/debian_harmattan/manifest.aegis \
    qtc_packaging/debian_harmattan/copyright \
    qtc_packaging/debian_harmattan/control \
    qtc_packaging/debian_harmattan/compat \
    qtc_packaging/debian_harmattan/changelog

TRANSLATIONS += czMeteo_cs_CZ.ts

CODECFORTR = UTF-8
CODECFORSRC = UTF-8

RESOURCES += \
    czMeteo.qrc

HEADERS += \
    dateformater.h

data.files = czMeteo_splash_landscape.png \
     czMeteo_splash.png
data.path = /opt/czMeteo/share

INSTALLS += data
