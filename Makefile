all: build test

build:
	./leg times.leg > times.c
	cc *.c -o times

test:
	@./test.sh
