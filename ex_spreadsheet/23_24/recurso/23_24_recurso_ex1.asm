; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    vetor1 db 29,2,6,10,12,25,7,11,100,23
    vetor2 db 10 dup (?)

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor ah, ah
    mov dl, 0

    xor si, si ; vetor1
    xor di, di ; vetor2

obter_num:
    cmp dl, 10 ; e nos dito q o tamanho e 10
    je fim

    mov al, vetor1[si]

    cmp al, 1
    jbe prox_num ; 1 ou menos

    cmp al, 2 ; caso seja 2
    je e_primo

    mov bl, 2

    ; se for 3 ou mais
divisoes: 
    xor ah, ah

    div bl ; al -> resultado            ah -> resto
    cmp ah, 0  ; se o resto foi 0, o numero e divisel, loog nao e primo

    je prox_num ; o numero nao e primo

    inc bl ; aumentar o divisor em 1
    cmp bl, vetor1[si] ; verificar se chegamos no numero
    je e_primo

    mov al, vetor1[si] ; obtemos o msm numero novamente para verificar com um divisor 1 unidade maior
    jmp divisoes
    
e_primo:
    mov al, vetor1[si] ; como al tinha o resto da divisao passada, temos q buscar o valor novamente
    mov vetor2[di], al
    inc di

prox_num:
    inc si ; index do vetor1 (source/ origem)
    inc dl ; contador ate 10 de seguranca
    jmp obter_num
 
    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main~

