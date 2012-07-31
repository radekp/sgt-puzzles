
#ifndef QT_H
#define QT_H

#include <QtGui>
#include "ui_qt.h"

class MainWindow : public QMainWindow, public Ui::MainWindow
{
Q_OBJECT
public:
    MainWindow( QWidget * parent = 0, Qt::WFlags f = 0 );
    ~MainWindow();

private:

protected:

private slots:
};

#endif
