
#ifndef QT_H
#define QT_H

#include <QtGui>
#include "ui_qt.h"

class MainWindow : public QMainWindow, public Ui::MainWindow
{
Q_OBJECT
public:
  MainWindow(QWidget * parent = 0, Qt::WFlags f = 0);
  ~MainWindow();
  activate_timer();
  deactivate_timer();

private:
  struct game *thegame;
  frontend *fe;
  midend *me;
  QActionGroup *game_presets;
  int ncolours;
  float *colours;
  int w, h;

  // Timer support.
  QTimer *timer;
  struct timeval last_time;

protected:

private slots:
  void timer();
  void game_restart();
  void game_type_preset();
  void game_solve();
  void game_key();

};

#endif
