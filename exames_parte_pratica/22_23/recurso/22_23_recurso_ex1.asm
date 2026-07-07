; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    v db 5, 65, 1, 2, 3, 4
    max db 0
    min db 255

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor si, si ; vamos usar para indexar o vetor v
    xor ch, ch ; apagar lixo

    mov cl, v[si] ; cx tem a quantidade de numeros
    inc si        ; vamos para o "primeiro" numero

iterar:
    mov al, v[si]
    cmp al, max ; numero atual
    jbe verifica_min
    mov max, al
    
verifica_min:
    cmp al, min
    jae prox_num
    mov min, al

prox_num:
    inc si ; avancamos 1 byte, dado que é um vetor de bytes
    loop iterar ; vamos realizar esse salto CX vezes

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main

