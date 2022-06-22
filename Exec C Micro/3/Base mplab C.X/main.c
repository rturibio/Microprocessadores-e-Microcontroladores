#include <xc.h>
#include <pic16f877a.h>
#include <stdio.h>
#define _XTAL_FREQ 4000000

void incrementa();

void decrementa();

void ten();

void zero();

int var = 0;

int main() 
{
    TRISC0 = 1;
    TRISD0 = 0;
    RD0 = 0;
    RC0 = 0;
    int var = 0;
    //rc0 incrementa
    //rc1 decrementa
    while(1)
    {
        if(RC0 == 1)
        {
            incrementa();
        }
        if(RC1 == 1)
        {
            decrementa();  
        }
        if(var == 10)
        {
           ten();  
        }
        if (var == 10)
        {
            RD0 = 1;
            __delay_ms(200);
            RD0 = 0;
            var = 0;
        }
      }
    return (0);
}

void incrementa(){
    var = var + 1;
}

void decrementa(){
    var = var - 1;
}

void ten(){
    RD0 = 1;
    __delay_ms(200);
    RD0 = 0;
    var = 0;
}

void zero(){
    RD0 = 1;
    __delay_ms(200);
    RD0 = 0;
    var = 0;
}
