; a4b36soj Mikulas Dite uloha1
org 7c00h
	push dx
	push cx
	push bx
	push ax
	pushf
	push ss
	push es
	push ds
	push cs
	push $$ ;ip
	push sp
	push bp
	push di
	push si
	jmp 0:starter

starter xor ax,ax
	mov ds,ax
	mov al,3
	int 10h
	cld

	mov ax,0b800h
	mov es,ax

	xor di,di
	mov ax,text
	mov si,ax

	mov ah,09h
cycleAx lodsb
	stosw
	lodsb
	stosw
	mov al,':'
	stosw

	pop dx
	call printDh
	mov dh,dl
	call printDh
	mov al,' '
	stosw

	add ah,9h

	cmp di,0e0h
	jb cycleAx
	jmp $

printDh mov bh,dh
	shr bh,4
  	mov al,bh
	call printAl
	sal bh,4
	mov al,dh
	sub al,bh
printAl add al,'0'
	cmp al,0Ah + '0'
	jb .end
            add al,7h
   .end stosw
	ret

text db "SIDIBPSPIPCSDSESSSFLAXBXCXDX",0

times 1feh - ($ - $$) db 0
db 055h, 0aah
