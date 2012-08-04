
#ifndef QT_H
#define QT_H

#include <QtGui>
#include "ui_qt.h"

class PuzzleWindow : public QMainWindow, public Ui::PuzzleWindow
{
Q_OBJECT
public:
  PuzzleWindow(QWidget * parent = 0, Qt::WFlags f = 0);
  virtual ~PuzzleWindow();
  void activate_timer();
  void deactivate_timer();
  QPixmap *pixmap;

  void mouse_event(QWidget *src, QMouseEvent *ev, int midend_type);

  QColor get_colour(int colour);
  void draw_text(int x, int y, QFont& font, int align, int colour, char *text);
  void draw_rect(int x, int y, int w, int h, int colour);
  void draw_line(int x1, int y1, int x2, int y2, int colour);
  void draw_poly(int npoints, QPoint *points, int fill, int outline);
  void draw_circle(int cx, int cy, int radius, int fill, int outline);
  void clip(int x, int y, int w, int h);
  void unclip();
  void end_draw();
  void status_bar(char *text);
  void blitter_save(struct blitter *bl, int x, int y);
  void blitter_load(struct blitter *bl, int x, int y);
  void draw_thick_line(float thickness,
		       float x1, float y1, float x2, float y2,
		       int colour);
  void default_colour(float *output);

private:
  const struct game *thegame;
  struct frontend *fe;
  struct midend *me;
  QActionGroup *choose_game;
  QActionGroup *game_presets;
  int ncolours;
  float *colours;
  int w, h;

  // Clipping.
  int clip_x, clip_y, clip_w, clip_h;
 
  // Timer support.
  QTimer *timer;
  struct timeval last_time;

  void switch_game();

protected:

private slots:
  void timerSlot();
  void game_restart();
  void game_type_preset(QAction *action);
  void game_solve();
  void game_key();
  void choose_game_type(QAction *action);
  void new_game();

};

#endif
