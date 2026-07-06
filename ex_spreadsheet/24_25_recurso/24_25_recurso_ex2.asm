; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    notas db 10,12,8,15,16,20,19,3,13,14,0,11,10,17,7,'$'

    cont_ins db 0
    cont_suf db 0
    cont_mb  db 0
    cont_exc db 0
    linha    db 5

    letras_categorias db 'I', 'S', 'M', 'E'

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
end     main


; ###################################################################################
; i. criacao do procedimento CLassificarNotas

ClassificarNotas proc ; apenas iterar o array, e aumentar os contadores
    ; adicionar push

    xor si, si

obter_num:
    mov al, notas[si]
    cmp al, '$'
    je fim_reg ; verificar fim

    cmp al, 9
    jbe add_ins

    cmp al, 13
    jbe add_suf

    cmp al, 18
    jbe add_mb

    inc cont_exc
    jmp prox_nota

add_ins:
    inc cont_ins
    jmp prox_nota

add_suf:
    inc cont_suf
    jmp prox_nota

add_mb:
    inc cont_mb
    jmp prox_nota

prox_nota:
    inc si
    jmp obter_num

fim_reg:
    ; adicionar pop
    ret
ClassificarNotas endp





; ###################################################################################
; implementacao do procedimento EscreveLetra

EscreveLetra proc
    ; adicionar push
    
    ; si tem o caracter atraves do vetor das 4 opcoes
    ; bl tenha a linha (indexado em 1, e nao 0) onde devemos escrever o caracter

    ; 1. precisamos do offset para escrever a letra
    ; offset = linha * 160
    mov al, bl
    dec al
    mov ah, 160
    mul ah
    mov di, ax

    ; 2. obter a letra que vamos escrever
    mov al, letras_categorias[si]
    
    mov ah, 01110000b ; definir a cor do texto e do fundo, com blink = 0

    ; 3. escrita na memoria de video da letra
    mov es:[di], ax
    
    ; adicionar pop
    ret
EscreveLetra endp





; ###################################################################################
; implementacao do procedimento DesenhaBarraSimples

