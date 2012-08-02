
#ifndef QTCANVAS_H
#define QTCANVAS_H

#include <QtGui>

class PuzzleWindow;

class QtCanvas : public QLabel
{
Q_OBJECT
public:
  QtCanvas(QWidget * parent = 0, Qt::WFlags f = 0);
  virtual ~QtCanvas();
  PuzzleWindow *puzz_win;

private:

protected:
  virtual void mousePressEvent(QMouseEvent *ev);
  virtual void mouseReleaseEvent(QMouseEvent *ev);
  virtual void mouseMoveEvent(QMouseEvent *ev);

private slots:

};

#endif
