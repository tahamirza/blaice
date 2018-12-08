blaice: blaice.pas
	fpc -Miso $^

blaice.pas: $(wildcard src/*.pas)
	cat src/*.pas > blaice.pas
