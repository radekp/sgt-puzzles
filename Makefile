# Makefile for puzzles under X/GTK and Unix.
#
# This file was created by `mkfiles.pl' from the `Recipe' file.
# DO NOT EDIT THIS FILE DIRECTLY; edit Recipe or mkfiles.pl instead.

# You can define this path to point at your tools if you need to
# TOOLPATH = /opt/gcc/bin
CC := $(TOOLPATH)$(CC)
# You can manually set this to `gtk-config' or `pkg-config gtk+-1.2'
# (depending on what works on your system) if you want to enforce
# building with GTK 1.2, or you can set it to `pkg-config gtk+-2.0'
# if you want to enforce 2.0. The default is to try 2.0 and fall back
# to 1.2 if it isn't found.
GTK_CONFIG = sh -c 'pkg-config gtk+-2.0 $$0 2>/dev/null || gtk-config $$0'

CFLAGS := -O2 -Wall -Werror -ansi -pedantic -g -I./ -Iicons/ `$(GTK_CONFIG) \
		--cflags` $(CFLAGS)
XLIBS = `$(GTK_CONFIG) --libs`
ULIBS =#
INSTALL=install
INSTALL_PROGRAM=$(INSTALL)
INSTALL_DATA=$(INSTALL)
prefix=/usr/local
exec_prefix=$(prefix)
bindir=$(exec_prefix)/bin
gamesdir=$(exec_prefix)/games
mandir=$(prefix)/man
man1dir=$(mandir)/man1

all: blackbox bridges cube dominosa fifteen filling fillingsolver flip \
		galaxies galaxiespicture galaxiessolver guess inertia keen \
		keensolver latincheck lightup lightupsolver loopy \
		loopysolver magnets magnetssolver map mapsolver mineobfusc \
		mines net netslide nullgame obfusc pattern patternsolver \
		pearl pearlbench pegs range rect samegame signpost \
		signpostsolver singles singlessolver sixteen slant \
		slantsolver solo solosolver tents tentssolver towers \
		towerssolver twiddle unequal unequalsolver untangle

blackbox: blackbox.o drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ blackbox.o drawing.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

bridges: bridges.o drawing.o dsf.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ bridges.o drawing.o dsf.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

cube: cube.o drawing.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o \
		ps.o random.o version.o
	$(CC) -o $@ cube.o drawing.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

dominosa: dominosa.o drawing.o gtk.o laydomino.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o
	$(CC) -o $@ dominosa.o drawing.o gtk.o laydomino.o malloc.o midend.o \
		misc.o no-icon.o printing.o ps.o random.o version.o  \
		$(XLFLAGS) $(XLIBS)

fifteen: drawing.o fifteen.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o fifteen.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

filling: drawing.o dsf.o filling.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o dsf.o filling.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

fillingsolver: dsf.o filling2.o malloc.o misc.o nullfe.o random.o
	$(CC) -o $@ dsf.o filling2.o malloc.o misc.o nullfe.o random.o  \
		$(XLFLAGS) $(ULIBS)

flip: drawing.o flip.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o \
		ps.o random.o tree234.o version.o
	$(CC) -o $@ drawing.o flip.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o tree234.o version.o  \
		$(XLFLAGS) $(XLIBS)

galaxies: drawing.o dsf.o galaxies.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o dsf.o galaxies.o gtk.o malloc.o midend.o \
		misc.o no-icon.o printing.o ps.o random.o version.o  \
		$(XLFLAGS) $(XLIBS)

galaxiespicture: dsf.o galaxie4.o malloc.o misc.o nullfe.o random.o
	$(CC) -o $@ dsf.o galaxie4.o malloc.o misc.o nullfe.o random.o -lm \
		$(XLFLAGS) $(ULIBS)

galaxiessolver: dsf.o galaxie2.o malloc.o misc.o nullfe.o random.o
	$(CC) -o $@ dsf.o galaxie2.o malloc.o misc.o nullfe.o random.o -lm \
		$(XLFLAGS) $(ULIBS)

