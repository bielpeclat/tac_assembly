; Gabriel Peclat dos Reis Costa, Eng. Inormática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    Frase1 db 'A  UC  (unidade  curricular)  de  TAC  (Tecnologias  e  Arquiteturas  de Computadores) vai ter uma taxa de aprovação elevada $'
    Frase2 db 255 dup (?)

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    
    ; 1. vamos zerar os registos que vamos usar de indices
    xor si, si ; source/ origem
    xor di, di ; destino
    xor bl, bl

iterar:
    mov al, Frase1[si]

    cmp al, '$' ; chegamos ao fim?
    je fim

    ; devemos nos perguntar
    ; quais sao os cenarios que vao mudar o fluxo do programa?

    cmp al, '(' ; entramos?
    je entramos

    cmp al, ')' ; saimos?
    je saimos

    ; como vamos saber se estamos dentro ou fora se lermos um caracter?
    ; podemos usar uma flag (BL)
    ; (bl = 0) ? estamos fora : estamos dentro

    cmp bl, 1
    je prox_iteracao ; estamos dentro de algum '(', logo nao vamos escrever :(

    ; se bl = 0, podemos escrever, uma vez que nao estamos dentro de nenhum '(' :)
    mov Frase2[di], al ; al ainda tem o caracter lido de Frase1[si]
    inc di ; avancamos 1 byte
    jmp prox_iteracao

entramos:
    mov bl, 1
    jmp prox_iteracao

saimos:
    mov bl, 0

prox_iteracao:

    inc si
    jmp iterar
    
    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov Frase2[di], '$'
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main

