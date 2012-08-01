/*
 * qt.cpp: Qtopia front end for Simon Tatham's puzzle collection.
 */

extern "C" {

#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include <time.h>
#include <stdarg.h>
#include <string.h>
#include <errno.h>
#include <math.h>

#include <sys/time.h>

#include "puzzles.h"

}

#include "qtcanvas.h"
#include "qt.h"
#include <qtopiaapplication.h>

extern "C" {

  struct frontend {
    PuzzleWindow *window;
  };

  struct blitter {
    QPixmap pixmap;
    int w, h, x, y;
  };

  void activate_timer(frontend *fe)
  {
    fe->window->activate_timer();
  }

  void deactivate_timer(frontend *fe)
  {
    fe->window->deactivate_timer();
  }

  void qt_draw_text(void *handle, int x, int y, int fonttype, int fontsize,
		    int align, int colour, char *text)
  {
    const char *font_family = (fonttype == FONT_FIXED) ? "Courier" : "Arial";
    QFont font(font_family, fontsize);

    int flags = 0;
    if (align & ALIGN_VCENTRE)
      flags |= Qt::AlignVCenter;
    if (align & ALIGN_HLEFT)
      flags |= Qt::AlignLeft;
    if (align & ALIGN_HCENTRE)
      flags |= Qt::AlignHCenter;
    if (align & ALIGN_HRIGHT)
      flags |= Qt::AlignRight;

    ((frontend *)handle)->window->draw_text(x,
					    y,
					    font,
					    flags,
					    colour,
					    text);
  }

  void qt_draw_rect(void *handle, int x, int y, int w, int h, int colour)
  {
    ((frontend *)handle)->window->draw_rect(x, y, w, h, colour);
  }

  void qt_draw_line(void *handle, int x1, int y1, int x2, int y2, int colour)
  {
    ((frontend *)handle)->window->draw_line(x1, y1, x2, y2, colour);
  }

  void qt_draw_poly(void *handle, int *coords, int npoints,
		    int fillcolour, int outlinecolour)
  {
    QPoint points[npoints];
    int i;
    for (i = 0; i < npoints; i++) {
      points[i].setX(coords[(2 * i) + 0]);
      points[i].setY(coords[(2 * i) + 1]);
    }

    ((frontend *)handle)->window->draw_poly(npoints,
					    points,
					    fillcolour,
					    outlinecolour);
  }

  void qt_draw_circle(void *handle, int cx, int cy, int radius,
		     int fillcolour, int outlinecolour)
  {
    ((frontend *)handle)->window->draw_circle(cx,
					      cy,
					      radius,
					      fillcolour,
					      outlinecolour);
  }

  void qt_draw_update(void *handle, int x, int y, int w, int h)
  {
    // Nothing needed.
  }

  void qt_clip(void *handle, int x, int y, int w, int h)
  {
    ((frontend *)handle)->window->clip(x, y, w, h);
  }

  void qt_unclip(void *handle)
  {
    ((frontend *)handle)->window->unclip();
  }

  void qt_start_draw(void *handle)
  {
    // Nothing needed.
  }

  void qt_end_draw(void *handle)
  {
    ((frontend *)handle)->window->end_draw();
  }

  void qt_status_bar(void *handle, char *text)
  {
    ((frontend *)handle)->window->status_bar(text);
  }

  blitter *qt_blitter_new(void *handle, int w, int h)
  {
    blitter *bl = snew(blitter);
    bl->w = w;
    bl->h = h;
    return bl;
  }

  void qt_blitter_free(void *handle, blitter *bl)
  {
    sfree(bl);
  }

  void qt_blitter_save(void *handle, blitter *bl, int x, int y)
  {
    ((frontend *)handle)->window->blitter_save(bl, x, y);
    bl->x = x;
    bl->y = y;
  }

  void qt_blitter_load(void *handle, blitter *bl, int x, int y)
  {
    if (x == BLITTER_FROMSAVED && y == BLITTER_FROMSAVED) {
        x = bl->x;
        y = bl->y;
    }
    ((frontend *)handle)->window->blitter_load(bl, x, y);
  }

  void qt_draw_thick_line(void *handle, float thickness,
			  float x1, float y1, float x2, float y2, int colour)
  {
    ((frontend *)handle)->window->draw_thick_line(thickness,
						  x1, y1, x2, y2,
						  colour);
  }

  const struct drawing_api qt_drawing = {
    qt_draw_text,
    qt_draw_rect,
    qt_draw_line,
    qt_draw_poly,
    qt_draw_circle,
    qt_draw_update,
    qt_clip,
    qt_unclip,
    qt_start_draw,
    qt_end_draw,
    qt_status_bar,
    qt_blitter_new,
    qt_blitter_free,
    qt_blitter_save,
    qt_blitter_load,
    NULL, NULL, NULL, NULL, NULL, NULL, /* {begin,end}_{doc,page,puzzle} */
    NULL, NULL,			       /* line_width, line_dotted */
    NULL,
    qt_draw_thick_line,
  };

  void frontend_default_colour(frontend *fe, float *output)
  {
    fe->window->default_colour(output);
  }

  void fatal(char *fmt, ...)
  {
    va_list ap;

    fprintf(stderr, "fatal error: ");

    va_start(ap, fmt);
    vfprintf(stderr, fmt, ap);
    va_end(ap);

    fprintf(stderr, "\n");
    exit(1);
  }

  /*
   * Since this front end does not support printing (yet), we need
   * this stub to satisfy the reference in midend_print_puzzle().
   */
  void document_add_puzzle(document *doc, const game *game, game_params *par,
			   game_state *st, game_state *st2)
  {
  }

  void get_random_seed(void **randseed, int *randseedsize)
  {
    struct timeval *tvp = snew(struct timeval);
    gettimeofday(tvp, NULL);
    *randseed = (void *)tvp;
    *randseedsize = sizeof(struct timeval);
  }

}

