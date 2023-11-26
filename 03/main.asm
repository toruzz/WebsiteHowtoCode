; ****************************************
; *** DEFINITIONS & ROM INITIALIZATION ***
; ****************************************

.MEMORYMAP
    DEFAULTSLOT 1
    SLOTSIZE $4000
    SLOT 0 $0000
    SLOT 1 $4000
.ENDME

.ROMBANKSIZE $4000
.ROMBANKS 16					; 16 banks
.ROMGBCONLY                     ; Writes $C0 ("GBC only") into $0143 (CGB flag)
.COMPUTEGBCOMPLEMENTCHECK       ; Computes the ROM complement check ($014D)
.COMPUTEGBCHECKSUM              ; Computes the ROM checksum ($014E-$014F)

.BACKGROUND "baserom.gb"        ; This loads the ROM so we can write directly into it

; Free space:
.UNBACKGROUND $3DB0 $3FDF       ; Bank $00
.UNBACKGROUND $4DF0 $7FDF       ; Bank $01
.UNBACKGROUND $B910 $BFFF       ; Bank $02
.UNBACKGROUND $FED0 $FFDF       ; Bank $03
.UNBACKGROUND $13640 $13FFF		; Bank $04
.UNBACKGROUND $17AC0 $17FFF		; Bank $05
.UNBACKGROUND $1A740 $1A7FF		; Bank $06
.UNBACKGROUND $1BDF0 $1BFFF		; "
.UNBACKGROUND $1DBA0 $1FFFF		; Bank $07
.UNBACKGROUND $22FB0 $23FDF		; Bank $08
.UNBACKGROUND $274A0 $27FFF		; Bank $09
.UNBACKGROUND $2B4F0 $2BFDF		; Bank $0A
.UNBACKGROUND $2E8B0 $2FFDF		; Bank $0B
.UNBACKGROUND $33CF0 $33FFF		; Bank $0C
.UNBACKGROUND $379C0 $37FFF		; Bank $0D
.UNBACKGROUND $3BF60 $3BFFF		; Bank $0E
.UNBACKGROUND $3DFC0 $3FFDF		; Bank $0F

; Includes:
.include "definitions.asm"		; Definitions
.include "macros.asm"			; Macros
.include "sprites.asm"			; Sprites


; ***************
; ***MAIN CODE***
; ***************


.BANK 0 SLOT 0
.SECTION "BasicFunctions" FREE
	; **SET BACKGROUND PALETTES**
	; Writes $40 bytes located at HL to the BG Palette.
	
 SET_BGPAL:
	ld a,$80			; Set index to first color + auto-increment
	ldh (<BCPS),a		
	ld b,64				; 64=0x40 bytes
	
	; Checks if $FF69 is accessible:
 LoopBGPAL:
	WAITBLANK
	
	; Sets BG Palettes:
	ldi a,(hl)
	ldh (<BCPD),a
	dec b
	jr nz,LoopBGPAL
	ret

	; **SET SPRITE PALETTES**
	; Same as before but with the Sprites/OBJ Palette.
	
 SET_OBJPAL:
	ld a,$80			; Set index to first color + auto-increment
	ldh (<OCPS),a	; 
	ld b,64				; 64=0x40 bytes
	
	; Checks if $FF69 is accessible:
 LoopOBJPAL:
	WAITBLANK
	
	; Sets OBJ Palettes:
	ldi a,(hl)
	ldh (<OCPD),a
	dec b
	jr nz,LoopOBJPAL
	ret
.ENDS


.BANK 0 SLOT 0
.ORG $0171
.SECTION "DxInitHook" OVERWRITE
	call DxInit
.ENDS

.BANK $05 SLOT 1
.SECTION "DxInit" FREE
 DxInit:
	push hl
	ld hl,InitBGPal
	call SET_BGPAL
	ld hl,InitOBJPal
	call SET_OBJPAL
	pop hl
	call $4B30	; Replaced code
	ret

 InitBGPal:		.INCBIN "palettes/level01.pal"
.ENDS