guess: drawing.o gtk.o guess.o malloc.o midend.o misc.o no-icon.o printing.o \
		ps.o random.o version.o
	$(CC) -o $@ drawing.o gtk.o guess.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

inertia: drawing.o gtk.o inertia.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o gtk.o inertia.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

keen: drawing.o dsf.o gtk.o keen.o latin.o malloc.o maxflow.o midend.o \
		misc.o no-icon.o printing.o ps.o random.o tree234.o \
		version.o
	$(CC) -o $@ drawing.o dsf.o gtk.o keen.o latin.o malloc.o maxflow.o \
		midend.o misc.o no-icon.o printing.o ps.o random.o tree234.o \
		version.o  $(XLFLAGS) $(XLIBS)

keensolver: dsf.o keen2.o latin6.o malloc.o maxflow.o misc.o nullfe.o \
		random.o tree234.o
	$(CC) -o $@ dsf.o keen2.o latin6.o malloc.o maxflow.o misc.o \
		nullfe.o random.o tree234.o  $(XLFLAGS) $(ULIBS)

latincheck: latin8.o malloc.o maxflow.o misc.o nullfe.o random.o tree234.o
	$(CC) -o $@ latin8.o malloc.o maxflow.o misc.o nullfe.o random.o \
		tree234.o  $(XLFLAGS) $(ULIBS)

lightup: combi.o drawing.o gtk.o lightup.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o
	$(CC) -o $@ combi.o drawing.o gtk.o lightup.o malloc.o midend.o \
		misc.o no-icon.o printing.o ps.o random.o version.o  \
		$(XLFLAGS) $(XLIBS)

lightupsolver: combi.o lightup2.o malloc.o misc.o nullfe.o random.o
	$(CC) -o $@ combi.o lightup2.o malloc.o misc.o nullfe.o random.o  \
		$(XLFLAGS) $(ULIBS)

loopy: drawing.o dsf.o grid.o gtk.o loopgen.o loopy.o malloc.o midend.o \
		misc.o no-icon.o penrose.o printing.o ps.o random.o \
		tree234.o version.o
	$(CC) -o $@ drawing.o dsf.o grid.o gtk.o loopgen.o loopy.o malloc.o \
		midend.o misc.o no-icon.o penrose.o printing.o ps.o random.o \
		tree234.o version.o  $(XLFLAGS) $(XLIBS)

loopysolver: dsf.o grid.o loopgen.o loopy2.o malloc.o misc.o nullfe.o \
		penrose.o random.o tree234.o
	$(CC) -o $@ dsf.o grid.o loopgen.o loopy2.o malloc.o misc.o nullfe.o \
		penrose.o random.o tree234.o -lm $(XLFLAGS) $(ULIBS)

magnets: drawing.o gtk.o laydomino.o magnets.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o gtk.o laydomino.o magnets.o malloc.o midend.o \
		misc.o no-icon.o printing.o ps.o random.o version.o  \
		$(XLFLAGS) $(XLIBS)

magnetssolver: laydomino.o magnets2.o malloc.o misc.o nullfe.o random.o
	$(CC) -o $@ laydomino.o magnets2.o malloc.o misc.o nullfe.o random.o \
		-lm $(XLFLAGS) $(ULIBS)

map: drawing.o dsf.o gtk.o malloc.o map.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o dsf.o gtk.o malloc.o map.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

mapsolver: dsf.o malloc.o map2.o misc.o nullfe.o random.o
	$(CC) -o $@ dsf.o malloc.o map2.o misc.o nullfe.o random.o -lm \
		$(XLFLAGS) $(ULIBS)

mineobfusc: malloc.o mines2.o misc.o nullfe.o random.o tree234.o
	$(CC) -o $@ malloc.o mines2.o misc.o nullfe.o random.o tree234.o  \
		$(XLFLAGS) $(ULIBS)

