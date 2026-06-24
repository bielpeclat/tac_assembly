; percorrer vetor com 10 numeros
; se for impar -> substituir por 0            se for par -> multiplicar por 2
; guardar a quantidade de numeros alterados para 0 na variavel ContadorZeros
.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    vetor DB 1,2,3,4,5,6,7,8,9,10
    ContadorZeros DB 0
    
dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor SI, SI
    mov CX, 10

inicio:
   mov AL, vetor[SI]
   test AL, 1
   JZ par

   ; se for impar vai:
   mov AL, 0
   inc ContadorZeros
   mov vetor[SI], AL
   JMP proximo;

par:
   add AL, AL
   mov vetor[SI], AL
   JMP proximo

proximo:
   inc SI
   loop inicio

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main