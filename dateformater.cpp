#include "dateformater.h"
#include <QDateTime>
#include <QDebug>

DateFormater::DateFormater(QObject *parent) :
    QObject(parent)
{
}

QString DateFormater::toLocaleString(uint timestamp) {
    QDateTime d = QDateTime::fromTime_t(timestamp);
    return d.toString(Qt::DefaultLocaleShortDate);
}
