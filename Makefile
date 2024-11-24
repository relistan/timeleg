all: build test

build:
	./leg times.leg > times.c
	cc times.c -o times

test:
	@./test.sh
