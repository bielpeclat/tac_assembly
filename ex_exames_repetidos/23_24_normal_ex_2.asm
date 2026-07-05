calcMinas proc
    ; adicionar os pushes

    ; 1. obter a posicao com base nas linhas e colunas passadas
    ; al -> linha
    ; ah -> coluna

    ; offset = linha * 160 + coluna * 2
    xor cx, cx
    xor bx, bx
    mov bl, ah
    shl bx, 1 ; agora bx tem o offset referente as colunas

    mov ah, 160
    mul ah
    add ax, bx
    mov di, ax ; agora di tem a posicao correta na "grid"

    
    ; adicionar os pops
    
    ret
calcMinas endp