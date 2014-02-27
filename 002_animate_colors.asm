org 7c00h
	jmp 0:start

start
	xor ax,ax ;set segments to known values
	mov sp,7e00h
	mov ss,ax
	mov ds,ax
	mov al,3 ;set VGA mode 80x25
	int 10h
	cld

	mov ax,0b800h
	mov es,ax

	;text setup
	xor di,di
	mov ah,0eh
	mov si,text
	call print

	;animate colors
	mov ax,0b800h
	mov ss,ax
	mov ds,ax
	mov si,1
	mov di,1

animate
	lodsw
	cmp al,0fh
	jae .else
		inc al
		jmp .endif
	.else
		mov al,03h
	.endif
	stosb ;saves al to es:di

	call delay

	;start over from start if end reached
	and ah,ah ;text field
	inc di
	jnz animate
	mov si,1
	mov di,1
	jmp animate

write stosw
print
	lodsb

	cmp ah,03h ;skip dark colors
	jb .else
		dec ah
		jmp .endif
	.else
		mov ah,0fh
	.endif
	and al,al
	jnz write
	ret

text db "Naprogramoval jsem to skvele!",0

delay
	mov cx,800
	tick dec cx
	and cx,cx
	jnz tick
	ret

;bootsector
times 1feh - ($ - $$) db 0
db 055h, 0aah
