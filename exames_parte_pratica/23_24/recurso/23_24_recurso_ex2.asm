; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

getData proc
    push ax
    push bx
    push cx
    push dx
    push di
    push si
    push bp

    ; al -> linha
    ; ah -> coluna
    ; cl -> dimensao do quadrado
    ; si -> digitos (db)
    ; di -> outros  (db)

    ; no exercicio 2, uma das primeiras coisas q vamos fzr, e obter o offset.

    ; 1. obter offset do primeiro quadrado da grid 9x9
    ; offset = linha * 160 + coluna * 2         

    shl ah, 1 ; multiplicamos a coluna por 2
    mov bl, ah
    xor bh, bh ; bx contem o offset das colunas

    mov ah, 160
    mul ah ; ax = ah * al
    mov bp, ax ; bp contem o offset da celula
    add bp, bx

    xor ch, ch
    mov dl, cl ; vamos salvar a dimensao em dl

    ; 2. vamos precisar de 2 ciclos aninhados
    ; cx aqui tem 9

ext_loop: ; loop exterior
    push cx ; mandamos cx para a pilha, para iterar as linhas

    mov cl, dl ; temos cx com a dimensao para iterar as colunas
iterar_colunas:
    
    mov al, es:[bp] 
    ; al tem o caracter

    ; precisamos ignorar os espacos
    cmp al, ' '
    je prox_num

    cmp al, '0' ; lemos em ascii, e nao o valor normal
    jb add_outros
    
    cmp al, '9' ; o maior valor que pode conter
    ja add_outros

    ; aqui eu nao tenho certeza se era preciso (sub 30h) ou nao, penso que nao
    ; se chegamos ate aqui, temos um digito

    mov [si], al
    inc si
    jmp prox_num

add_outros:
    mov [di], al
    inc di

prox_num:

    add bp, 2 ; pulamos 2 bytes (prox coluna)
    loop iterar_colunas

    ; se chegamos aqui, ja excedemos 1 coluna, vamos para a proxima linha
    ; precisamos pular 142 bytes no caso do exercicio (tam = 9), mas, temos que tornar o codigo universalizavel, entao temos q encontrar a formula para isso

    ; offset_prox_linha = 160 - tamanho * 2

    mov bl, dl
    shl bl, 1 ;             tamanho * 2

    mov al, 160
    sub al, bl

    xor ah, ah

    add bp, ax ; pulamos para a prox linha

    pop cx ; buscamos na pilha o cx das linhas 
    loop ext_loop

    ; se chegamos aq, ja percorremos 9x9 celulas

    pop bp
    pop si
    pop di
    pop dx
    pop cx
    pop bx
    pop ax

    ret
getData endp