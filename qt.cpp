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

#ifdef QTOPIA
#include <qtopiaapplication.h>
#include <QSoftMenuBar>
#else
#include <QtGui/QApplication>
#endif

extern "C" {

  struct frontend {
    PuzzleWindow *window;
  };

  struct blitter {
    QPixmap *pixmap;
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
#ifdef QTOPIA
    QFont font(font_family, fontsize / 2);
#else
    QFont font(font_family, fontsize);
#endif

    ((frontend *)handle)->window->draw_text(x,
					    y,
					    font,
					    align,
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
    bl->pixmap = new QPixmap();
    return bl;
  }

  void qt_blitter_free(void *handle, blitter *bl)
  {
    delete bl->pixmap;
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
  puzz_win->mouse_event(this, ev, LEFT_BUTTON);
}

void QtCanvas::mouseReleaseEvent(QMouseEvent *ev)
{
  puzz_win->mouse_event(this, ev, LEFT_RELEASE);
}

void QtCanvas::mouseMoveEvent(QMouseEvent *ev)
{
  puzz_win->mouse_event(this, ev, LEFT_DRAG);
}

PuzzleWindow::PuzzleWindow(QWidget * parent, Qt::WFlags f) : QMainWindow(parent, f)
{
  setupUi(this);

  // Data initialisations.
  timer = NULL;
  me = NULL;
  choose_game = NULL;
  game_presets = NULL;
  clip_x = -1;

  settings = new QSettings("QtMoko", "SGT-Puzzles");

  // Allocate the frontend structure that the rest of sgt-puzzles
  // understands, and link it to this main window.
  fe = snew(frontend);
  fe->window = this;

  // Connect menu items to the code that they should invoke.
  connect(actionRestart, SIGNAL(triggered()), this, SLOT(game_restart()));
  //@@@ skip Specific... for now
  //@@@ skip Random Seed... for now
  //@@@ skip Custom for now
  //@@@ skip Load
  //@@@ skip Save
  //@@@ skip Copy
  //@@@ skip Help for now
  connect(actionSolve, SIGNAL(triggered()), this, SLOT(game_solve()));
  connect(actionNew, SIGNAL(triggered()), this, SLOT(game_key()));
  connect(actionExit, SIGNAL(triggered()), this, SLOT(game_key()));

  actionNew->setData('n');
  actionExit->setData('q');

  // Connect the canvas widget, which is what directly processes mouse
  // events, back to this main window.
  toolBar->puzz_win = this;
  canvas->puzz_win = this;
  canvas->setAlignment(Qt::AlignHCenter | Qt::AlignVCenter);

  // Decide the default game.
  QString last_game_name = settings->value("last_game", "").toString();
  thegame = NULL;

  // Create Choose Game menu.
  menuChoose_Game->clear();
  if (choose_game) {
    delete choose_game;
    choose_game = NULL;
  }
  choose_game = new QActionGroup(this);
  int i;
  QAction *loopy_act = NULL;
  for (i = 0; i < gamecount; i++) {
    QAction *act = choose_game->addAction(gamelist[i]->name);
    act->setCheckable(true);
    act->setData(i);
    if (QString(gamelist[i]->name) == last_game_name) {
      act->setChecked(true);
      thegame = gamelist[i];
    } else {
      act->setChecked(false);
    }
    if (QString(gamelist[i]->name) == QString("Loopy")) {
      loopy_act = act;
    }
  }

  // In case we're running for the first time, or someone hand-edited
  // their config and so last_game_name was invalid...
  if (thegame == NULL) {
    thegame = gamelist[loopy_act->data().toInt()];
    loopy_act->setChecked(true);
  }

  menuChoose_Game->addActions(choose_game->actions());
  connect(choose_game, SIGNAL(triggered(QAction *)), this, SLOT(choose_game_type(QAction *)));

  // Switch to the default game.
  switch_game();
}

PuzzleWindow::~PuzzleWindow()
{
}

void PuzzleWindow::new_game()
{
  // Start a new game.
  midend_new_game(me);

  // Tell the midend to figure out the size it needs for the current
  // game, limited to the size of the canvas QLabel, and store the
  // results in w and h.
#ifndef QTOPIA
  w = INT_MAX;
  h = INT_MAX;
  midend_size(me, &w, &h, FALSE);
  canvas->setMinimumSize(w, h);
#endif
  w = canvas->width();
  h = canvas->height();
  midend_size(me, &w, &h, TRUE);
#ifndef QTOPIA
  canvas->setMinimumSize(w, h);
#endif

  // Create the pixmap that all the drawing functions will paint on.
  pixmap = new QPixmap(w, h);

  // Do the initial drawing.
  midend_redraw(me);
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

void PuzzleWindow::game_type_preset(QAction *action) {
  char *name;
  game_params *params;
  
  midend_fetch_preset(me, action->data().toInt(), &name, &params);
  midend_set_params(me, params);

  // Remember the last preset for the current game.
  settings->setValue(thegame->name, name);
  settings->sync();

  // Start a new game.
  QTimer::singleShot(50, this, SLOT(new_game()));
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

void PuzzleWindow::mouse_event(QWidget *src, QMouseEvent *ev, int midend_type) {
  if (src == toolBar) {
    // Only process release events.
    if (midend_type != LEFT_RELEASE) return;

    // Map of X coordinate types to midend event letters.
    struct {
      int min;
      int max;
      char event_letter;
    } map[12] = {
      { 12, 66, 'u' },
      { 82, 134, 'r' },
      { 151, 167, '0' },
      { 183, 199, '1' },
      { 214, 230, '2' },
      { 247, 263, '3' },
      { 278, 294, '4' },
      { 310, 326, '5' },
      { 341, 357, '6' },
      { 374, 390, '7' },
      { 406, 422, '8' },
      { 437, 453, '9' }
    };
    int x = ev->x();
    int i;

    for (i = 0; i < 12; i++) {
      if (x <= map[i].max) {
	if (x >= map[i].min) {
	  if (!midend_process_key(me, 0, 0, map[i].event_letter))
	    close();
	}
	return;
      }
    }
  } else { // src is not the toolbar
    int x = ev->x() - ((canvas->width() - w) / 2);
    int y = ev->y() - ((canvas->height() - h) / 2);
    if (!midend_process_key(me, x, y, midend_type))
      close();
  }
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
			     QFont& font, int align, int colour,
			     char *text)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.setFont(font);
  p.setPen(get_colour(colour));

  QRect textRect = p.boundingRect(0, 0, 100, 100, 0, text);

  if (align & ALIGN_VCENTRE)
    y -= textRect.height() / 2;
  else // ALIGN_VNORMAL
    y -= textRect.height();

  if (align & ALIGN_HCENTRE)
    x -= textRect.width() / 2;
  else if (align & ALIGN_HRIGHT)
    x -= textRect.width();

  p.drawText(x, y, 100, 100, 0, text);
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
  if (fill != -1) {
    QBrush brush(get_colour(fill));
    p.setBrush(brush);
  }
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
  if (fill != -1) {
    QBrush brush(get_colour(fill));
    p.setBrush(brush);
  }
  p.drawEllipse(cx - radius, cy - radius, 2 * radius, 2 * radius);
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
  status_Bar->setText(text);
}

void PuzzleWindow::blitter_save(struct blitter *bl, int x, int y)
{
  *bl->pixmap = pixmap->copy(x, y, bl->w, bl->h);    
}

void PuzzleWindow::blitter_load(struct blitter *bl, int x, int y)
{
  QPainter p(pixmap);
  if (clip_x >= 0) {
    p.setClipRect(clip_x, clip_y, clip_w, clip_h);
    p.setClipping(TRUE);
  }
  p.drawPixmap(x, y, *bl->pixmap);
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
#ifdef QTOPIA
  output[0] = output[1] = output[2] = 0.8F;
#else
  QColor base_colour = palette().color(QPalette::Base);
  output[0] = base_colour.redF();
  output[1] = base_colour.greenF();
  output[2] = base_colour.blueF();
#endif
}

void PuzzleWindow::choose_game_type(QAction *action)
{
  // Switch to new game.
  thegame = gamelist[action->data().toInt()];
  settings->setValue("last_game", thegame->name);
  settings->sync();
  switch_game();
}

void PuzzleWindow::switch_game()
{
  // Set the window title.
  setWindowTitle(thegame->name);

  // Set up stuff that depends on the chosen game.
  actionSolve->setEnabled(thegame->can_solve);
  if (thegame->flags & REQUIRE_NUMPAD) {
    toolBar->setPixmap(QPixmap(":qt-numpad.png"));
  } else {
    toolBar->setPixmap(QPixmap(":qt-numpad-dis.png"));
  }

  // Clean up any old midend.
  if (me)
    midend_free(me);

  // Create midend for the default game.
  me = midend_new(fe, thegame, &qt_drawing, fe, 1);

  // Find the last preset that the user played, for this game.
  QString last_preset_name = settings->value(thegame->name, "").toString();

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
  QAction *last_preset_act = NULL;
  for (i = 0; i < n; i++) {
    char *name;
    game_params *params;

    midend_fetch_preset(me, i, &name, &params);

    QAction *act = game_presets->addAction(name);
    act->setCheckable(true);
    act->setData(i);
    act->setChecked(false);
    if ((i == 0) || (QString(name) == last_preset_name)) {
      last_preset_act = act;
    }
  }
  last_preset_act->setChecked(true);
  menuType->addActions(game_presets->actions());
  connect(game_presets, SIGNAL(triggered(QAction *)), this, SLOT(game_type_preset(QAction *)));

#ifdef QTOPIA
  QMenu *softMenu = QSoftMenuBar::menuFor(this);
  softMenu->addAction(actionNew);
  softMenu->addAction(actionSolve);
  softMenu->addAction(actionRestart);
  softMenu->addMenu(menuType);
  softMenu->addMenu(menuChoose_Game);
  menuBar()->hide();
#endif

  // Get the colours that the midend will need.
  colours = midend_colours(me, &ncolours);

  // Start a new game.  For some reason, if we call new_game()
  // directly here, the initial puzzle doesn't get shown when the app
  // first starts up.  Calling it via a timer makes it work.
  game_type_preset(last_preset_act);
}

#ifdef QTOPIA

QTOPIA_ADD_APPLICATION(QTOPIA_TARGET, PuzzleWindow)
QTOPIA_MAIN

#else

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    PuzzleWindow w;
    w.show();
    return a.exec();
}

#endif
