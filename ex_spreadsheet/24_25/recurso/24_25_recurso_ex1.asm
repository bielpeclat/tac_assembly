; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    String1 db 'Meu (apelido) nome e Gabriel (Pedro)', 0
    String2 db 255 dup (?)

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor si, si
    xor di, di
    xor bl, bl

obter_letra:
    mov al, vetor1[si]
    cmp al, 0
    je fim

    cmp al, '('
    je entramos

    cmp al, ')'
    je saimos

    cmp bl, 1
    je pular

    ; se chegamos ate aqui, temos um caracter valido
    mov vetor2[di], al
    inc si
    inc di
    jmp obter_letra

entramos:
    inc si
    mov bl, 1
    jmp obter_letra

saimos:
    inc si
    mov bl, 0
    jmp obter_letra

pular:
    inc si
    jmp obter_letra

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov String2[di], 0
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main