QtCanvas::QtCanvas(QWidget *parent, Qt::WFlags f) : QLabel(parent, f)
{
}

QtCanvas::~QtCanvas() {
}

void QtCanvas::mousePressEvent(QMouseEvent *ev)
{
  puzz_win->mouse_event(ev, LEFT_BUTTON);
}

void QtCanvas::mouseReleaseEvent(QMouseEvent *ev)
{
  puzz_win->mouse_event(ev, LEFT_RELEASE);
}

void QtCanvas::mouseMoveEvent(QMouseEvent *ev)
{
  puzz_win->mouse_event(ev, LEFT_DRAG);
}

PuzzleWindow::PuzzleWindow(QWidget * parent, Qt::WFlags f) : QMainWindow(parent, f)
{
    setupUi(this);

    // Data initialisations.
    timer = NULL;
    me = NULL;
    game_presets = NULL;
    clip_x = -1;

    // Allocate the frontend structure that the rest of sgt-puzzles
    // understands, and link it to this main window.
    fe = snew(frontend);
    fe->window = this;

    // Choose the default game.  For now that'll be the first in the
    // list; in future we should save and restore the last game that
    // the user switched to.
    thegame = gamelist[12];

    // Create midend for the default game.
    me = midend_new(fe, thegame, &qt_drawing, fe, 1);

    // Start a new game.
    midend_new_game(me);

    // Connect menu items to the code that they should invoke.
    connect(actionRestart, SIGNAL(triggered()), this, SLOT(game_restart()));
    //@@@ skip Specific... for now
    //@@@ skip Random Seed... for now

    // Create Type menu items according to the presets of the current
    // game.
    menuType->clear();
    if (game_presets) {
      delete game_presets;
      game_presets = NULL;
    }
    game_presets = new QActionGroup(this);
    int n = midend_num_presets(me), i;
    int curr = midend_which_preset(me);
    for (i = 0; i < n; i++) {
      char *name;
      game_params *params;

      midend_fetch_preset(me, i, &name, &params);

      QAction *act = game_presets->addAction(name);
      act->setCheckable(true);
      act->setData(i);

      act->setChecked(i == curr);
    }
    menuType->addActions(game_presets->actions());
    connect(game_presets, SIGNAL(triggered()), this, SLOT(game_type_preset()));

    //@@@ skip Custom for now
    //@@@ skip Load
    //@@@ skip Save
    //@@@ skip Copy
    //@@@ skip Help for now

    actionSolve->setEnabled(thegame->can_solve);
    connect(actionSolve, SIGNAL(triggered()), this, SLOT(game_solve()));
    connect(actionNew, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actionExit, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontbUndo, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontbRedo, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb0, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb1, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb2, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb3, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb4, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb5, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb6, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb7, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb8, SIGNAL(triggered()), this, SLOT(game_key()));
    connect(actiontb9, SIGNAL(triggered()), this, SLOT(game_key()));

    actiontb0->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb1->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb2->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb3->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb4->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb5->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb6->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb7->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb8->setEnabled(thegame->flags & REQUIRE_NUMPAD);
    actiontb9->setEnabled(thegame->flags & REQUIRE_NUMPAD);

    actionNew->setData('n');
    actionExit->setData('q');
    actiontbUndo->setData('u');
    actiontbRedo->setData('r');
    actiontb0->setData('0');
    actiontb1->setData('1');
    actiontb2->setData('2');
    actiontb3->setData('3');
    actiontb4->setData('4');
    actiontb5->setData('5');
    actiontb6->setData('6');
    actiontb7->setData('7');
    actiontb8->setData('8');
    actiontb9->setData('9');

    // Get the colours that the midend will need.
    colours = midend_colours(me, &ncolours);

    // Tell the midend to figure out the size it needs for the current
    // game, limited to the size of the canvas QLabel, and store the
    // results in w and h.
    w = canvas->width();
    h = canvas->height();
    midend_size(me, &w, &h, FALSE);

    // Create the pixmap that all the drawing functions will paint on.
    pixmap = new QPixmap(w, h);

    // Connect the canvas widget, which is what directly processes
    // mouse events, back to this main window.
    canvas->puzz_win = this;
}

