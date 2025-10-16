#ifndef CS50_H
#define CS50_H

#include <stdbool.h>
#include <stddef.h>

typedef char *string;

char *get_string(const char *format, ...) __attribute__((format(printf, 1, 2)));

#endif // CS50_H