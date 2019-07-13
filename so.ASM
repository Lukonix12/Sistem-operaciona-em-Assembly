org 0x7c00

jmp boot

boot:
mov si,texto
call printstr
mov si,texto1
call printstr
mov si,texto2
call printstr
mov ah,0x01
mov cx,0x07
int 0x10
mov ah,00h
int 16h
mov si,texto3
call printstr
mov si,texto4
call printstr
mov si,texto5
call printstr
mov si,texto6
call printstr
mov ah,00h
int 16h
   push    ax      ; store registers...
        push    ds      ;
        push    bx      ;
        push    cx      ;
        push    di      ;

        mov     ax, 40h
        mov     ds, ax  ; for getting screen parameters.
        mov     ah, 06h ; scroll up function id.
        mov     al, 0   ; scroll all lines!
        mov     bh, 1001_1111b  ; attribute for new lines.
        mov     ch, 0   ; upper row.
        mov     cl, 0   ; upper col.
        mov     di, 84h ; rows on screen -1,
        mov     dh, [di] ; lower row (byte).
        mov     di, 4ah ; columns on screen,
        mov     dl, [di]
        dec     dl      ; lower col.
        int     10h

        ; set cursor position to top
        ; of the screen:
        mov     bh, 0   ; current page.
        mov     dl, 0   ; col.
        mov     dh, 0   ; row.
        mov     ah, 02
        int     10h

        pop     di      ; re-store registers...
        pop     cx      ;
        pop     bx      ;
        pop     ds      ;
        pop     ax
        mov si,texto
        call printstr
        mov si,texto1
        call printstr
        mov si,texto2

        ret
jmp $

printstr:
lodsb
cmp al,0
jnz print
ret

print:
mov ah,0eh
int 10h
jmp printstr

texto db '/..............................................................///................................................................//............................................................................',13,10,0
texto1 db 'Pressione qualquer tecla para dar Boot...',13,10,0
texto2 db '.............../..............................//...............//....////....',13,10,0
texto3 db '=======================',13,10,0
texto4 db 'oxpOS!!',13,10,0
texto5 db '=======================',13,10,0
texto6 db 'Aperte qualquer tecla para reiniciar...',13,10,0

dw 0xAA55