PuzzleWindow::~PuzzleWindow()
{
}

void PuzzleWindow::activate_timer()
{
  if (!timer) {
    timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(timerSlot()));
    timer->start(20);
    gettimeofday(&last_time, NULL);
  }
}

void PuzzleWindow::timerSlot() {
  if (timer) {
    struct timeval now;
    float elapsed;
    gettimeofday(&now, NULL);
    elapsed = ((now.tv_usec - last_time.tv_usec) * 0.000001F +
	       (now.tv_sec - last_time.tv_sec));
    midend_timer(me, elapsed);
    last_time = now;
  }
}

void PuzzleWindow::deactivate_timer()
{
  if (timer) {
    delete timer;
    timer = NULL;
  }
}

void PuzzleWindow::game_restart() {
  midend_restart_game(me);
}

void PuzzleWindow::game_type_preset() {
  int i = game_presets->checkedAction()->data().toInt();
  char *name;
  game_params *params;
  
  midend_fetch_preset(me, i, &name, &params);
  midend_set_params(me, params);
  midend_new_game(me);
}

void PuzzleWindow::game_solve() {
  char *msg = midend_solve(me);
  if (msg)
    QMessageBox::warning(this, "sgt-puzzles", msg);
}

void PuzzleWindow::game_key() {
  QAction *source = (QAction *)sender();
  if (!midend_process_key(me, 0, 0, source->data().toInt()))
    close();
}

void PuzzleWindow::mouse_event(QMouseEvent *ev, int midend_type) {
  if (!midend_process_key(me, ev->x(), ev->y(), midend_type))
    close();
}

QColor PuzzleWindow::get_colour(int colour)
{
  QColor color;
  color.setRedF(colours[(colour * 3) + 0]);
  color.setGreenF(colours[(colour * 3) + 1]);
  color.setBlueF(colours[(colour * 3) + 2]);
  return color;
}

void PuzzleWindow::draw_text(int x, int y,
			     QFont& font, int flags, int colour,
			     char *text)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.setFont(font);
  p.setPen(get_colour(colour));
  p.drawText(x, y, w, h, flags, text);
}

void PuzzleWindow::draw_rect(int x, int y, int w, int h, int colour)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.fillRect(x, y, w, h, get_colour(colour));
}

void PuzzleWindow::draw_line(int x1, int y1, int x2, int y2, int colour)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.setPen(get_colour(colour));
  p.drawLine(x1, y1, x2, y2);
}

void PuzzleWindow::draw_poly(int npoints, QPoint *points, int fill, int outline)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.setPen(get_colour(outline));
  QBrush brush(get_colour(fill));
  p.setBrush(brush);
  p.drawPolygon(points, npoints);
}

void PuzzleWindow::draw_circle(int cx, int cy, int radius,
			       int fill, int outline)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.setPen(get_colour(outline));
  QBrush brush(get_colour(fill));
  p.setBrush(brush);
  p.drawEllipse(cx, cy, radius, radius);
}

void PuzzleWindow::clip(int x, int y, int w, int h)
{
  clip_x = x;
  clip_y = y;
  clip_w = w;
  clip_h = h;
}

void PuzzleWindow::unclip()
{
  clip_x = -1;
}

void PuzzleWindow::end_draw()
{
  canvas->setPixmap(*pixmap);
}

void PuzzleWindow::status_bar(char *text)
{
  statusBar->setText(text);
}

void PuzzleWindow::blitter_save(struct blitter *bl, int x, int y)
{
  bl->pixmap = pixmap->copy(x, y, bl->w, bl->h);    
}

void PuzzleWindow::blitter_load(struct blitter *bl, int x, int y)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.drawPixmap(x, y, bl->pixmap);
}

void PuzzleWindow::draw_thick_line(float thickness,
				   float x1, float y1, float x2, float y2,
				   int colour)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  QPen pen(get_colour(colour));
  pen.setWidthF(thickness);
  p.setPen(pen);
  QLineF line(x1, y1, x2, y2);
  p.drawLine(line);
}

void PuzzleWindow::default_colour(float *output)
{
  QColor base_colour = palette().color(QPalette::Base);
  output[0] = base_colour.redF();
  output[1] = base_colour.greenF();
  output[2] = base_colour.blueF();
}

QTOPIA_ADD_APPLICATION(QTOPIA_TARGET, PuzzleWindow)
QTOPIA_MAIN
