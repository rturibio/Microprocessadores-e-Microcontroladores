#include <xc.h>
#include <pic16f877a.h>
#include <stdio.h>
#define _XTAL_FREQ 4000000

int main() 
{
    TRISC0 = 1;
    TRISD0 = 0;
    RD0 = 0;
    RC0 = 0;
    
    while(1)
    {
        if(RC0 == 1)
        {
            RD0 = 1;
        }
        else
        {
          RD0 =0;  
        }
    }

    return (0);
}
