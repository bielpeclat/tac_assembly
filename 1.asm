; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

; criar um vetor com notas, de (0-20), e depois aumentar as notas em 1 valor, (ignorar caso a nota seja 20) 

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    vetor DB 12, 7, 11, 16, 9, 19, 20, 15, -1
    
dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor SI, SI
    
    ; comecamos o codigo
inicio:
    mov AL, vetor[SI]

    cmp AL, -1
    JE fim

    cmp AL, 20
    JAE proximo

    inc AL
    mov vetor[SI], AL

proximo:
   INC SI
   JMP inicio

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main