.8086
.model small
.stack 2048

dados SEGMENT
    ; Vetores e variáveis 
    premio db 1, 5, 13, 25, 48, 6, 8
    aposta db 1, 9, 15, 25, 49, 6, 7
    numeros db 0
    estrelas db 0
    invalidos db 0

dados ENDS

CODIGO SEGMENT PARA PUBLIC 'code'
    ASSUME CS:CODIGO, DS:dados

main PROC
    ; Inicializa o segmento de dados
    mov ax, dados
    mov ds, ax
    
    ; --- O seu código de lógica entra aqui ---
    xor si, si
    
loop_numeros: ; numeros da aposta

    mov al, aposta[si] ; al = numero atual da aposta

    cmp al, 1
    jb num_inv

    cmp al, 50
    ja num_inv

    ; se chegamos aqui, a aposta atual e valida!
    ; iterar sobre os 5 numeros do premio

    xor di, di ; index do premio
    
loop_busca_num:

    cmp al, premio[di]
    je num_encontrado ; acertou com a aposta atual
    inc di
    cmp di, 5 ; esse valor e o index do vetor do premio
    jb loop_busca_num
    jmp prox_num
    
num_invalido:
    inc invalidos 
    jmp prox_num

num_acertou:
    inc numeros

prox_num: 
    inc si
    cmp si, 5
    jb loop_numeros

    ; aqui si ja vale 5, ou seja, primeira estrela
    
loop_estrelas:
    mov al, apostas[si] ; al = estrela atual da aposta

    cmp al, 1
    jb est_invalida
    cmp al, 12
    ja est_invalida

    ; se chegamos aqui, a estrela e valida
    mov di, 5

loop_busca_est:
    cmp al, premio[di]
    je est_acertou
    inc di
    cmp di, 7
    jb loop_busca_ent
    jmp prox_est

est_invalida:
    inc invalidos
    jmp prox_est

est_acertou:
    inc estrelas

prox_est:
    inc si
    cmp si, 7
    jb loop_estrelas
    


    ; Termina o programa e retorna ao DOS
    mov ah, 4ch
    int 21h
main ENDP

CODIGO ENDS
END main