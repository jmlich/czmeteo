// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import com.nokia.meego 1.0

BasePage {

    pageHeader: qsTr("About")
    tools: aboutPageTools

    signal back();


    ToolBarLayout {
        id: aboutPageTools
        visible: true
        MyToolIcon {
            myPlatformIconId: "toolbar-back"
            anchors.left: parent.left
            onClicked: back();
        }
    }

    Flickable {
        anchors.margins: 20;

        anchors.fill: parent;
        contentHeight: nadpis.height + authors.height + appIcon.height + contrib.height + licence.height + 120;

        Image {
            id: appIcon
            source:"./images/czMeteo80.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top;
            anchors.margins: 20;
        }


        Label {
            id: nadpis
            anchors.top: appIcon.bottom;
            anchors.horizontalCenter: parent.horizontalCenter;
            anchors.margins: 20;
            font.pixelSize: 60;
            font.family: "Helvetica"
            font.bold: true;
            text: "czMeteo"
            wrapMode: Text.Wrap
        }


        Label {
            id: authors
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: nadpis.bottom;
            anchors.margins: 20;

            text: "(c) Jozef Mlích 2012"
            textFormat: Text.RichText
            wrapMode: Text.Wrap
        }


        Label {
            id: contrib
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: authors.bottom;
            anchors.margins: 20;
            width: parent.width;

            //text: qsTr("The radar echoes and lightning detection are the exclusive property of the bellow meteorological institutions. Application is for personal and non-commercial use. <br/><br/>Czech Hydrometeorological Institute - <a href=\"http://www.chmi.cz\">http://www.chmi.cz</a> <br/><br/>Slovak Hydrometeorological Institute - <a href=\"http://www.shmu.sk\">http://www.shmu.sk</a> <br/><br/>Institut für Wetter- und Klimakommunikation GmbH - <a href=\"http://www.wetterspiegel.de\">http://www.wetterspiegel.de</a> <br/><br/>Institute of Meteorology and Water Management - National Research Institute in Poland - <a href=\"http://www.pogodynka.pl\">http://www.pogodynka.pl</a> <br/><br/>Meteo France - <a href=\"http://www.meteofrance.com\">http://www.meteofrance.com</a> <br/><br/>Agencia Estatal de Meteorología - <a href=\"http://www.aemet.es\">http://www.aemet.es</a> <br/><br/>Met Office - <a href=\"http://www.metoffice.gov.uk\">www.metoffice.gov.uk</a> <br/><br/>NATIONAL METEOROLOGICAL ADMINISTRATION Meteo Romania - <a href=\"http://www.meteoromania.ro\">http://www.meteoromania.ro</a> <br/><br/>Swedish Meteorological and Hydrological Institute - <a href=\"http://www.smhi.se\">http://www.smhi.se</a> <br/><br/>Blitzortung.org - <a href=\"http://www.blitzortung.org\">http://www.blitzortung.org</a> <br/><br/> <a href=\"http://www.radareu.cz\">http://radareu.cz</a>");
            text: qsTr("The radar echoes and lightning detection are the exclusive property of the bellow meteorological institutions. Application is for personal and non-commercial use. <br/><br/>Czech Hydrometeorological Institute - <a href=\"http://www.chmi.cz\">http://www.chmi.cz</a> ");

            textFormat: Text.RichText
            onLinkActivated: Qt.openUrlExternally(link);
            wrapMode: Text.Wrap
        }



        Label {
            id: licence;
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: contrib.bottom;
            width: parent.width
            anchors.margins: 20;
            textFormat: Text.RichText
            font.pixelSize: 18
            // <style type='text/css'>a:link{color:#FFFF00} a:visited{color:#00FFFF}</style>
            text: qsTr("<u>Licence</u><br/> <br/> This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. <br/> <br/> This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details. <br/> <br/>You should have received a copy of the GNU General Public License along with this program.  If not, see &lt;<a href=\"http://www.gnu.org/licenses/\">http://www.gnu.org/licenses</a>&gt;.")
            onLinkActivated: {
                Qt.openUrlExternally(link);
            }
            wrapMode: Text.Wrap
        }
    }



}
