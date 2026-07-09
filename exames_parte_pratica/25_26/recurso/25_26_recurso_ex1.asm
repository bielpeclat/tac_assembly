; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    vetor1 db 'Eu gosto de queijo %'

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---

    ; ja adicionei ou pushs corretos

    xor si, si
    mov bl, 2
    mov bp, 160


ext_loop:

    mov al, es:[bp]
    cmp al, '*'
    mov dl, 'A'
    je verifica
    add bp, 2

    mov al, es:[bp]
    cmp al, '*'
    mov dl, 'B'
    je verifica
    add bp, 2

    mov al, es:[bp]
    cmp al, '*'
    mov dl, 'C'
    je verifica
    add bp, 2

    mov al, es:[bp]
    cmp al, '*'
    mov dl, 'D'
    je verifica

    ; se chegamos ate aqui, e um espaco em branco
    jmp errou

verifica:
    cmp dl, CHAVE[si]
    jne errou

    mov RESULTADOS[si], 'V'
    jmp prox_ite

errou:
    mov RESULTADOS[si], 'X'


prox_ite:
    inc si
    xor ah, ah
    mov al, 160
    mul bl
    inc bl
    mov bp, ax

    loop ext_loop

    ; ja adicionei os pop corretos

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main

