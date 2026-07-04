; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    letras db 'Ola malta', 0
   
dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---

    xor di, di

repete:
    mov al, letras[di]
    cmp al, 0
    je fim

    cmp al, 'a'
    jb proximo ; menor que 'a'

    cmp al, 'z'
    ja proximo ; maior que 'z'

    cmp al, 'z'
    je especial ; igual a 'z'

    inc al
    mov letras[di], al
    jmp proximo


proximo:
    inc di
    jmp repete

especial:
    mov al, 'a'
    mov letras[di], al
    jmp proximo
    
    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main~

