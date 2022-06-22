#include <xc.h>
#include <pic16f877a.h>
#include <stdio.h>
#define _XTAL_FREQ 4000000

unsigned pulse = 0x00; //armazena o numero do pulso

int main() 
{
    CMCON = 0x07;         // Desabilita os comparadores
    T1CON = 0x03;         // Habilita o Timer1 e Clock Externo
    TMR1L = 0x00;         // Inicia o Timer1 em 0000
    TMR1H = 0x00;
    
    TRISB = 0x00;         // 0111 1111   Apenas o RB0 como saída
    
    PORTB = 0x00;         // Inicia todo PORTB em low
    
    
    while(1)
    {
        pulse = (TMR1H << 8) + TMR1L; //armazena o valor do timer 1 em pulse
        
        if (pulse == 3)
        {
            if(RB0 == 1)
            {
               RB0 = 0; 
            }
            if(RB0 == 0)
            {
                RB0 = 1;
            }            
            pulse = 0;
        } 
        
    }
    return (0);
}