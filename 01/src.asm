org 7c00h
jmp 0:start ;far automaticky podle dvojtecky

start:
mov word [0],'A' + (7<<8)
mov word [2],'A' + (7<<8)
mov word [4],'A' + (7<<8)
mov word [6],'A' + (7<<8)
mov word [8],'A' + (7<<8)
mov word [10],'A' + (7<<8)

end:
jmp $ ;infinite loop, $ je current address

; bootsector
times ((0x200 - 2) - ($ - $$)) db 0x00
dw 0xAA55 ; these must be the last two bytes in the boot sector
