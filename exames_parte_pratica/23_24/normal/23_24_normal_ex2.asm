; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

; o que vamos fazer? 
; obter um quadrado, e verificar todos os quadrados ao redor (nao e preciso fazer bound-check nos limites da grid 80x25)
; 1. obter o quadrado
; 2. ver se ele esta vazio
;       if nao estiver vazio, metemos um '*' la
;       else ele esta vazio, e vamos checar as outras cells ao redor dele (3x3)
; 3. obter o numero de bombas, e depois meter o valor (em ascii), no offset que recebemos

calcMinas proc
    push ax
    push bx
    push dx
    push di
    push si


    ; al -> linha
    ; ah -> coluna

    ; 1. vamos obter a celula central

    shl ah, 1 ; multiplicamos por 2
    mov bl, ah
    xor bh, bh ; bx tem o offset das colunas

    mov ah, 160
    mul ah
    add ax, bx
    mov di, ax ; DI tem o offset da celula central

    ; vamos ver se a celula central esta livre

    mov al, es:[di]
    cmp al, '*'
    jne nao_tem

    ; se estamos aqui, temos uma mina na celula central
    mov es:[di], 'M'
    mov es:[di+1], 01110000b ; texto branco, fundo preto, no blink
    mov cl, '*'

    jmp fim_reg

nao_tem:

    ; vamos usar o SI para verificar as outras celulas
    ; precisamos obter o offset para SI

    ; SI = DI - 162 (1 linha e 1 coluna)
    mov cx, 3
    mov si, di
    sub si, 162 ; si aponta para a primeira celula 3x3

    xor dl, dl ; vamos usar dl como contador de minas/ bombas

ext_loop:
    push cx
    mov cx, 3

iterar_colunas:
    mov al, es:[si]
    cmp al, '*'
    jne prox_iteracao
    inc dl

prox_iteracao:

    add si, 2 ; avancamos para a proxima celula
    loop iterar_colunas

    ; se chegamos aqui, precisamos mudar de linha

    add si, 154 ; 160 - tamanho da grid * 2
    
    pop cx ; buscamos o cx referente as linhas

    loop ext_loop ; loop das linhas, ao inves do loop das colunas

    ; se chegamos aqui, ja andamos 3x3 celulas
    ; dl e o contador

    mov cl, dl

    add dl, 30h
    mov es:[di], dl
    mov es:[di+1], 01110000b ; escrevero numero de minas em ascii

fim_reg:
    pop si
    pop di
    pop dx
    pop bx
    pop ax

    ret
calcMinas endp
