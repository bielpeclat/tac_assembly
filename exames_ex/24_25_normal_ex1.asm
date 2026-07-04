.8086
.model small
.stack 2048

dados SEGMENT
    ; Vetores e variáveis (Defina os tipos adequados, ex: db para bytes, DW para words)
    turma       db 10, 9, 19, 11, 5, 20, 22, 28, 24, 13, 3, 23, 8, 16, 4, 7, 1, 12, 0
    alunos      db 24, 4, 7, 12, 1, 13, 0
    notas       db 19, 10, 12, 10, 19, 11
    
    total       db 0
    passados    db 0
    reprovados  db 0
    media       db 0
    melhoraluno db 0
    melhornota  db 0
dados ENDS

CODIGO SEGMENT PARA PUBLIC 'code'
    ASSUME CS:CODIGO, DS:dados

main PROC
    ; Inicializa o segmento de dados
    mov ax, dados
    mov ds, ax
    
    ; --- O seu código de lógica entra aqui ---
    xor si, si
    xor bx, bx

    ; primeiro vamos obter o total de alunos, total que passaram, e o total de chumbaram
inicio_total:
    mov al, turma[si]
    cmp al, 0
    je fim_total
    inc bl ; quantidade total
    inc si ; index (i++)
    jmp inicio_total

fim_total:
    mov total, bl
    xor si, si
    xor bl, bl

    jmp inicio_passados
    
inicio_passados: 
    mov al, alunos[si]
    cmp al, 0
    je fim_passados

    inc bl ; quantidade que passaram
    inc si ; index (i++)
    jmp inicio_passados

fim_passados:
    mov passados, bl
    xor si, si
    
    ; bl tem a quantidade de alunos que passaram
    ; vamos obter a quantidade de reprovados
    mov al, total
    sub al, bl
    mov reprovados, al

    ; agora vamos calcular a media

    xor si, si
    xor ax, ax
    mov cx, passados
acumulador:
    xor bx, bx
    mov bl, notas[si]

    add ax, bx
    inc si

    loop acumulador

    mov bl, passados
    div bl

    mov media, al

    ; agora precisamos obter o melhor aluno e a melhor nota
    xor si, si
    mov cx, passados
comparar:
    mov al, notas[si]
    cmp al, melhornota
    jbe proximo
    mov melhornota, al
    mov bl, alunos[si]
    mov melhoraluno, bl
    jmp proximo

proximo:
    inc si
    loop comparar

    
    ; Termina o programa e retorna ao DOS
    mov ah, 4ch
    int 21h
main ENDP

CODIGO ENDS
END main