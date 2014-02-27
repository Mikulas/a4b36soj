;  todo
;pushe
;callfar
;pushe
;potom pop
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
	xor ax,ax ;set segments to known values
	; mov sp,7e00h
	; mov ss,ax
	mov ds,ax
	mov al,3 ;set VGA mode 80x25
	int 10h
	cld
	xor di,di

	mov ax,text
	mov si,ax

	mov ax,0b800h
	mov es,ax

	mov ah,0f1h

	mov cx,14 ;counter
printLoop
	lodsb ;load first byte of label to al
	stosw ;store full ax
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

	dec cx
	jnz printLoop
	jmp $

printDh
  ;set al to top 4 bits of dh
	mov bh,dh
	shr bh,4
  ;print higher 4 bits
  	mov al,bh
	call alToAscii
	stosw ;store ax in es:di
  ;print lower 4 bits
	sal bh,4
	mov al,dh ; 100011b
	sub al,bh ;-100000b get lower 4 bits of dh
	call alToAscii
	stosw ;store ax in es:di
	ret

alToAscii
	cmp al,0Ah
	jae .letter
		add al,'0'
		ret
	.letter
		add al,'A'-0Ah
	ret

times 200h - 60 - ($ - $$) db 0
text db "SIDIBPSPIPCSDSESSSFLAXBXCXDX",0 ;7dc4

;bootsector
times 1feh - ($ - $$) db 0
db 055h, 0aah
