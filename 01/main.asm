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

.UNBACKGROUND $3DB0 $3FDF       ; Free space in bank $00
.UNBACKGROUND $4DF0 $7FDF       ; Free space in bank $01
.UNBACKGROUND $B910 $BFFF       ; Free space in bank $02
.UNBACKGROUND $FED0 $FFDF       ; Free space in bank $03
; ...