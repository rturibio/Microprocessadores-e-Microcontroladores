/*
 * File:   main.c
 * Author: Matheus Rossetti & Rian Turibio               
 * - Cancela é forçada até a posição inicial, enquanto o sensor de inicio de curso não for ativado
 * - Sistema fica piscando luz enquanto sensor de veiculo não ativa
 * - Sistema sobe cancela até sensor de fim de curso, por 20 seg.
 * - Então cancela desce
 * 
 * - TODOS ESSAS ETAPAS PODEM SER PARADAS CASO UM TREM ESTEJA A CAMINHO, função interrupt
 */

#include <xc.h>
#include <pic16f877a.h>
#include <stdio.h>

#define _XTAL_FREQ 4000000
void __interrupt() TrataInt(void);
void cancelaDesce(void);
void cancelaSobe(void);

void main(void) 
{
   //
   TRISBbits.TRISB0 = 1;         //DEFINE A PORTA B0 COMO ENTRADA - SENSOR TREM e INTERRUPÇÃO
   TRISBbits.TRISB1 = 1;         //DEFINE A PORTA B1 COMO ENTRADA - SENSOR CARRO
   TRISBbits.TRISB2 = 1;         //DEFINE A PORTA B2 COMO ENTRADA - FIM DE CURSO
   TRISBbits.TRISB3 = 1;         //DEFINE A PORTA B3 COMO ENTRADA - INICIO DE CURSO
   //
   TRISDbits.TRISD0 = 0;         //DEFINE A PORTA D0 COMO SAIDA - DESCE CANCELA
   TRISDbits.TRISD3 = 0;         //DEFINE A PORTA D3 COMO SAIDA - SOBE CANCELA
   TRISDbits.TRISD4 = 0;         //DEFINE A PORTA D4 COMO SAIDA - SIRENE
   TRISBbits.TRISB4 = 0;         //DEFINE A PORTA B4 COMO SAIDA - PISCA PISCA
   
   OPTION_REGbits.INTEDG = 1;    //HABILITA INTERRUPÇÃO
   INTCONbits.GIE = 1;           //Interrupção Global Ativada
   INTCONbits.INTE = 1;          //HABILITA INTERRUPÇÃO
   
   PORTDbits.RD0 = 0;            //INICIA O PINO DAS LUZES APAGADAS
   PORTDbits.RD3 = 0;            //INICIA O PINO DAS LUZES 
   PORTDbits.RD4 = 0;            //INICIA O PINO DAS LUZES APAGaDAS
   
   cancelaDesce();               // COLOCA A CANCELA NO INICIO DE CURSO
   while(1)
   {
      if(PORTBbits.RB3 == 0)     //PISCA PISCA ENQUANTO NÃO TEM CARRO
      {
         PORTBbits.RB4 = 1;
         __delay_ms(250);
         PORTBbits.RB4 = 0;
         __delay_ms(250);  
      }
      else
      {
         cancelaSobe();         //ACIONA SUBIDA DA CANCELA
         __delay_ms(2000);     
         cancelaDesce();        //ACIONA DESCIDA DA CANCELA
      }
   }
   
   return;
}

void cancelaDesce(void)
{
   while(PORTBbits.RB1 == 0)  //COLOCA CANCELA NO INICIO
   {
      PORTDbits.RD0 = 1;      //DESCE O MOTOR
      __delay_ms(250);
   }
   PORTDbits.RD0 = 0;         //DESLIGA MOTOR
   return;
}

void cancelaSobe(void)
{
   while(PORTBbits.RB2 == 0)  //COLOCA CANCELA NO INICIO
   {
      PORTDbits.RD3 = 1;      //DESCE O MOTOR
      __delay_ms(250);
   }
   PORTDbits.RD3 = 0;         //DESLIGA MOTOR
   return;
}

void __interrupt() TrataInt(void)
{
   if(INTF == 1)
   {
        PORTDbits.RD4 = 1;          //Aciona SIRENE
        if(PORTBbits.RB3 == 0)      //VERIFICA CARRO NO TRILHO
        {
            cancelaDesce();         //CASO NÃO TENHA
        }
        else                        //CASO TENHA, ESPERA 20 SEGUNDOS PARA DESCER
        {
           __delay_ms(2000);      //Espera 20 seg para baixar cancela
            cancelaDesce();         //Aciona a descida da cancela
        }
        PORTDbits.RD4 = 0;          //desliga SIRENE
        __delay_ms(250);            //

        INTF = 0;
   }
   return;
}