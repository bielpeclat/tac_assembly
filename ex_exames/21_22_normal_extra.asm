VERIFICA_DIAGONAL proc
    push bx
    push cx
    push dx
    push di
    push si
    push bp

    mov bx, 0b800h
    mov es, bx

    ; ah -> linha
    ; al -> coluna
    ; si -> palavra, '$'

    ; registos livres: BX, CX, DX

    ; 1. obter o offset
    xor dx, dx
    mov dl, al
    shl dx, 1 ; dl contem o offset das colunas

    ; mov al, ah
    ; xor ah, ah
    ; mov bl, 160
    ; mul bl

    ; codigo melhor
    mov al, 160
    mul ah

    add ax, dx
    mov di, ax ; di contem o offset da primeira letra

    ; 2. comparar primeira letra
    mov al, [si]
    cmp al, es:[di]
    jne nao_encontrado

    inc si ; apontamos para o 'A' (t A c)

    mov cx, 4

reset:
    ; definir os valores iniciais
    mov bx, si ; palavra a partir da segunda letra
    mov bp, di ; offset inicial

    ; agora temos que ler a proxima letra, de acordo com alguma direcao

obter_letra:
    cmp cx, 4
    je cima_esq

    cmp cx, 3
    je cima_dir

    cmp cx, 2
    je baixo_dir

    ; baixo_esq
    add di, 158
    jmp verificar_letra_grid

cima_esq: 
    sub di, 162
    jmp verificar_letra_grid

baixo_dir:
    add di, 162
    jmp verificar_letra_grid

cima_dir:
    sub di, 158
    jmp verificar_letra_grid

verificar_letra_grid:
    mov al, [si]
    cmp al, '$'
    je encontrou

    cmp al, es:[di]
    jne letra_errada

    ; temos a letra correta na grid
    inc si
    jmp obter_letra

letra_errada:
    mov di, bp ; valor inicial
    mov si, bx ; segunda letra da palavra
    loop obter_letra

nao_encontrado:
    mov ah, 0
    jmp fim_reg

encontrou:
    mov ah, 1
    
fim_reg:
    pop bp
    pop si
    pop di
    pop dx
    pop cx
    pop bx

    ret
VERIFICA_DIAGONAL endp