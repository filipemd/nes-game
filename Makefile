NAME = game

CA65 = ca65
LD65 = ld65

FLAGS = -t nes

all:
	$(CA65) src/cart.s -o src/cart.o -t nes
	$(LD65) src/cart.o -o game.nes -t nes

clean:
	rm game.nes src/cart.o