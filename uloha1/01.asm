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
	jmp 0:start

start
	mov sp,7e00h
	xor ax,ax
	mov ss,ax
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
	mov cx,14
printLoop
	lodsb
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

	dec cx
	jnz printLoop
	jmp $

printDh
	mov bh,dh
	shr bh,4
  	mov al,bh
	call alToAscii
	stosw
	sal bh,4
	mov al,dh
	sub al,bh
	call alToAscii
	stosw
	ret

alToAscii
	cmp al,0Ah
	jae .letter
		add al,'0'
		ret
	.letter
		add al,'A'-0Ah
	ret

text db "SIDIBPSPIPCSDSESSSFLAXBXCXDX",0

times 1feh - ($ - $$) db 0
db 055h, 0aah
