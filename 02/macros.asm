; This waits for V-Blank or H-Blank so both OAM and display RAM are accessible
.MACRO WAITBLANK
	wait\@:
	ldh a,(<STAT)
	bit 1,a
	jr nz,wait\@
.ENDM

; Set VRAM0 or VRAM1 depending on the argument
.MACRO SETVRAM
	.IF NARGS != 1
		.FAIL
	.ENDIF
	.IF \1 == 0
		ld hl,VBK
		res 0,(hl)
	.ELSE
		ld hl,VBK
		set 0,(HL)
	.ENDIF
.ENDM

; Set RAM Bank
.MACRO SETRAM
	.IF NARGS != 1
		.FAIL
	.ENDIF
	ld a,\1
	ld (SVBK),a
.ENDM

