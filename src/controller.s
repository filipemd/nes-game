; Este código não é meu, é uma versão adaptada do código do NESHacker.

.proc read_controller
  ; Initialize the output memory
  lda #1
  sta buttons

  ; Send the latch pulse down to the 4021
  sta $4016
  lda #0
  sta $4016

  ; Read the buttons from the data line
@read_loop:
    lda $4016
    lsr a
    rol buttons
    bcc @read_loop

rts
.endproc