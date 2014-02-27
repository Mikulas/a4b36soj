org 7c00h
	jmp 0:start

start:
	xor ax,ax ;set segments to known values
	mov sp,7e00h
	mov ss,ax
	mov ds,ax
	mov al,3 ;set VGA mode 80x25
	int 10h

	mov ax,0b800h
	mov es,ax

	cld

	; text setup
	xor di,di ;position - 0, left upper corner
	; mov ah,0fh ;color - bright white on black
	mov si,text
	call print

	; format setup
	mov di,1
	mov si,format
	call print

	jmp $ ;stop

write stosb
	inc di
print
	lodsb ;get character
	and al,al
	jnz write ;and all non-NULL values write to VRAM together with attribute byte
	ret

text db "Naprogamoval jsem to skvele",0
format db 0afh,0eh,0dh,0ch,0bh,0ah,09h,08h,07h,06h,05h,04h,03h,02h,01h,0

; bootsector
times 1feh - ($ - $$) db 0
db 055h, 0aah
