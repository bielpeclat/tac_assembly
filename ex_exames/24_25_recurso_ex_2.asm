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

ClassificarNotas proc
    push si
    push al

    xor si, si ; zerar o si para ser o index

repete:
    mov al, notas[si]
    cmp al, 0
    je fim_CN

    cmp al, 9
    jbe insu
    cmp al, 13
    jbe suf
    cmp al, 18
    jbe mb
    
    inc exc
    jmp prox_nota

insu:
    inc cont_insu
    jmp prox_nota

suf:
    inc cont_suf
    jmp prox_nota

mb:
    inc cont_mb
    jmp prox_nota

prox_nota:
    inc si
    jmp repete


fim_CN
    pop al
    pop si
    ret
ClassificarNotas endp

EscreveLetra proc ; 
    push ax
    push di

    mov al, 160
    mul bl ; ax = 160 * 5 = 800
    mov di, ax

    mov al, letras_categorias[si]
    mov ah, 0Fh

    mov es:[di], ax ; escrevemos letra e cor juntos

    pop di
    pop ax
    ret
EscreveLetra endp

DesenhaBarraSimples proc
    ; bl vai receber q quantidade de notas desse tipo
    ; a variavel linha recebe a linha para imprimir os 'X'

    ; offset = (linha * 160) + (coluna * 2)
    xor ax, ax

    mov al, 160
    mov cl, linha
    mul cl ; ax = 160 * 5 = 800
    add ax, 2 ; pular a primeira coluna, uma vez que ela ja tem as letras
    ; agora, ax = offset

    mov di, ax ; di passa a conter o offset

    mov al, 'X'
    mov ah, 0Fh

    xor cx, cx
    mov cl, bl

imprimir:
    mov es:[di], ax
    add di, 2
    loop imprimir



    ret
DesenhaBarraSimples endp

cseg    ends
end     main

