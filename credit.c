#include <stdio.h>
#include "cs50.h"
int main(void)
{
    long i = get_long("Please enter your debit card or credit card number: ");
    long number = i;
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
                sum += A + B;
            }
            else
            {
                sum += temporary_number;
            }
        }
        else
        {
            sum += digit;
        }
        number = number / 10;
        
    }

    long final_number = i ;

    while (final_number > 100)
    {
       final_number = final_number / 10;
    }

    long prefix = final_number;
    if (sum % 10 == 0)
    {
        if (position == 15 && ( prefix == 34 || prefix == 37))
        {
            printf("Card validation: Success. Issuer: American Express.");
        }
        else if (position == 16 && (prefix == 51 || prefix == 52 || prefix == 53 || prefix == 54 || prefix == 55))
        {
            printf("Card validation: Success. Issuer: Mastercard.");
        }
        else if ((position == 13 || position == 16) && (prefix / 10 == 4))
        {
            printf("Card validation: Success. Issuer: Visa.");
        }
        else
        {
            printf("Unknow.");
        }

    }
    else
    {
        printf("The card number is invalid.");
    }
    printf("\n");

}