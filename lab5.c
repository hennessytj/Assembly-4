#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/************ CONSTANTS ************/
int a;
int b;
char op;
int result;

/*********** PROTOTYPES ***********/
void addition(int, int, int *);
void mult(int, int, int *);
void power(int, int, int *);

int main(void)
{
    while(1)
    {
        scanf("%d %d %c", &a, &b, &op);
        printf("You entered: %d %d %c\n", a, b, op);
        
        if (op == '+')
            addition(a, b, &result);
        else if (op == '*')
            mult(a, b, &result);
        else if (op == '^')
            power(a, b, &result);
        else
            break;

        printf("Op %d %c %d = %d\n", a, op, b, result);
    }
}

void addition(int num1, int num2, int *sum)
{ *sum = num1 + num2; }

void mult(int num1, int num2, int *product)
{ *product = num1 * num2; }

void power(int base, int power, int *result)
{
    int i;
    *result = 1;
    for (i = 0; i < power; i++)
        *result *= base;
}

