procedimento_tac proc
    ; varios push

    ; al -> linha
    ; ah -> coluna
    ; bx -> palavra
    ; dl -> direcao
    
    ; vamos obter o offset inicial
    
    ; cx esta livre
    xor ch, ch
    mov cl, ah
    shl cl, 1 ; cx contem o offset das colunas

    mov ah, 160
    mul ah
    add ax, cx
    mov di, ax ; di contem o offset

    mov ah, 01110000b

obter_letra_vetor:
    mov al, [bx]
    cmp al, 0
    je fim_reg

    ; agora vamos escrever a letra
    mov es:[di], ax

    ; e andar para a direcao escolhida
    cmp dl 0
    je hor_dir

    cmp dl, 1
    je hor_esq

    cmp dl, 2
    je vert_cima

    ; ultimo caso, para baixo
    add di, 160
    jmp avancar_palavra

hor_dir: ; 0
    add di, 2
    jmp avancar_palavra

hor_esq:
    sub di, 2
    jmp avancar_palavra
    
vert_cima: ; 2
    sub di, 160
    jmp avancar_palavra

avancar_palavra:
    inc bx
    jmp obter_letra_vetor


fim_reg:
    ; varios pop

    ret
procedimento_tac endp