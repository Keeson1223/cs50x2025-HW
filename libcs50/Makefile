#
# Makefile for libcs50
#
# By: Glenn Holloway
#

.PHONY: all clean install valgrind

# compilers
CC = clang

# flags
CFLAGS = -std=c11 -Wall -Wextra -Wno-unused-parameter
LDFLAGS =
LDLIBS =

# files
HEADERS = src/cs50.h
SOURCES = src/cs50.c
LIBRARY = libcs50.a
OBJECTS = $(SOURCES:.c=.o)
PREFIX ?= /usr/local

all: $(LIBRARY)

# library
$(LIBRARY): $(OBJECTS)
	ar rcs $@ $^

# objects
$(OBJECTS): $(HEADERS)

# install library and header
install: $(LIBRARY) $(HEADERS)
	@mkdir -p $(DESTDIR)$(PREFIX)/include
	@cp -f src/cs50.h $(DESTDIR)$(PREFIX)/include
	@mkdir -p $(DESTDIR)$(PREFIX)/lib
	@cp -f $(LIBRARY) $(DESTDIR)$(PREFIX)/lib

# uninstall library and header
uninstall:
	rm -f $(DESTDIR)$(PREFIX)/include/cs50.h
	rm -f $(DESTDIR)$(PREFIX)/lib/$(LIBRARY)

# remove object files and library
clean:
	rm -f $(OBJECTS) $(LIBRARY)

# check for memory leaks
valgrind:
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./test