VERIFICA_MATRIZ proc

    push bx
    push cx
    push dx
    push si
    push di
    push bp

    ; vamos settar a memoria de video
    mov ax, 0b800h
    mov es, ax

    ; a grid 3x3 vai comecar no offset 0
    mov cx, 3 ; verificar as linhas
    mov di, 0
    xor dx, dx ; vamos usar o dx como bitmask
    xor bp, bp ; vamos usar bp para iterar com o bitmask
    xor ah, ah
    
ext_loop:
    push cx
    mov cx, 3

iterar_colunas:
    mov al, es:[di]

    cmp al, ' '
    je vazio

    ; comparar com dx
    sub al, 31h
    mov bp, 1
    push cx
    mov cl, al
    shl bp, cl
    pop cx

    test bp, dx
    jnz repetido

    ; aqui temos um numero novo
    or dx, bp

prox_iteracao:
    add di, 2
    loop iterar_colunas

    ; agora precisamos mudar de linha
    add di, 154
    pop cx
    loop ext_loop

    ; ja iteramos 3x3 vezes
    mov ah, 1
    jmp fim_reg

vazio:
    pop cx
    mov ah, -1
    jmp fim_reg

repetido:
    pop cx
    mov ah, 0

fim_reg:
    pop bp
    pop di
    pop si
    pop dx
    pop cx
    pop bx

    ret 
VERIFICA_MATRIZ endp