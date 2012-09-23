// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import cz.vutbr.fit.pcmlich 1.0

RadarImage {

    property int imagesSelected;
    property int imagesMax: 9;
    property string timeString: "";
    property bool imagesLoop: true;

    property ListModel dataListModel: radImages

    ListModel {
        id: radImages;
    }
    onImagesSelectedChanged: {
        if (imagesSelected >= radImages.count) {
            return;
        }

        source = radImages.get(imagesSelected).url;
        timeString = formater.toLocaleString(radImages.get(imagesSelected).time );

        //        var d = new Date(radImages.get(imagesSelected).time * 1000);
        //        timeString = d.toLocaleString(Qt.locale("cs_CZ"))
    }

    function previousImage() {
        if (imagesSelected < imagesMax) {
            imagesSelected++;
        } else if (imagesLoop) {
            imagesSelected = 0
        }
    }
    function nextImage() {
        if (imagesSelected > 0) {
            imagesSelected--;
        } else if (imagesLoop) {
            imagesSelected = imagesMax-1;
        }
    }

    Component.onCompleted: {
        updateImagesList()
    }

    onImagesMaxChanged: {
        updateImagesList();
    }

//    property int quater: 900 // 15 minutes
  property int quater: 600 // 10*60 // 10 minutes

    function updateImagesList() {
        var now = new Date().getTime()/1000 - 300; // radarove data nejsou dostupne hned
        var r = roundQuater(now)

        radImages.clear();
        for (var i = 0; i < imagesMax; i++) { // 350
            var url = dateToUrl(r)
            radImages.append({'time': r, 'url': url})

            r -= quater
        }

        //imagesSelected = 1; imagesSelected = 0;
        imagesSelected = imagesMax-1;

    }

    function roundQuater(now) {
        var d = new Date(now*1000);
        var d2 = new Date(d.getFullYear(), d.getMonth(), d.getDate(), d.getHours(), 0, 0, 0);
        var ts2 = d2.getTime()/1000;

        while (ts2 < now) {
            ts2 += quater;
        }
        ts2 -= quater;
        //        d2 = new Date (ts2*1000)

        return ts2;
    }

    //"http://www.chmi.cz/files/portal/docs/meteo/rad/inca-cz/data/czrad-z_max3d/pacz2gmaps3.z_max3d.20120522.0220.0.png"
    //"http://www.chmi.cz/files/portal/docs/meteo/rad/data_tr_png_1km/pacz23.z_max3d.20120512.1530.0.png"
    //"http://radar.bourky.cz/data/pacz2gmaps.z_max3d.20120512.1615.0.png"
    // http://www.radareu.cz/data/radar/radar.anim.20120813.1230.0.png
    // http://www.radareu.cz/mobile/data/radar/radar.anim.20120813.2015.0.png
    function dateToUrl(r) {
        var d = new Date(r*1000)
//        return "http://radar.bourky.cz/data/pacz2gmaps.z_max3d."
        return "http://www.chmi.cz/files/portal/docs/meteo/rad/inca-cz/data/czrad-z_max3d/pacz2gmaps3.z_max3d."
//        return "http://www.radareu.cz/mobile/data/radar/radar.anim."
                + d.getUTCFullYear()+pad2(1+d.getUTCMonth())+pad2(d.getUTCDate())+"."+pad2(d.getUTCHours())+pad2(d.getMinutes()) +".0.png"

    }

    function pad2(num) {
        return (num >= 10) ? num : ("0" + num);
    }


    // workaround for local date
    DateFormater {
        id: formater;
    }

}
