; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    
dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---


    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main~

