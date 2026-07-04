.8086
.model small
.stack 2048
DATA_HERE SEGMENT
    ; inserir variaveis aqui
    vetor db 1, 6, 3, 0
    maior db 0
    menor db 255
    diferenca db 0
    
DATA_HERE ENDS
CODE_HERE SEGMENT
    ASSUME CS:CODE_HERE, DS:DATA_HERE
START:mov ax, DATA_HERE
    mov ds, ax
    ; inserir codigo aqui
    xor di, di

obter_numero:
    mov al, vetor[di]
    cmp al, 0
    je obter_diferenca

    cmp al, maior
    jbe verifica_menor
    mov maior, al

verifica_menor:
    cmp al, menor
    jae proximo
    mov menor, al

proximo:
    inc di
    jmp obter_numero

obter_diferenca:
    mov al, maior
    sub al, menor
    mov diferenca, al
    

    mov ah,4ch
    int 21h
CODE_HERE ENDS
END START