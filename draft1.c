#include <stdio.h>
#include "cs50.h"
int main(void)
{
    long number = get_long("Please enter your debit card or credit card number: ");
    int position = 0;
    int sum = 0;
    while (number > 0)
    {
        int digit = number % 10;
        position++;
        if (position % 2 == 0)
        {
            int temporary_number = digit * 2;
            if (temporary_number > 9)
            {
                int A = temporary_number % 10;
                int B = temporary_number / 10;
                sum =+ A + B;
            }
            else (temporary_number <= 9);
            {
                sum =+ temporary_number;
            }
        }
        else (position % 2 == 1);
        {
            sum =+ digit;
        }
        number = number / 10;
        
    }
    printf("\n");

}