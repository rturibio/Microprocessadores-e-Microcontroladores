#include <P16F877A.INC> 	; Arquivo de include do uC usado, no caso PIC16F877A

#define f 0
#define d 0
    
    #define add1 0
    #define add2 0
;Palavra de configura??o, desabilita e habilita algumas op??es internas


  __CONFIG  _CP_OFF & _CPD_OFF & _DEBUG_OFF & _LVP_OFF & _WRT_OFF & _BODEN_OFF & _PWRTE_OFF & _WDT_OFF & _XT_OSC

;***** defini??o de Vari?veis  *****************************
;cria constantes para o programa

  	cblock 0x20
		tempo		
		tempo1			; Vari?veis usadas na rotina de delay.
	endc 




;******** Vetor de Reset do uC**************

 org 0x00		                ; Vetor de reset do uC.
 goto inicio		            ; Desvia para o inicio do programa.


;***************** cria??o de subrotinas******************************************
Delay:
   movlw	0xFF	   ; Carrega 255 em W
   movwf	tempo      ; Passa o 255 de W para a vari?vel tempo
   

denovo:   movlw    0xFF     ;carrega 255 em W
          movwf	   tempo1   ;Passa o 255 de W para a vari?vel tempo1
          decfsz   tempo,F  ;dec 1 unidade tempo e pula se zero
          goto     repete  
          goto     sai  
           
repete:    
          decfsz   tempo1,F
          goto     repete
          goto     denovo
sai:
 Return
 
 ligaled:
    bsf PORTC,4
    call Delay
    call Delay
    bcf PORTC,4
    goto loop
 return
 
 E1:
        
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    goto E1
    
 return
 
 E2:
    
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
     
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    ;call ligaled
    
    goto E2
 return
 
 E3:
    
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    goto E3
 return
 
 E4:
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    goto E4
 return
 
 E5:
    
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    goto E5
 return
 
 E6:
    
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    goto E6
 return
 
 E7:
    
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    goto E7
 return
 
 E8:
    
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    goto E8
 return
 
 E9:
    
  
    bsf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bsf PORTD,3
    call Delay
   
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    
    goto E9
 return
;****************** Inicio do programa *****************************************

inicio:
    
	clrf	PORTA		; Inicializa os Port's. Coloca todas pinos em 0.
	clrf	PORTB
	clrf	PORTC
	clrf	PORTD
	clrf	PORTE

	banksel	TRISA		; Seleciona banco de mem?ria 1
	
	movlw	0x1f
	movwf   TRISB		; Configura PortA (A0,A1,A2,A3,A4 = Entradas, A5 = Sa?da).
	;movlw	0xff		; 1111 1111   1 = Input   0 = Output
	;movwf	TRISB		; Configura PortB como entrada.
	;movlw	0x6f
	movlw	0x00
	movwf	TRISC		; Configura PortC (C4,C7 = Sa?das, C0,C1,C2,C3,C5,C6 = Entradas).
	movlw	0x00
	movwf	TRISD		; Configura PortD como sa?da.
	movlw	0x07
	movwf	TRISE		; Configura PortE como entrada e desliga Posta Paralela.

	movlw	0x00
	movwf	OPTION_REG	; Configura Op??es:
				; Pull-Up habilitados.
				; Interrup??o na borda de subida do sinal no pino B0.
				; Timer0 incrementado pelo oscilador interno.
				; Prescaler WDT 1:1.
				; Prescaler Timer0 1:2.

	movlw	0x90
	movwf	INTCON		; Habilita interrup??o RB0.

	movlw	0x00
	movwf	PIE1		; Desabilita interrup??es perif?ricas.

	movlw	0x00
	movwf	PIE2		; Desabilita interrup??es perif?ricas.

	movlw	0x07
	movwf	ADCON0		; Desliga conversor A/D, PortA e PortE com I/O digital.

	movlw	0x07
	movwf	CMCON		; Desliga comparadores internos.

	movlw	0x00
	movwf	CVRCON		; Desliga m?dulo de ref?rencia interna de tens?o.

	clrf f	
	clrf d
	banksel PORTA		; Seleciona banco de mem?ria 0.
	
    

;*********************** Loop principal ****************************************
loop: 
    
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1     ;RB1 foi para 0, ou seja, foi acionada?
    goto    up             ;Mantem piscando  
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,2     ;RB1 foi para 0, ou seja, foi acionada?
    goto    down             ;Mantem piscando
    
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,3     ;RB1 foi para 0, ou seja, foi acionada?
    goto    enter             ;Mantem piscando
    
    ;movf    PORTB,W	    ;Le o PortB.
   ; btfss   PORTB,4     ;RB1 foi para 0, ou seja, foi acionada?
    ;goto    pulse             ;Mantem piscando
    
    
    goto loop
    
    up:
    goto um
    
    
    down:
    
    goto loop
    
    enter:
    
    goto loop
    
    ;pulse:
    
    ;goto loop
    
    um:
    
    bsf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto dois
    btfss PORTB,2
    goto zero
    btfss PORTB,3
    call E1
    goto um
    
    
    dois:
    bcf PORTD,0
    bsf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto tres
    btfss PORTB,2
    goto um
    btfss PORTB,3
    call E2
    goto dois
    
    
    tres:
    bsf PORTD,0
    bsf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto quatro
    btfss PORTB,2
    goto dois
    btfss PORTB,3
    call E3
    goto tres
    
    quatro:
    bcf PORTD,0
    bcf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto cinco
    btfss PORTB,2
    goto tres
    btfss PORTB,3
    call E4
    goto quatro
    
    cinco:
    bsf PORTD,0
    bcf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto seis
    btfss PORTB,2
    goto quatro
    btfss PORTB,3
    call E5
    goto cinco
    
    seis:
    bcf PORTD,0
    bsf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto sete
    btfss PORTB,2
    goto cinco
    btfss PORTB,3
    call E6
    goto seis
    
    sete:
    bsf PORTD,0
    bsf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto oito
    btfss PORTB,2
    goto seis
    btfss PORTB,3
    call E7
    goto sete
    

    oito:
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bsf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto nove
    btfss PORTB,2
    goto sete
    btfss PORTB,3
    call E8
    goto oito
    
    nove:
    bsf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bsf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto zero
    btfss PORTB,2
    goto oito
    btfss PORTB,3
    call E9
    goto nove
    
    zero:
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,1
    goto um
    goto zero
    
    cum:
    
    bsf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cdois
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cum
    goto ligaled     
    
    cdois:
    bcf PORTD,0
    bsf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto ctres
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cdois
    goto ligaled       
    
    ctres:
    bsf PORTD,0
    bsf PORTD,1
    bcf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cquatro
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto ctres
    goto ligaled
    
    cquatro:
    bcf PORTD,0
    bcf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto ccinco
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cquatro
    goto ligaled
    
    ccinco:
    bsf PORTD,0
    bcf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cseis
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto ccinco
    goto ligaled
    
    cseis:
    bcf PORTD,0
    bsf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto csete
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cseis
    goto ligaled
    
    csete:
    bsf PORTD,0
    bsf PORTD,1
    bsf PORTD,2
    bcf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto coito
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto csete
    goto ligaled    

    coito:
    bcf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bsf PORTD,3
    call Delay
    ;call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cnove
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto coito
    goto ligaled 
    
    cnove:
    bsf PORTD,0
    bcf PORTD,1
    bcf PORTD,2
    bsf PORTD,3
    call Delay
    call Delay
    movf    PORTB,W	    ;Le o PortB.
    btfss   PORTB,4
    goto cnove
    goto ligaled
    
    end			    ; Fim do Programa.