mines: drawing.o gtk.o malloc.o midend.o mines.o misc.o no-icon.o printing.o \
		ps.o random.o tree234.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o mines.o misc.o \
		no-icon.o printing.o ps.o random.o tree234.o version.o  \
		$(XLFLAGS) $(XLIBS)

net: drawing.o dsf.o gtk.o malloc.o midend.o misc.o net.o no-icon.o \
		printing.o ps.o random.o tree234.o version.o
	$(CC) -o $@ drawing.o dsf.o gtk.o malloc.o midend.o misc.o net.o \
		no-icon.o printing.o ps.o random.o tree234.o version.o  \
		$(XLFLAGS) $(XLIBS)

netslide: drawing.o gtk.o malloc.o midend.o misc.o netslide.o no-icon.o \
		printing.o ps.o random.o tree234.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o netslide.o \
		no-icon.o printing.o ps.o random.o tree234.o version.o  \
		$(XLFLAGS) $(XLIBS)

nullgame: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o nullgame.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		nullgame.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

obfusc: malloc.o misc.o nullfe.o obfusc.o random.o
	$(CC) -o $@ malloc.o misc.o nullfe.o obfusc.o random.o  $(XLFLAGS) \
		$(ULIBS)

pattern: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o pattern.o \
		printing.o ps.o random.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		pattern.o printing.o ps.o random.o version.o  $(XLFLAGS) \
		$(XLIBS)

patternsolver: malloc.o misc.o nullfe.o pattern2.o random.o
	$(CC) -o $@ malloc.o misc.o nullfe.o pattern2.o random.o  $(XLFLAGS) \
		$(ULIBS)

pearl: drawing.o dsf.o grid.o gtk.o loopgen.o malloc.o midend.o misc.o \
		no-icon.o pearl.o penrose.o printing.o ps.o random.o tdq.o \
		tree234.o version.o
	$(CC) -o $@ drawing.o dsf.o grid.o gtk.o loopgen.o malloc.o midend.o \
		misc.o no-icon.o pearl.o penrose.o printing.o ps.o random.o \
		tdq.o tree234.o version.o  $(XLFLAGS) $(XLIBS)

pearlbench: dsf.o grid.o loopgen.o malloc.o misc.o nullfe.o pearl2.o \
		penrose.o random.o tdq.o tree234.o
	$(CC) -o $@ dsf.o grid.o loopgen.o malloc.o misc.o nullfe.o pearl2.o \
		penrose.o random.o tdq.o tree234.o -lm $(XLFLAGS) $(ULIBS)

pegs: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o pegs.o printing.o \
		ps.o random.o tree234.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		pegs.o printing.o ps.o random.o tree234.o version.o  \
		$(XLFLAGS) $(XLIBS)

range: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o ps.o \
		random.o range.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o range.o version.o  $(XLFLAGS) \
		$(XLIBS)

rect: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o ps.o \
		random.o rect.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o rect.o version.o  $(XLFLAGS) \
		$(XLIBS)

samegame: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o ps.o \
		random.o samegame.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o samegame.o version.o  $(XLFLAGS) \
		$(XLIBS)

signpost: drawing.o dsf.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o signpost.o version.o
	$(CC) -o $@ drawing.o dsf.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o signpost.o version.o  $(XLFLAGS) \
		$(XLIBS)

signpostsolver: dsf.o malloc.o misc.o nullfe.o random.o signpos2.o
	$(CC) -o $@ dsf.o malloc.o misc.o nullfe.o random.o signpos2.o -lm \
		$(XLFLAGS) $(ULIBS)

singles: drawing.o dsf.o gtk.o latin.o malloc.o maxflow.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o singles.o tree234.o \
		version.o
	$(CC) -o $@ drawing.o dsf.o gtk.o latin.o malloc.o maxflow.o \
		midend.o misc.o no-icon.o printing.o ps.o random.o singles.o \
		tree234.o version.o  $(XLFLAGS) $(XLIBS)

