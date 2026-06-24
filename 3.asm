; vetor com 5 idades, vetor desconto com 5 indices, se idade[SI] for >= 65, desconto[SI] = 1, 0 c.c.

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    idades db 18, 67, 69, 23, 44
    desconto db 5 dup (?)
    
dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor SI, SI
    mov CX, 5

inicio:
    mov al, idades[SI]
    cmp al, 65

    JAE maior

    mov desconto[SI], 0
    JMP proximo


maior:
    mov desconto[SI], 1
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