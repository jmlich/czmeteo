#include <QtGui/QApplication>
#include <QtDeclarative>
#include <QDebug>

#include "qmlapplicationviewer.h"
#include "dateformater.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

    // QLocale::setDefault(QLocale::Czech); // pro ostatni jazyky zakomentovat

    QTranslator *translator = new QTranslator();

    if (translator->load("czMeteo_" + QLocale::system().name(), ":/")) {
      app->installTranslator(translator);
      qDebug() << "installing translations";
    }

    qmlRegisterType<DateFormater>("cz.vutbr.fit.pcmlich", 1, 0, "DateFormater");


    QmlApplicationViewer viewer;
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/czMeteo/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
