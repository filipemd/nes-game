; Header NES 2.0
.segment "HEADER"
    .byte "NES", $1A ; Indentificação

    .byte $02		; Quatidade de ROM de programa em unidades de 16kB
	.byte $01		; Quatidade de ROM de sprites em unidades de 16kB
	.byte $00		; Mapper e espelhamento

    ; Não precisamos disso agora
	.byte $00, $00, $00, $00
	.byte $00, $00, $00, $00, $00
.segment "ZEROPAGE"
    buttons:    .res 1 ; Controle
    frame:      .res 1 ; Frame
    player_x:
        .res 1
    player_y:
        .res 1
    player_frame:
        .res 1
.segment "STARTUP"
    .include "main.s"
.segment "VECTORS"
    .word nmi
    .word reset
    ; Outros são para interrupção de hardware
.segment "CHARS"
    .incbin "../char.chr"