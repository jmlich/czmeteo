#ifndef DATEFORMATER_H
#define DATEFORMATER_H

#include <QObject>

class DateFormater : public QObject
{
    Q_OBJECT
public:
    explicit DateFormater(QObject *parent = 0);

    Q_INVOKABLE QString toLocaleString(uint timestamp);
    
signals:
    
public slots:
    
};

#endif // DATEFORMATER_H
