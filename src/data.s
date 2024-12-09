ANIMATION_SIZE = 2

palletedata:
	.byte $28, $19, $09, $29, 	$00, $0A, $15, $01, 	$00, $29, $28, $27, 	$00, $34, $24, $14 	;background palettes
	.byte $28, $37, $18, $1d, 	$00, $0F, $11, $30, 	$00, $0F, $30, $27, 	$00, $3C, $2C, $1C 	;sprite palettes

spritedata:
    ;Y, SPRITE NUM, attributes, X
    ;76543210
    ;||||||||
    ;||||||++- Palette (4 to 7) of sprite
    ;|||+++--- Unimplemented
    ;||+------ Priority (0: in front of background; 1: behind background)
    ;|+------- Flip sprite horizontally
    ;+-------- Flip sprite vertically

    ; Personagem
    .byte $00, $01, %00000000, $00    
    .byte $08, $11, %00000000, $00

    .byte $00, $01, %01000000, $08
    .byte $08, $11, %01000000, $08

player_animation:
    ; Número do sprite, atributos

    ; Frame 1-4: Jogador para baixo
    ; Frame 1
    .byte $01, %00000000
    .byte $11, %00000000
    .byte $01, %01000000
    .byte $11, %01000000
    ; Frame 2
    .byte $02, %00000000
    .byte $12, %00000000
    .byte $03, %00000000
    .byte $13, %00000000
    ; Frame 3
    .byte $01, %00000000
    .byte $11, %00000000
    .byte $01, %01000000
    .byte $11, %01000000
    ; Frame 4
    .byte $03, %01000000
    .byte $13, %01000000
    .byte $02, %01000000
    .byte $12, %01000000

    ; Frame 5-8: Jogador para cima
    ; Frame 5
    .byte $04, %00000000
    .byte $14, %00000000
    .byte $04, %01000000
    .byte $14, %01000000
    ; Frame 6
    .byte $05, %00000000
    .byte $15, %00000000
    .byte $06, %00000000
    .byte $16, %00000000
    ; Frame 7
    .byte $04, %00000000
    .byte $14, %00000000
    .byte $04, %01000000
    .byte $14, %01000000
    ; Frame 8
    .byte $06, %01000000
    .byte $16, %01000000
    .byte $05, %01000000
    .byte $15, %01000000

    ; Frame 9-12: Jogador para esquerda
    ; Frame 9
    .byte $07, %00000000
    .byte $17, %00000000
    .byte $08, %00000000
    .byte $18, %00000000
    ; Frame 10
    .byte $09, %00000000
    .byte $19, %00000000
    .byte $0A, %00000000
    .byte $1A, %00000000
    ; Frame 11
    .byte $07, %00000000
    .byte $17, %00000000
    .byte $08, %00000000
    .byte $18, %00000000
    ; Frame 12
    .byte $0B, %00000000
    .byte $1B, %00000000
    .byte $0C, %00000000
    .byte $1C, %00000000

    ; Frame 13-16: Jogador para direita
    ; Frame 13
    .byte $08, %01000000
    .byte $18, %01000000
    .byte $07, %01000000
    .byte $17, %01000000
    ; Frame 14
    .byte $0A, %01000000
    .byte $1A, %01000000
    .byte $09, %01000000
    .byte $19, %01000000
    ; Frame 15
    .byte $08, %01000000
    .byte $18, %01000000
    .byte $07, %01000000
    .byte $17, %01000000
    ; Frame 12
    .byte $0C, %01000000
    .byte $1C, %01000000
    .byte $0B, %01000000
    .byte $1B, %01000000