; Hardware definitions

.DEFINE LCDC $FF40				; LCD Control
.DEFINE STAT $FF41				; LCDC Status
.DEFINE VBK	$FF4F				; VRAM Bank
.DEFINE SVBK $FF70				; WRAM Bank
.DEFINE BCPS $FF68				; Background Palette Index (GBC)
.DEFINE BCPD $FF69				; Background Palette Data (GBC)
.DEFINE OCPS $FF6A				; Sprite Palette Index (GBC)
.DEFINE OCPD $FF6B				; Sprite Palette Data (GBC)

; Constants
.DEFINE PALSIZE					$40
.DEFINE CHANGE_BANK				$2100

; Definitions
.DEFINE wCurrentBank			$D02C