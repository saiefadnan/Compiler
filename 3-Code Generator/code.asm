.model small
.stack 100h
.data
a dw ?
c dw ?
d dw ?
t1 dw ?
t2 dw ?
t3 dw ?
t4 dw ?
t5 dw ?
.code
MAIN PROC
    MOV ax, @data
    MOV ds, ax

    MOV ax, 10
    MOV a, ax

    MOV ax, 5
    MOV c, ax

    MOV ax, c
    MOV bx, 2
    MUL bx
    MOV t1, ax

    MOV ax, a
    MOV bx, t1
    ADD ax, bx
    MOV t2, ax

    MOV ax, t2
    MOV bx, 12
    SUB ax, bx
    MOV t3, ax

    MOV ax, t3
    MOV d, ax

    MOV ax, a
    MOV bx, c
    SUB ax, bx
    MOV t1, ax

    MOV ax, 2
    MOV bx, 3
    SUB ax, bx
    MOV t2, ax

    MOV ax, t2
    MOV ax, t3
    MOV bx, 5
    MUL bx
    MOV t4, ax

    MOV ax, t1
    MOV bx, t4
    SUB ax, bx
    MOV t5, ax

    MOV ax, t5
    MOV d, ax

MAIN ENDP
END MAIN
