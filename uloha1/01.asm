; a4b36soj Mikulas Dite uloha1
; jmp $
org 7c00h
	call pushIp ;saves ip+call
pushIp  push sp ;saves sp+2
	push bp
	push dx
	push cx
	push bx
	push ax
	pushf
	push ss
	push es
	push ds
	push cs
	push di
	push si
	jmp 0:start

start xor ax,ax
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

	mov bx,2
printDh mov bh,dh
	dec bx
	shr bh,4
  	mov al,bh

  	mov cx,2
	printAl add al,'0'
		cmp al,0Ah + '0'
		jb .end
	            add al,7h
	   .end stosw

	sal bh,4
	mov al,dh
	sub al,bh

	loop printAl


	mov dh,dl
	and bx,bx
	jnz printDh


	mov al,' '
	stosw

	add ah,9h

	cmp di,0e0h
	jb cycleAx
	jmp $

text db "SIDICSDSESSSFLAXBXCXDXBPSPIP",0

times 1feh - ($ - $$) db 0
db 055h, 0aah
