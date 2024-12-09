PLAYER_X = PLAYER + 3 ; Posição X do jogador
PLAYER_Y = PLAYER ; Posição Y do jogador

.proc start_player
    lda #$72 ; ~~Metade da tela menos metade do tamanho do jogador~~. Número escolhido totalmente a olho
    sta player_x
    sta player_y

    jsr draw_player

    rts
.endproc

.proc update_player
    lda buttons ; Carrega a variável do botão

    ; Direita
    and #%00000001     
    beq @check_left
    inc player_x

    ldx #$0E
    ldy #$0C
    jsr animate_player

    jsr draw_player  ; Atualiza a posição do jogador
    rts

    @check_left:
        lda buttons  
        and #%00000010 
        beq @check_down
        dec player_x

        ldx #$0A
        ldy #$08
        jsr animate_player

        jsr draw_player  ; Atualiza a posição do jogador
        rts
    @check_down:
        lda buttons
        and #%00000100
        beq @check_up  
        inc player_y

        ldx #$02
        ldy #$00
        jsr animate_player

        jsr draw_player  ; Atualiza a posição do jogador
        rts
    @check_up:
        lda buttons
        and #%00001000     
        beq @end
        dec player_y

        ldx #$06
        ldy #$04
        jsr animate_player
        
        jsr draw_player
    @end: 
    rts
.endproc

; Atualiza as posições dos sprites do jogador
.proc draw_player
    ; Carrega as posições iniciais de X e Y
    ldx player_x
    ldy player_y

    ; Atualiza a posição X para os sprites 1 e 2
    stx PLAYER_X           ; Sprite 1
    stx PLAYER_X + SPRITE_SIZE ; Sprite 2

    ; Atualiza a posição Y para os sprites 1 e 3
    sty PLAYER_Y           ; Sprite 1
    sty PLAYER_Y + SPRITE_SIZE*2 ; Sprite 3

    ; Adiciona 8 ao valor de X (para mover os sprites à direita)
    lda player_x
    clc
    adc #8
    tax                   ; Atualiza o valor de X no registrador X

    ; Adiciona 8 ao valor de Y (para mover os sprites para baixo)
    lda player_y
    clc
    adc #8
    tay                   ; Atualiza o valor de Y no registrador Y

    ; Atualiza a posição X para os sprites 3 e 4
    stx PLAYER_X + SPRITE_SIZE*2 ; Sprite 3
    stx PLAYER_X + SPRITE_SIZE*3 ; Sprite 4

    ; Atualiza a posição Y para os sprites 2 e 4
    sty PLAYER_Y + SPRITE_SIZE   ; Sprite 2
    sty PLAYER_Y + SPRITE_SIZE*3 ; Sprite 4

    jsr update_frame

    rts 
.endproc

.proc update_frame
    lda player_frame
    ; Isto multiplica por 8 por meio de shift-rights
    asl A
    asl A
    asl A
    tax

    lda player_animation, X 
    sta PLAYER+1
    lda player_animation+1, X 
    sta PLAYER+2

    lda player_animation+ANIMATION_SIZE, X 
    sta PLAYER+1+SPRITE_SIZE
    lda player_animation+1+ANIMATION_SIZE, X 
    sta PLAYER+2+SPRITE_SIZE

    lda player_animation+ANIMATION_SIZE*2, X 
    sta PLAYER+1+SPRITE_SIZE*2
    lda player_animation+1+ANIMATION_SIZE*2, X 
    sta PLAYER+2+SPRITE_SIZE*2
    
    lda player_animation+ANIMATION_SIZE*3, X 
    sta PLAYER+1+SPRITE_SIZE*3
    lda player_animation+1+ANIMATION_SIZE*3, X 
    sta PLAYER+2+SPRITE_SIZE*3

    rts
.endproc

.proc animate_player
    ; Se o frame não for múltiplo de 4, não faz nada
    lda frame
    and #%00000111
    bne @end

    ; Vê se player_frame é menor que Y
    cpy player_frame
    beq @inc_frame
    bcs @reset_frame ; Se for, player_frame=Y

    ; Vê se player_frame é maior que X
    cpx player_frame
    bcc @reset_frame ; Se for, player_frame=Y

    @inc_frame:
        inc player_frame
        rts

    @reset_frame:
        sty player_frame
    @end:
        rts
.endproc