singlessolver: dsf.o latin.o malloc.o maxflow.o misc.o nullfe.o random.o \
		singles3.o tree234.o
	$(CC) -o $@ dsf.o latin.o malloc.o maxflow.o misc.o nullfe.o \
		random.o singles3.o tree234.o  $(XLFLAGS) $(ULIBS)

sixteen: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o ps.o \
		random.o sixteen.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o sixteen.o version.o  $(XLFLAGS) \
		$(XLIBS)

slant: drawing.o dsf.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o \
		ps.o random.o slant.o version.o
	$(CC) -o $@ drawing.o dsf.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o slant.o version.o  $(XLFLAGS) \
		$(XLIBS)

slantsolver: dsf.o malloc.o misc.o nullfe.o random.o slant2.o
	$(CC) -o $@ dsf.o malloc.o misc.o nullfe.o random.o slant2.o  \
		$(XLFLAGS) $(ULIBS)

solo: divvy.o drawing.o dsf.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o solo.o version.o
	$(CC) -o $@ divvy.o drawing.o dsf.o gtk.o malloc.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o solo.o version.o  \
		$(XLFLAGS) $(XLIBS)

solosolver: divvy.o dsf.o malloc.o misc.o nullfe.o random.o solo2.o
	$(CC) -o $@ divvy.o dsf.o malloc.o misc.o nullfe.o random.o solo2.o  \
		$(XLFLAGS) $(ULIBS)

tents: drawing.o dsf.o gtk.o malloc.o maxflow.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o tents.o version.o
	$(CC) -o $@ drawing.o dsf.o gtk.o malloc.o maxflow.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o tents.o version.o  \
		$(XLFLAGS) $(XLIBS)

tentssolver: dsf.o malloc.o maxflow.o misc.o nullfe.o random.o tents3.o
	$(CC) -o $@ dsf.o malloc.o maxflow.o misc.o nullfe.o random.o \
		tents3.o  $(XLFLAGS) $(ULIBS)

towers: drawing.o gtk.o latin.o malloc.o maxflow.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o towers.o tree234.o version.o
	$(CC) -o $@ drawing.o gtk.o latin.o malloc.o maxflow.o midend.o \
		misc.o no-icon.o printing.o ps.o random.o towers.o tree234.o \
		version.o  $(XLFLAGS) $(XLIBS)

towerssolver: latin6.o malloc.o maxflow.o misc.o nullfe.o random.o towers2.o \
		tree234.o
	$(CC) -o $@ latin6.o malloc.o maxflow.o misc.o nullfe.o random.o \
		towers2.o tree234.o  $(XLFLAGS) $(ULIBS)

twiddle: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o ps.o \
		random.o twiddle.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o twiddle.o version.o  $(XLFLAGS) \
		$(XLIBS)

unequal: drawing.o gtk.o latin.o malloc.o maxflow.o midend.o misc.o \
		no-icon.o printing.o ps.o random.o tree234.o unequal.o \
		version.o
	$(CC) -o $@ drawing.o gtk.o latin.o malloc.o maxflow.o midend.o \
		misc.o no-icon.o printing.o ps.o random.o tree234.o \
		unequal.o version.o  $(XLFLAGS) $(XLIBS)

unequalsolver: latin6.o malloc.o maxflow.o misc.o nullfe.o random.o \
		tree234.o unequal2.o
	$(CC) -o $@ latin6.o malloc.o maxflow.o misc.o nullfe.o random.o \
		tree234.o unequal2.o  $(XLFLAGS) $(ULIBS)

untangle: drawing.o gtk.o malloc.o midend.o misc.o no-icon.o printing.o ps.o \
		random.o tree234.o untangle.o version.o
	$(CC) -o $@ drawing.o gtk.o malloc.o midend.o misc.o no-icon.o \
		printing.o ps.o random.o tree234.o untangle.o version.o  \
		$(XLFLAGS) $(XLIBS)

