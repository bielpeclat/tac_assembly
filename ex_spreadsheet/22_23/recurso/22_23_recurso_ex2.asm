; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

VERIFICA_MATRIZ
    push bx
    push cx
    push dx
    push di
    push es

    ; por em ah 1 caso esteja correto
    ; 0 -> mal preenchido
    ; -1 -> espacos em branco

    mov ax, 0b800h
    mov es, ax

    xor dx, dx
    xor ah, ah
    xor bx, bx ; vamos usar o BX para ser a nossa bitmask
    xor di, di ; offset inicial dos 80x25
    mov cx, 3

ext_loop:

    push cx
    mov cx, 3

iterar_colunas:

    mov al, es:[di]
    cmp al, ' ' ; vamos ver se não é um espaço
    je nao_pre

    cmp al, '1'
    jb mal_pre

    cmp al, '9'
    ja mal_pre

    ; ate aqui, so fizemos verificacoes de seguranca
    ; se chegamos aqui, temos um valor valido na celula atual

    push cx
    sub al, 30h ; obtemos o valor numerico, ao inves da tab. ascii

    mov dx, 1 ; vamos usar a nossa bitmask

    mov cl, al ; vamos usar no SHL, CL
    shl dx, cl
    pop cx     ; apenas podemos usar cl no SHL, por isso esses push e pop!!!!!

    test bx, dx ; vamos comparar esses dois, bit a bit, estamos a fazer um AND
    ; dx contem apenas 1 bit ativo

    jnz mal_pre ; encontramos valores repetidos

    ; se chegamos aqui, temos um numero que ainda nao foi registado na bitmask
    or bx, dx ; adicionamos o numero novo para BX

    add di, 2
    loop iterar_colunas

    ; se chegamos aqui, ja iteramos 3 vezes, temos que ir para a proxima linha
    add di, 154
    pop cx
    loop ext_loop

    ; se chegamos aqui, ja verificamos tudo

    mov ah, 1
    jmp fim_reg

nao_pre:
    pop cx
    mov ah, -1
    jmp fim_reg

mal_pre:
    pop cx
    mov ah, 0
    jmp fim_reg


fim_reg:
    pop es
    pop di
    pop dx
    pop cx
    pop bx

    ret
VERIFICA_MATRIZ