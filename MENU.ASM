mess macro msg
mov ah, 09h
LEA dx, msg
int 21h
endm

.model small

.data
n1 db 00h
n2 db 00h									;declaring user define varialbes
n3 dw 0000h												
msg1 db 0Ah,0dh, "Menu->$"					;storing string in data segment
msg2 db 0Ah,0dh, "1.Addition$"
msg3 db 0Ah,0dh, "2.Subtraction$"
msg4 db 0Ah,0dh, "3.Multiplication$"
msg5 db 0Ah,0dh, "4.Exit$"
msg6 db 0Ah,0dh, "Enter your choice: $"
msg7 db 0Ah,0dh, "Enter 1st no.: $"
msg8 db 0Ah,0dh, "Enter 2nd no.: $"
msg9 db 0Ah,0dh, "Answer : $"

.code

mov ax,@data
mov ds,ax

start:

mess msg1
mess msg2
mess msg3
mess msg4
mess msg5
mess msg6

mov ah,01h
int 21h

sub al,30h
mov bl,al

cmp bl,01h
jz down1

cmp bl,02h
jz down2

cmp bl,03h
jz down3

cmp bl,04h
jz stop

down1 : call addition
jmp start

down2 : call subtraction
jmp start

down3 : call multiplication
jmp start

stop:
mov ah,4ch
int 21h

accept proc near

mov ah,01h						;instruction to input a single key press and storing hexa ascii in al
int 21h
cmp al,3ah						;comparing with 3ah to determine alpha or number 
jc down4
sub al,07h						;if alpha sub with 07h
down4 : and al,0fh				;then/else and with 0fh to get actual value not hexa ascii 
ret
endp


disp proc near

mov cl,bl						;moving bl to cl
and cl,0fh						;to get the units place
cmp cl,0ah						;comparing eith 0ah to determine no. or alpha
jc down5
add cl,07h						;if alpha add 07h
down5 : add cl,30h				;else/then add 30h to get hexa ascii
        mov dl,cl				;moving cl to dl: prerequisite for diaplay

mov ah,02h						;instruction to print content of dl
int 21h
ret
endp

addition proc near

mess msg7
call accept						;accepting a single digit
ror al,04h						;rotating the it by 4 bit
mov bl,al						;moving single digit to bl

call accept						;accepting a single digit
add bl,al
mov n1,bl

mess msg8
call accept						;accepting a single digit
ror al,04h						;rotating the it by 4 bit
mov bl,al						;moving single digit to bl

call accept						;accepting a single digit
add bl,al
mov n2,bl

mov cl,n1
add cl,n2
mov n1,cl

mess msg9
mov bl,n1

ror bl,04h						;rotating by 4 bit so tens place will be in ones
call disp						;displaying 1 digit

ror bl,04h						;rotating bl by 4bit to again get original value
call disp

ret
endp

subtraction proc near

mess msg7
call accept						;accepting a single digit
ror al,04h						;rotating the it by 4 bit
mov bl,al						;moving single digit to bl

call accept						;accepting a single digit
add bl,al
mov n1,bl

mess msg8
call accept						;accepting a single digit
ror al,04h						;rotating the it by 4 bit
mov bl,al						;moving single digit to bl

call accept						;accepting a single digit
add bl,al
mov n2,bl

mov cl,n1
sub cl,n2
mov n1,cl

mess msg9
mov bl,n1

ror bl,04h						;rotating by 4 bit so tens place will be in ones
call disp						;displaying 1 digit

ror bl,04h						;rotating bl by 4bit to again get original value
call disp

ret
endp

multiplication proc near

mess msg7
call accept						;accepting a single digit
ror al,04h						;rotating the it by 4 bit
mov bl,al						;moving single digit to bl

call accept						;accepting a single digit
add bl,al
mov n1,bl

mess msg8
call accept						;accepting a single digit
ror al,04h						;rotating the it by 4 bit
mov bl,al						;moving single digit to bl

call accept						;accepting a single digit
add bl,al
mov n2,bl

mov al,n1

mul n2

mov n3,ax

mess msg9
mov cx,n3						;moving qutiont to cx

mov bl,ch

ror bl,04h						;rotating by 4 bit so tens place will be in ones
call disp						;displaying 1 digit

ror bl,04h						;rotating bl by 4bit to again get original value
call disp						;displaying another digit

mov cx,n3						;again moving cx to n1 as cl is changing during diaplay

mov bl,cl						;displaying lower bit of cx

ror bl,04h
call disp

ror bl,04h
call disp

ret
endp

end
