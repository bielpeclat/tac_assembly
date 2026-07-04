; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

; copiar a string1 para  a string 2, removendo o tudo que esta dentro dos parentes

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    string1 db 'Eu (oi) sou o Pedro Afonso (isso e mentira)', 0
    string2 db 255 dup (?)
    
dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI --

    xor di, di ; string1
    xor si, si ; string2
    xor cl, cl

repete:
    mov al, string1[di]

    cmp al, 0
    je fim ; verificar se e o fim

    cmp al, '('
    je entrar

    cmp al, ')'
    je sair

    cmp cl, 1
    je proximo

    mov string2[si], al
    inc si
    jmp proximo

entrar:
    mov cl, 1
    jmp proximo

sair:
    mov cl, 0
    jmp proximo

proximo:
    inc di
    jmp repete

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov string2[si], 0
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main~

