PLAYER = $200
SPRITE_SIZE = $4

.include "player.s"
.include "controller.s"

reset:
    sei        ; ignore IRQs
    cld        ; disable decimal mode
    ldx #$40
    stx $4017  ; disable APU frame IRQ
    ldx #$ff
    txs        ; Set up stack
    inx        ; now X = 0
    stx $2000  ; disable NMI
    stx $2001  ; disable rendering
    stx $4010  ; disable DMC IRQs

    ; Optional (omitted):
    ; Set up mapper and jmp to further init code here.

    ; The vblank flag is in an unknown state after reset,
    ; so it is cleared here to make sure that @vblankwait1
    ; does not exit immediately.
    bit $2002

    ; First of two waits for vertical blank to make sure that the
    ; PPU has stabilized
    @vblankwait1:  
        bit $2002
        bpl @vblankwait1

        ; We now have about 30,000 cycles to burn before the PPU stabilizes.
        ; One thing we can do with this time is put RAM in a known state.
        ; Here we fill it with $00, which matches what (say) a C compiler
        ; expects for BSS.  Conveniently, X is still 0.
        txa
    @clrmem:
        sta $000,x
        sta $100,x
        sta $200,x
        sta $300,x
        sta $400,x
        sta $500,x
        sta $600,x
        sta $700,x
        inx
        bne @clrmem

    ; Other things you can do between vblank waits are set up audio
    ; or set up other mapper registers.
   
    @vblankwait2:
        bit $2002
        bpl @vblankwait2

    ; Reserva o espaço dos sprites
    lda $02
    sta $4014

    nop

    lda #$3F
    sta $2006
    lda #$00
    sta $2006

    ldx #$00
    @loadpalletes:
        lda palletedata, x
        sta $2007 ; $3F00, $3F01, $3F02 => $3F1F
        inx
        cpx #$20
        bne @loadpalletes
    ldx #$10 ; 16bytes (4 bytes por sprite, 8 sprites total)
    @loadsprites:
        lda spritedata, x
        sta $0200, x
        dex
        bne @loadsprites
    @loadbackground:
        lda $2002		;read PPU status to reset high/low latch
        lda #$21
        sta $2006
        lda #$00
        sta $2006

        ldy #$FF
        ldx #$10

        ; Plano de fundo apenas com grama
        @background_loop:
            sta $2007
            dey
            bne @background_loop
            dex
            bne @background_loop
    
    ; Reseta o scroll
	lda #$00
	sta $2005
	sta $2005	

    cli ; Desativa interrupts

    lda #%10010000 ; enable NMI change background to use second chr set of tiles ($1000)
    sta $2000 ; Roda NMI no V-Blank

    ; Mostra sprites e plano de fundo
    lda #%00011110
    sta $2001

    jsr start_player

    @loop:
        jmp @loop

nmi:
    lda #$02          ; Load 0x02 into A (sprite range)
    sta $4014         ; Write to DMA register (OAM sprite transfer)

    jsr read_controller
    jsr update_player

    inc frame
    
    rti                ; Return from interrupt

.include "data.s"