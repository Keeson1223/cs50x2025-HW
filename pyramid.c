#include <stdio.h>
#include "cs50.h"

int main(void)
{
    int n = get_int("Please enter an integer between 1 and 8 ");
    
    for (int i = 1; i<=n; i++)
    {
        for (int j = 0; j < n - i; j++)
        {
            printf(" ");
        }
        for (int k = 0; k < i; k++)
        {
            printf("#");
        }
        printf("\n");
    }
    return 0;
}


