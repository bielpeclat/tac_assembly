calcMinas proc
    push ax
    push bx
    push di
    push si

    ; vamos calcular o offset inicial
    ; al -> linha
    ; ah -> coluna
    xor bh, bh
    mov bl, ah
    shl bl, 1 ; agora bx contem o offset das colunas

    mov ah, 160
    mul ah
    add ax, bx
    mov di, ax ; di tem o offset central

    ; vamos verificar se a celula central e uma mina
    mov ax, es:[di]
    cmp al, '*'
    jne grid_proc
    mov cl, al
    mov al, 'M'
    mov es:[di], al
    jmp fim_reg
    

grid_proc:    
    mov si, di
    sub si, 162 ; agora si aponta para o inicio da grid 3x3

    xor bl, bl
    mov cx, 3

ext_loop:
    push cx
    mov cx, 3

iterar_colunas:
    mov ax, es:[si]
    cmp al, '*'
    jne saltar
    inc bl ; no fim vamos mudar de bl para cl

saltar:
    add si, 2
    loop iterar_colunas

    ; temos que mudar de linha
    pop cx
    add si, 154
    loop ext_loop

    ; ja iteramos 3x3 vezes
    mov cl, bl

    ; agora, vamos botar no centro o numero de minas adjacentes
    ; pegadinha aqui: cl tem o valor normal, queremos em ascii
    ; 3 = 33h ∴ temos que: add bl, 30h
    add bl, 30h
    mov es:[di], bl

fim_reg:
    pop si 
    pop di
    pop bx
    pop ax
    
    ret
calcMinas endp