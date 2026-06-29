; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    vetor db 13, 5, 25, 0
    maior db 0
    menor db 255
    resultado db 0
    
dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor di, di ; zeramos di

repete:
    mov al, vetor[di] ; obter o valor do index atual

    cmp al, 0 ; verificar fim
    je res

    cmp al, maior
    ja e_maior

    cmp al, menor
    jb e_menor

    jmp proximo

e_maior:
    mov maior, al
    jmp proximo

e_menor:
    mov menor, al
    jmp proximo

proximo:
    inc di
    jmp repete

res:
    mov bl, menor
    mov al, maior
    sub al, bl

    mov resultado, al
    jmp fim

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main~

