title CONTAR NÚMERO DE VOGAIS EM UM NOME
.MODEL SMALL
.DATA
    NOME DB "LUCAS KITSUTA SABINO"
.STACK 100H
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AX, 0
    MOV BX, 0
    MOV CX, 0
    MOV DX, 0
    
    CALL VOGAIS
    CALL IMPRIMIR

    MOV AH, 4CH
    INT 21H
MAIN ENDP

;CONTA QUANTAS VOGAIS HÁ EM UM NOME DE ATÉ 20 LETRAS E RETORNA ESSE NÚMERO EM DX
;ENDEREÇO DESSE NOME DEVE ESTAR NO REGISTRADOR SI
VOGAIS PROC
    PUSH BX
    PUSH CX
    PUSH SI

    MOV CX, 20
    XOR SI, SI

    FOR:
        MOV BL, NOME[SI]
        CMP BL, "A"
            JZ VOGAL
        CMP BL, "E"
            JZ VOGAL
        CMP BL, "I"
            JZ VOGAL
        CMP BL, "O"
            JZ VOGAL
        CMP BL, "U"
            JZ VOGAL
        JMP SAI
        VOGAL:
            INC DX
        SAI:
            INC SI
        LOOP FOR

    POP SI
    POP CX
    POP BX
    RET
VOGAIS ENDP

;IMPRIME O NÚMERO QUE ESTÁ REGISTRADO EM DX
IMPRIMIR PROC
    PUSH BX
    PUSH AX
    CMP DX, 9
    JLE MENORQUE9           ;SE DX FOR MENOR OU IGUAL A 9, NÃO CHAMA A FUNÇÃO
    MOV BX, DX              ;SE DX FOR MAIOR QUE 9, CHAMA A FUNÇÃO PARA IMPRIMIR NÚMEROS DECIMAIS
    CALL SAIDADECIMAL
    JMP FORA
    MENORQUE9:
        MOV AH, 2
        OR DX, 30H
        INT 21H
    FORA:
    POP AX
    POP BX
    RET
IMPRIMIR ENDP

SAIDADECIMAL PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH DI

    MOV DI, 10
    XOR CX, CX
    MOV AX, BX          ;PASSA O NUMERO A SER DIVIDIDO PARA AX
    
    OUTPUTDECIMAL:
        DIV DI              ;AX / DI    --> QUOCIENTE VAI PARA AX E RESTO VAI PARA DX
        PUSH DX
        XOR DX, DX
        INC CX
        OR AX, AX
        JNZ OUTPUTDECIMAL
    
    MOV AH, 2
    IMPRIMIRDECIMAL:
        POP DX
        OR DL, 30H
        INT 21H
        LOOP IMPRIMIRDECIMAL

    POP DI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
SAIDADECIMAL ENDP

END MAIN