#define _GNU_SOURCE
#include <stdarg.h>
#include <stdio.h>
#include <string.h>

#include "cs50.h"

static char *get_string_va(va_list *ap, const char *format);

char *get_string(const char *format, ...)
{
    // Check for NULL format string
    if (format == NULL)
    {
        return NULL;
    }

    // Get variadic arguments
    va_list ap;
    va_start(ap, format);

    // Call helper function that takes a va_list
    char *s = get_string_va(&ap, format);

    // Clean up
    va_end(ap);
    return s;
}

#include <stdlib.h>

static char *get_string_va(va_list *ap, const char *format)
{
    // Print prompt
    vprintf(format, *ap);

    // Try to read line from stdin
    char *line = NULL;
    size_t n = 0;
    if (getline(&line, &n, stdin) < 0)
    {
        if (line != NULL)
        {
            free(line);
        }
        return NULL;
    }

    // Find first newline and overwrite with \0
    char *newline = strchr(line, '\n');
    if (newline != NULL)
    {
        *newline = '\0';
    }

    return line;
}