blackbox.o: ./blackbox.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
blackbo4.o: ./blackbox.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
bridges.o: ./bridges.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
bridges4.o: ./bridges.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
combi.o: ./combi.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
cube.o: ./cube.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
cube4.o: ./cube.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
divvy.o: ./divvy.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
dominosa.o: ./dominosa.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
dominos4.o: ./dominosa.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
drawing.o: ./drawing.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
dsf.o: ./dsf.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
fifteen.o: ./fifteen.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
fifteen4.o: ./fifteen.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
filling.o: ./filling.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
filling6.o: ./filling.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
filling2.o: ./filling.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
flip.o: ./flip.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
flip4.o: ./flip.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
galaxies.o: ./galaxies.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
galaxie8.o: ./galaxies.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
galaxie4.o: ./galaxies.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_PICTURE_GENERATOR -c $< -o $@
galaxie2.o: ./galaxies.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
grid.o: ./grid.c ./puzzles.h ./tree234.h ./grid.h ./penrose.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
gtk.o: ./gtk.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
guess.o: ./guess.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
guess4.o: ./guess.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
inertia.o: ./inertia.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
inertia4.o: ./inertia.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
keen.o: ./keen.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
keen6.o: ./keen.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
keen2.o: ./keen.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
latin.o: ./latin.c ./puzzles.h ./tree234.h ./maxflow.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
latin8.o: ./latin.c ./puzzles.h ./tree234.h ./maxflow.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_LATIN_TEST -c $< -o $@
latin6.o: ./latin.c ./puzzles.h ./tree234.h ./maxflow.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
laydomino.o: ./laydomino.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
lightup.o: ./lightup.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
lightup6.o: ./lightup.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
lightup2.o: ./lightup.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
list.o: ./list.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
loopgen.o: ./loopgen.c ./puzzles.h ./tree234.h ./grid.h ./loopgen.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
loopy.o: ./loopy.c ./puzzles.h ./tree234.h ./grid.h ./loopgen.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
loopy6.o: ./loopy.c ./puzzles.h ./tree234.h ./grid.h ./loopgen.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
loopy2.o: ./loopy.c ./puzzles.h ./tree234.h ./grid.h ./loopgen.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
magnets.o: ./magnets.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
magnets6.o: ./magnets.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
magnets2.o: ./magnets.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
malloc.o: ./malloc.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
map.o: ./map.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
map6.o: ./map.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
map2.o: ./map.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
maxflow.o: ./maxflow.c ./maxflow.h ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
midend.o: ./midend.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
mines.o: ./mines.c ./tree234.h ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
mines6.o: ./mines.c ./tree234.h ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
mines2.o: ./mines.c ./tree234.h ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_OBFUSCATOR -c $< -o $@
misc.o: ./misc.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
net.o: ./net.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
net4.o: ./net.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
netslide.o: ./netslide.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
netslid4.o: ./netslide.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
no-icon.o: ./no-icon.c
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
nullfe.o: ./nullfe.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
nullgame.o: ./nullgame.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
obfusc.o: ./obfusc.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
osx.o: ./osx.m ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
pattern.o: ./pattern.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
pattern6.o: ./pattern.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
pattern2.o: ./pattern.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
pearl.o: ./pearl.c ./puzzles.h ./grid.h ./loopgen.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
pearl6.o: ./pearl.c ./puzzles.h ./grid.h ./loopgen.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
pearl2.o: ./pearl.c ./puzzles.h ./grid.h ./loopgen.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
pegs.o: ./pegs.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
pegs4.o: ./pegs.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
penrose.o: ./penrose.c ./puzzles.h ./penrose.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
printing.o: ./printing.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
ps.o: ./ps.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
qt.o: ./qt.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
random.o: ./random.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
range.o: ./range.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
range4.o: ./range.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
rect.o: ./rect.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
rect4.o: ./rect.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
samegame.o: ./samegame.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
samegam4.o: ./samegame.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
signpost.o: ./signpost.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
signpos6.o: ./signpost.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
signpos2.o: ./signpost.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
singles.o: ./singles.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
singles6.o: ./singles.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
singles3.o: ./singles.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
sixteen.o: ./sixteen.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
sixteen4.o: ./sixteen.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
slant.o: ./slant.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
slant6.o: ./slant.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
slant2.o: ./slant.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
solo.o: ./solo.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
solo6.o: ./solo.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
solo2.o: ./solo.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
tdq.o: ./tdq.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
tents.o: ./tents.c ./puzzles.h ./maxflow.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
tents6.o: ./tents.c ./puzzles.h ./maxflow.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
tents3.o: ./tents.c ./puzzles.h ./maxflow.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
towers.o: ./towers.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
towers6.o: ./towers.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
towers2.o: ./towers.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
tree234.o: ./tree234.c ./tree234.h ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
twiddle.o: ./twiddle.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
twiddle4.o: ./twiddle.c ./puzzles.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
unequal.o: ./unequal.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
unequal6.o: ./unequal.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
unequal2.o: ./unequal.c ./puzzles.h ./latin.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DSTANDALONE_SOLVER -c $< -o $@
untangle.o: ./untangle.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
untangl4.o: ./untangle.c ./puzzles.h ./tree234.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@
windows.o: ./windows.c ./puzzles.h ./resource.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -c $< -o $@
windows1.o: ./windows.c ./puzzles.h ./resource.h
	$(CC) $(COMPAT) $(FWHACK) $(CFLAGS) $(XFLAGS) -DCOMBINED -c $< -o $@

