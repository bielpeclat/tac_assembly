; Gabriel Peclat dos Reis Costa, Eng. Informática
; 2025140643, ISEC - PT

; melhoria do exercicio anterior

; calcular a media apenas dos alunos que passaram
; encontrar a melhor nota e guarda-la na variavel 'melhor_nota'
; guardar o ID do aluno com melhor nota na variavel 'melhor_aluno'

.8086
.model  small
.stack  2048

dseg    segment para public 'data'
    ; --- DEFINICAO DE VARIAVEIS ---
    alunos      dw 101, 102, 103, 104, 0
    notas       db 14,  8,   19,  7
    total       db 0                ; total de alunos
    reprovados  db 0
    media       dw 0                ; resultado da media
    n_passaram  db 0                ; divisor para calcular a media
    soma        dw 0                ; acumulador para media
    melhor_nota db 0                ; guardar valor da maior nota
    melhor_aluno dw 0               ; id do aluno com maior nota

dseg    ends

cseg    segment para public 'code'
    assume  cs:cseg, ds:dseg

main    proc
    ; Inicializacao do segmento de dados
    mov     ax, dseg
    mov     ds, ax

    ; --- O TEU CODIGO COMECA AQUI ---
    xor DI, DI ; usado para as notas
    xor SI, SI ; usado para os alunos

inicio:
    mov ax, alunos[SI]

    cmp ax, 0
    JE obter_media

    inc total

    ; vamos comparar as notas
    mov bl, notas[DI]

    cmp bl, melhor_nota
    JBE pulo1

    mov melhor_nota, bl

    mov ax, alunos[SI]
    mov melhor_aluno, ax

pulo1:

    cmp bl, 10
    jb add_reprovado

    ; adicionamos para a variavel acumuladora
    xor bh, bh
    add soma, bx
    inc n_passaram

    JMP proximo

add_reprovado:
    inc reprovados
    jmp proximo

proximo:
    add SI, 2
    inc DI
    jmp inicio

obter_media:

    cmp n_passaram, 0
    JE fim

    mov AX, soma
    mov BL, n_passaram
    div BL

    xor ah, ah
    mov media, ax

    JMP fim

    ; --- O TEU CODIGO TERMINA AQUI ---

fim:
    mov     ah, 4ch    ; Funcao para terminar o programa
    int     21h        ; Interrupcao do DOS
main    endp

cseg    ends
end     main~

