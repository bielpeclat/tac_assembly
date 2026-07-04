; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    Vetor1 db 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,'$'
    Vetor2 dw 6,7,8,9,10,11,12,20,30,40,50,60,70,80,2,3,5,8,'$'   

dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---

    xor di, di ; para o Vetor1
    xor si, si ; para o Vetor2
    mov cx, 18

repete:
    ; Vetor1
    mov al, Vetor1[di]
    inc al
    mov Vetor1[di], al
    inc di

    mov ax, Vetor2[di]
    inc ax
    mov Vetor2[si], ax
    add si, 2
    
    loop repete
    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main~