GAMES += blackbox
GAMES += bridges
GAMES += cube
GAMES += dominosa
GAMES += fifteen
GAMES += filling
GAMES += flip
GAMES += galaxies
GAMES += guess
GAMES += inertia
GAMES += keen
GAMES += lightup
GAMES += loopy
GAMES += magnets
GAMES += map
GAMES += mines
GAMES += net
GAMES += netslide
GAMES += pattern
GAMES += pearl
GAMES += pegs
GAMES += range
GAMES += rect
GAMES += samegame
GAMES += signpost
GAMES += singles
GAMES += sixteen
GAMES += slant
GAMES += solo
GAMES += tents
GAMES += towers
GAMES += twiddle
GAMES += unequal
GAMES += untangle
version.o: version.c version2.def
	$(CC) $(COMPAT) $(XFLAGS) $(CFLAGS) `cat version2.def` -c version.c
version2.def: FORCE
	if test -z "$(VER)" && test -f manifest && md5sum -c manifest; then \
		cat version.def > version2.def.new; \
	elif test -z "$(VER)" && test -d .svn && svnversion . >/dev/null 2>&1; then \
		echo "-DREVISION=`svnversion .`" >version2.def.new; \
	else \
		echo "$(VER)" >version2.def.new; \
	fi && \
	if diff -q version2.def.new version2.def; then \
		rm version2.def.new; \
	else \
		mv version2.def.new version2.def; \
	fi
.PHONY: FORCE
install:
	for i in $(GAMES); do \
		$(INSTALL_PROGRAM) -m 755 $$i $(DESTDIR)$(gamesdir)/$$i \
		|| exit 1; \
	done

clean:
	rm -f *.o blackbox bridges cube dominosa fifteen filling fillingsolver flip galaxies galaxiespicture galaxiessolver guess inertia keen keensolver latincheck lightup lightupsolver loopy loopysolver magnets magnetssolver map mapsolver mineobfusc mines net netslide nullgame obfusc pattern patternsolver pearl pearlbench pegs range rect samegame signpost signpostsolver singles singlessolver sixteen slant slantsolver solo solosolver tents tentssolver towers towerssolver twiddle unequal unequalsolver untangle
